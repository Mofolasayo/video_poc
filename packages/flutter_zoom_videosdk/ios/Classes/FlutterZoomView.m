#import <ZoomVideoSDK/ZoomVideoSDK.h>
#import "FlutterZoomView.h"
#import "FlutterZoomVideoSdkUser.h"
#import "FlutterZoomVideoSdkAnnotationHelper.h"
#import "JSONConvert.h"
#import "SDKPiPHelper.h"
#import "SDKCallKitManager.h"

@implementation FlutterZoomView {
    ZoomView *_view;
}

- (instancetype)initWithFrame:(CGRect)frame
                viewIdentifier:(int64_t)viewId
                arguments:(id _Nullable)args
                registrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  if (self = [super init]) {
    _view = [[ZoomView alloc] initWithFrame: frame];
    _view.backgroundColor = [UIColor blackColor];

    NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:args];
    if (dictionary[@"videoAspect"]) {
        [_view setVideoAspect: dictionary[@"videoAspect"]];
    }
    if (dictionary[@"userId"]) {
        [_view setUserId: dictionary[@"userId"]];
    }
    if (dictionary[@"sharing"]) {
        [_view setSharing: [dictionary[@"sharing"] boolValue]];
    }
    if (dictionary[@"isPiPView"]) {
      [_view setIsPiPView: [dictionary[@"isPiPView"] boolValue]];
    }
    if (dictionary[@"preview"]) {
        [_view setPreview: [dictionary[@"preview"] boolValue]];
    }
    if (dictionary[@"hasMultiCamera"]) {
        [_view setHasMultiCamera: [dictionary[@"hasMultiCamera"] boolValue]];
    }
    if (dictionary[@"resolution"]) {
        [_view setVideoResolution:dictionary[@"resolution"]];
    }

  }
  return self;
}

- (UIView*)view {
  return _view;
}

@end


@implementation ZoomView {
    NSString* userId;
    BOOL sharing;
    BOOL preview;
    BOOL hasMultiCamera;
    BOOL isPiPView;
    NSString* multiCameraIndex;
    ZoomVideoSDKVideoAspect videoAspect;
    ZoomVideoSDKVideoCanvas* currentCanvas;
    ZoomVideoSDKVideoResolution videoResolution;
    ZoomVideoSDKAnnotationHelper* helper;
    CGSize lastLayoutSize;
    NSTimer* debounceTimer;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        userId = @"";
        sharing = NO;
        preview = NO;
        hasMultiCamera = NO;
        isPiPView = NO;
        multiCameraIndex = @"";
        videoAspect = ZoomVideoSDKVideoAspect_Original;
        currentCanvas = nil;
        videoResolution = ZoomVideoSDKVideoResolution_Auto;
        helper = nil;
        lastLayoutSize = CGSizeZero;
        debounceTimer = nil;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (!CGSizeEqualToSize(self.bounds.size, lastLayoutSize)) {
        lastLayoutSize = self.bounds.size;
        if (currentCanvas != nil) {
            [self setViewingCanvas];
        }
    }
}

- (void)setUserId:(NSString*)newUserId {
    if ([userId isEqualToString:newUserId]) {
        return;
    }
    userId = newUserId;
    [self setViewingCanvas];
}

- (void)setSharing:(BOOL)newSharing {
    if (sharing == newSharing) {
        return;
    }
    sharing = newSharing;
    [self setViewingCanvas];
}

- (void)setIsPiPView:(BOOL)newIsPiPView {
    if (isPiPView == newIsPiPView) {
        return;
    }
    if (newIsPiPView) {
        [[SDKPiPHelper shared] presetPiPWithSrcView:self];
        [[SDKCallKitManager sharedManager] startCallWithHandle:@"<Your Email>" complete:^{
            NSLog(@" ----CallKitManager startCall Complete ------");
            [[SDKPiPHelper shared] presetPiPWithSrcView:self];
        }];
    } else {
        [[SDKPiPHelper shared] cleanUpPictureInPicture];
    }
    isPiPView = newIsPiPView;
    [self setViewingCanvas];
}

- (void)setVideoAspect:(NSString*)newVideoAspect {
    ZoomVideoSDKVideoAspect aspect = [JSONConvert ZoomVideoSDKVideoAspect: newVideoAspect];
    if (videoAspect == aspect) {
        return;
    }
    videoAspect = aspect;
    [self setViewingCanvas];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview == nil) {
        if (debounceTimer != nil) {
            [debounceTimer invalidate];
            debounceTimer = nil;
        }
        if (currentCanvas != nil) {
            [currentCanvas unSubscribeWithView: self];
        }
    }
}

- (void)setHasMultiCamera:(BOOL)newHasMultiCamera {
    if (hasMultiCamera == newHasMultiCamera) {
        return;
    }
    hasMultiCamera = newHasMultiCamera;
    [self setViewingCanvas];
}

- (void)setMultCameraIndex:(NSString*)newIndex {
    if (multiCameraIndex == newIndex) {
        return;
    }
    multiCameraIndex = newIndex;
}

- (void)setPreview: (BOOL)newPreview {
    if (preview == newPreview) {
        return;
    }
    preview = newPreview;

    ZoomVideoSDKVideoHelper* videoHelper = [[ZoomVideoSDK shareInstance] getVideoHelper];
    if (preview == YES) {
        [videoHelper startVideoCanvasPreview: self andAspectMode: videoAspect];
    } else {
        [videoHelper stopVideoCanvasPreview: self];
    }
}

- (void)setVideoResolution:(NSString*)newVideoResolution {
    ZoomVideoSDKVideoResolution resolution = [JSONConvert ZoomVideoSDKVideoResolution: newVideoResolution];
    if (videoResolution == resolution) {
        return;
    }
    videoResolution = resolution;
    [self setViewingCanvas];
}

- (void)setViewingCanvas {
    if (debounceTimer != nil) {
        [debounceTimer invalidate];
        debounceTimer = nil;
    }

    NSDictionary *capturedState = @{
        @"userId": userId ?: @"",
        @"sharing": @(sharing),
        @"isPiPView": @(isPiPView),
        @"hasMultiCamera": @(hasMultiCamera),
        @"multiCameraIndex": multiCameraIndex ?: @"",
        @"videoAspect": @(videoAspect),
        @"videoResolution": @(videoResolution)
    };

    // Schedule a new debounced call to avoid hitting rate limits
    debounceTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                     target:self
                                                   selector:@selector(setViewingCanvasImmediately:)
                                                   userInfo:capturedState
                                                    repeats:NO];
    NSLog(@"Scheduled debounced setViewingCanvas for userId= %@", userId);
}

- (void)setViewingCanvasImmediately:(NSTimer*)timer {
    debounceTimer = nil;

    // Extract captured state from timer
    NSDictionary *capturedState = timer.userInfo;
    NSString *capturedUserId = capturedState[@"userId"];
    BOOL capturedSharing = [capturedState[@"sharing"] boolValue];
    BOOL capturedIsPiPView = [capturedState[@"isPiPView"] boolValue];
    BOOL capturedHasMultiCamera = [capturedState[@"hasMultiCamera"] boolValue];
    NSString *capturedMultiCameraIndex = capturedState[@"multiCameraIndex"];
    ZoomVideoSDKVideoAspect capturedVideoAspect = [capturedState[@"videoAspect"] intValue];
    ZoomVideoSDKVideoResolution capturedVideoResolution = [capturedState[@"videoResolution"] intValue];

    NSLog(@"Executing setViewingCanvas for captured userId= %@", capturedUserId);

    if (currentCanvas != nil) {
        [currentCanvas unSubscribeWithView:self];
        currentCanvas = nil;
    }

    if (capturedVideoResolution == 0) {
        capturedVideoResolution = ZoomVideoSDKVideoResolution_Auto;
    }

    // Get the user with captured userId
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:capturedUserId];
    // Get myself
    ZoomVideoSDKUser* mySelf = [[[ZoomVideoSDK shareInstance] getSession] getMySelf];

    // Get the canvas using captured state
    if (capturedSharing) {
        if ([user getUserID] != [mySelf getUserID]) {
            for (ZoomVideoSDKShareAction * shareAction in [user getShareActionList]) {
                if ([shareAction getShareStatus] == ZoomVideoSDKReceiveSharingStatus_Start) {
                    currentCanvas = [shareAction getShareCanvas];
                    break;
                }
            }
            [[SDKPiPHelper shared] updatePiPVideoUser:user videoType:ZoomVideoSDKVideoType_ShareData];
        } else {
            currentCanvas = [user getVideoCanvas];
        }
    } else {
        [[SDKPiPHelper shared] updatePiPVideoUser:user videoType:ZoomVideoSDKVideoType_VideoData];

        if (capturedHasMultiCamera) {
            NSArray < ZoomVideoSDKVideoCanvas * >
            *multiCameraList = [user getMultiCameraCanvasList];
            NSInteger index = [capturedMultiCameraIndex integerValue];
            currentCanvas = multiCameraList[index];
        } else {
            currentCanvas = [user getVideoCanvas];
        }
    }

    if (capturedIsPiPView) {
        [currentCanvas subscribeWithPiPView:self aspectMode:capturedVideoAspect andResolution:capturedVideoResolution];
    } else {
        [currentCanvas subscribeWithView:self aspectMode:capturedVideoAspect andResolution:capturedVideoResolution];
    }
    bool annotationEnable = [[[ZoomVideoSDK shareInstance] getShareHelper] isAnnotationFeatureSupport];
    if (capturedSharing && annotationEnable && (helper == nil)) {
        helper = [[[ZoomVideoSDK shareInstance] getShareHelper] createAnnotationHelper:self];
        [[FlutterZoomVideoSdkAnnotationHelper alloc] setAnnotationHelper:helper];
    }
}
@end
