#import "FlutterZoomVideoSdkWhiteboardHelper.h"
#import "JSONConvert.h"

@interface FlutterZoomVideoSdkWhiteboardHelper ()

@property(nonatomic, strong) NSArray<NSLayoutConstraint *> *wbActiveConstraints;
@property (nonatomic, strong) UIViewController *wbContainerVC;
@property(nonatomic, assign) BOOL wbContainerAttached;
@end

@implementation FlutterZoomVideoSdkWhiteboardHelper

- (ZoomVideoSDKWhiteboardHelper *)getWhiteboardHelper {
    ZoomVideoSDKWhiteboardHelper* whiteboardHelper = nil;
    @try {
        whiteboardHelper = [[ZoomVideoSDK shareInstance] getWhiteboardHelper];
        if (whiteboardHelper == nil) {
            NSException *e = [NSException exceptionWithName:@"NoWhiteboardHelperFound" reason:@"No Whiteboard Helper Found" userInfo:nil];
            @throw e;
        }
    } @catch (NSException *e) {
        NSLog(@"%@ - %@", e.name, e.reason);
    }
    return whiteboardHelper;
}

- (void) wBSetContainerLayout:(CGRect)rectPx topVc:(UIViewController *)topVC
{
    if (!topVC) return;

    // Ensure VC exists
    if (!self.wbContainerVC) {
        self.wbContainerVC = [UIViewController new];
    }

    UIView *parent = topVC.view;
    UIView *view   = self.wbContainerVC.view;
    if (!parent || !view) return;

    view.backgroundColor = UIColor.clearColor;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    parent.clipsToBounds = YES;
    view.clipsToBounds   = YES;

    // If attached to a different parent or not attached, (re)attach correctly
    BOOL needsReattach =
        (view.superview != parent) ||
        (self.wbContainerVC.parentViewController != topVC);

    if (needsReattach) {
        // Clean old constraints if any
        if (self.wbActiveConstraints.count) {
            [NSLayoutConstraint deactivateConstraints:self.wbActiveConstraints];
            self.wbActiveConstraints = @[];
        }

        // Detach from previous parent if any
        if (self.wbContainerVC.parentViewController) {
            [self.wbContainerVC willMoveToParentViewController:nil];
            [view removeFromSuperview];
            [self.wbContainerVC removeFromParentViewController];
        }

        // Attach to new parent
        [topVC addChildViewController:self.wbContainerVC];
        [parent addSubview:view];
        [self.wbContainerVC didMoveToParentViewController:topVC];

        self.wbContainerAttached = YES; // optional, but keep consistent
    }

    // Replace constraints
    if (self.wbActiveConstraints.count) {
        [NSLayoutConstraint deactivateConstraints:self.wbActiveConstraints];
    }

    UILayoutGuide *safe = parent.safeAreaLayoutGuide;

    CGFloat x = rectPx.origin.x;
    CGFloat y = rectPx.origin.y;
    CGFloat w = MAX(0, rectPx.size.width);
    CGFloat h = MAX(0, rectPx.size.height);

    NSArray<NSLayoutConstraint *> *cs = @[
        [view.leadingAnchor constraintEqualToAnchor:safe.leadingAnchor constant:x],
        [view.topAnchor constraintEqualToAnchor:safe.topAnchor constant:y],
        [view.widthAnchor constraintEqualToConstant:w],
        [view.heightAnchor constraintEqualToConstant:h],
    ];

    [NSLayoutConstraint activateConstraints:cs];
    self.wbActiveConstraints = cs;
}

- (UIViewController*) currentFlutterViewController {
    UIWindow *keyWindow = nil;
    
    for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
        if (scene.activationState == UISceneActivationStateForegroundActive) {
            // Prefer the keyWindow of this scene (if any), otherwise the first window
            for (UIWindow *window in scene.windows) {
                if (window.isKeyWindow) {
                    keyWindow = window;
                    break;
                }
            }
            if (!keyWindow) {
                keyWindow = scene.windows.firstObject;
            }
            break;
        }
    }

    if (!keyWindow) {
        return nil; // no active scene/window
    }

    UIViewController *top = keyWindow.rootViewController;
    while (top.presentedViewController) {
        top = top.presentedViewController;
    }

    if ([top isKindOfClass:[FlutterViewController class]]) {
        return (FlutterViewController *)top;
    }
    return nil;
}

-(void) subscribeWhiteboard:(FlutterMethodCall *)call withResult:(FlutterResult) result
{
    dispatch_async(dispatch_get_main_queue(), ^{
        double fx = [call.arguments[@"x"] doubleValue];
        double fy = [call.arguments[@"y"] doubleValue];
        double fw = [call.arguments[@"width"] doubleValue];
        double fh = [call.arguments[@"height"] doubleValue];

        UIViewController *topVC = [self currentFlutterViewController];

        CGRect rect = CGRectMake(fx,fy,fw,fh);
        [self wBSetContainerLayout:rect topVc: topVC];
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getWhiteboardHelper] subscribeWhiteboard: self.wbContainerVC])]);
    });
}

-(void) unSubscribeWhiteboard: (FlutterResult) result
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.wbContainerVC) {
            if (self.wbActiveConstraints.count) {
                [NSLayoutConstraint deactivateConstraints:self.wbActiveConstraints];
                self.wbActiveConstraints = @[];
            }
            [self.wbContainerVC willMoveToParentViewController:nil];
            [self.wbContainerVC.view removeFromSuperview];
            [self.wbContainerVC removeFromParentViewController];
            self.wbContainerVC = nil;
            self.wbContainerAttached = NO; // ← important
        }
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getWhiteboardHelper] unSubscribeWhiteboard])]);
    });
}

-(void) canStartShareWhiteboard: (FlutterResult) result
{
    dispatch_async(dispatch_get_main_queue(), ^{
        result(@([[self getWhiteboardHelper] canStartShareWhiteboard]));
    });
}

-(void) startShareWhiteboard: (FlutterResult) result
{
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getWhiteboardHelper] startShareWhiteboard])]);
    });
}

-(void) canStopShareWhiteboard: (FlutterResult) result
{
    dispatch_async(dispatch_get_main_queue(), ^{
        result(@([[self getWhiteboardHelper] canStopShareWhiteboard]));
    });
}

-(void) stopShareWhiteboard: (FlutterResult) result
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.wbContainerVC) {
            if (self.wbActiveConstraints.count) {
                [NSLayoutConstraint deactivateConstraints:self.wbActiveConstraints];
                self.wbActiveConstraints = @[];
            }
            [self.wbContainerVC willMoveToParentViewController:nil];
            [self.wbContainerVC.view removeFromSuperview];
            [self.wbContainerVC removeFromParentViewController];
            self.wbContainerVC = nil;
            self.wbContainerAttached = NO; // ← important
        }
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getWhiteboardHelper] stopShareWhiteboard])]);
    });
}

-(void) isOtherSharingWhiteboard: (FlutterResult) result
{
    dispatch_async(dispatch_get_main_queue(), ^{
        result(@([[self getWhiteboardHelper] isOtherSharingWhiteboard]));
    });
}


-(void) exportWhiteboard:(FlutterMethodCall *)call withResult:(FlutterResult) result
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* export = call.arguments[@"exportFormat"];
        ZoomVideoSDKWhiteboardExportFormatType format = [JSONConvert ZoomVideoSDKWhiteboardExportFormatType: export];
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getWhiteboardHelper] exportWhiteboard:format])]);
    });
}

@end
