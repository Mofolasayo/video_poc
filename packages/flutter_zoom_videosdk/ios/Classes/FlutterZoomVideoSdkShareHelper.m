#import <ReplayKit/ReplayKit.h>
#import "FlutterZoomVideoSdkShareHelper.h"
#import "FlutterZoomVideoSdkCameraShareView.h"
#import "JSONConvert.h"

#define kBroadcastPickerTag 10001

@implementation FlutterZoomVideoSdkShareHelper

NSString* appGroupId;

-(instancetype)initWithBundleId:(NSString*)bundleId {
    if (self = [super init]) {
        appGroupId = bundleId;
    }
    return self;
}

- (ZoomVideoSDKShareHelper *)getShareHelper
{
    ZoomVideoSDKShareHelper* shareHelper = nil;

    @try {
        shareHelper = [[ZoomVideoSDK shareInstance] getShareHelper];
        if (shareHelper == nil) {
            NSException *e = [NSException exceptionWithName:@"NoShareFound" reason:@"No Share Found" userInfo:nil];
            @throw e;
        }
    } @catch (NSException *e) {
        NSLog(@"%@ - %@", e.name, e.reason);
    }

    return shareHelper;
}

-(void) shareScreen: (FlutterResult) result
{
    if (@available(iOS 12.0, *)) {
        dispatch_async(dispatch_get_main_queue(), ^{
            RPSystemBroadcastPickerView *broadcastView = [[RPSystemBroadcastPickerView alloc] init];
            broadcastView.preferredExtension = appGroupId;
            broadcastView.tag = kBroadcastPickerTag;

            UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
            [root.view addSubview:broadcastView];
            [self sendTouchDownEventToBroadcastButton];

        });
    } else {
        // Guide page
    }
}

- (void)sendTouchDownEventToBroadcastButton
{
    if (@available(iOS 12.0, *)) {
        UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
        RPSystemBroadcastPickerView *broadcastView = [root.view viewWithTag:kBroadcastPickerTag];
        if (!broadcastView) return;

        
        for (UIView *subView in broadcastView.subviews) {
            if ([subView isKindOfClass:[UIButton class]])
            {
                UIButton *broadcastBtn = (UIButton *)subView;
                [broadcastBtn sendActionsForControlEvents:UIControlEventAllTouchEvents];
                break;
            }
        }
    }
}

-(void) shareView: (FlutterResult) result
{
    // TODO
}

-(void) lockShare:(FlutterMethodCall *)call withResult:(FlutterResult) result
{
    result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getShareHelper] lockShare:[call.arguments[@"lock"] boolValue]])]);
}

-(void) stopShare: (FlutterResult) result
{
    dispatch_async(dispatch_get_main_queue(), ^{
        ZoomVideoSDKSession* session = [[ZoomVideoSDK shareInstance] getSession];
        ZoomVideoSDKUser * mySelf = [session getMySelf];
        NSArray <ZoomVideoSDKShareAction *>* shareActionList = [mySelf getShareActionList];
        for (ZoomVideoSDKShareAction * action in shareActionList) {
            if ([action getShareType] == ZoomVideoSDKShareType_Normal) {
                UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
                RPSystemBroadcastPickerView *broadcastView = [root.view viewWithTag:kBroadcastPickerTag];
                broadcastView.preferredExtension = appGroupId;
                broadcastView.tag = kBroadcastPickerTag;

                [root.view addSubview:broadcastView];
                [self sendTouchDownEventToBroadcastButton];
                break;
            } else {
                result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getShareHelper] stopShare])]);
            }
        }
    });
}

-(void) isOtherSharing: (FlutterResult) result
{
    if ([[self getShareHelper] isOtherSharing]) {
        result(@YES);
    } else {
        result(@NO);
    }
}

-(void) isScreenSharingOut: (FlutterResult) result
{
    if ([[self getShareHelper] isScreenSharingOut]) {
        result(@YES);
    } else {
        result(@NO);
    }
}

-(void) isShareLocked: (FlutterResult) result
{
    if ([[self getShareHelper] isShareLocked]) {
        result(@YES);
    } else {
        result(@NO);
    }
}

-(void) isSharingOut: (FlutterResult) result
{
    if ([[self getShareHelper] isSharingOut]) {
        result(@YES);
    } else {
        result(@NO);
    }
}

-(void) isShareDeviceAudioEnabled: (FlutterResult) result
{
    if ([[self getShareHelper] isShareDeviceAudioEnabled]) {
        result(@YES);
    } else {
        result(@NO);
    }
}

-(void) enableShareDeviceAudio:(FlutterMethodCall *)call withResult:(FlutterResult) result
{
    if ([[self getShareHelper] enableShareDeviceAudio:call.arguments[@"enable"]]) {
        result(@YES);
    } else {
        result(@NO);
    }
}

-(void) isAnnotationFeatureSupport: (FlutterResult) result
{
    if ([[self getShareHelper] isAnnotationFeatureSupport]) {
        result(@YES);
    } else {
        result(@NO);
    }
}

-(void) disableViewerAnnotation:(FlutterMethodCall *)call withResult:(FlutterResult) result
{
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getShareHelper] disableViewerAnnotation:[call.arguments[@"disable"] boolValue]])]);
    });
}

-(void) isViewerAnnotationDisabled: (FlutterResult) result
{
    if ([[self getShareHelper] isViewerAnnotationDisabled]) {
        result(@YES);
    } else {
        result(@NO);
    }
}

-(void) pauseShare:(FlutterResult) result
{
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getShareHelper] pauseShare])]);
    });
}

-(void) resumeShare:(FlutterResult) result
{
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getShareHelper] resumeShare])]);
    });
}

-(void) startShareCamera:(FlutterResult) result
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView* shareCameraView = [[FlutterZoomVideoSdkCameraShareView sharedInstance] shareCameraView];
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getShareHelper] startShareCamera: shareCameraView])]);
    });
}

-(void) setAnnotationVanishingToolTime:(FlutterMethodCall *)call withResult:(FlutterResult) result
{
    NSUInteger displayTime = [call.arguments[@"displayTime"] unsignedIntValue];
    NSUInteger vanishingTime = [call.arguments[@"vanishingTime"] unsignedIntValue];
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getShareHelper] setAnnotationVanishingToolTime: displayTime vanishingTime: vanishingTime])]);
    });
}

-(void) getAnnotationVanishingToolDisplayTime: (FlutterResult) result
{
    dispatch_async(dispatch_get_main_queue(), ^{
        result(@([[self getShareHelper] getAnnotationVanishingToolDisplayTime]));
    });
}

-(void) getAnnotationVanishingToolVanishingTime: (FlutterResult) result
{
    dispatch_async(dispatch_get_main_queue(), ^{
        result(@([[self getShareHelper] getAnnotationVanishingToolVanishingTime]));
    });
}

@end
