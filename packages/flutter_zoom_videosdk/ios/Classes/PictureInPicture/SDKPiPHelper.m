//
//  SDKPiPHelper.m
//  MobileRTCSample
//
//  Created by Zoom on 2023/7/11.
//  Copyright © 2023 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKPiPHelper.h"
#import "SDKCallKitManager.h"

@interface SDKPiPHelper()

@property (nonatomic, weak) UIView *sourceView;

@property (nonatomic, strong, readwrite) ZoomVideoSDKUser *videoUser;
@property (nonatomic, assign, readwrite) ZoomVideoSDKVideoType videoType;

@end

@implementation SDKPiPHelper

SDKPiPHelper *g_pipHelper_instance = nil;

+ (SDKPiPHelper *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_pipHelper_instance = [[SDKPiPHelper alloc] init];
    });
    
    return g_pipHelper_instance;
}

+ (BOOL)isPiPSupported {
#if ENABLE_PIP_FOR_VOIP_MEETING
    if (@available(iOS 15.0, *)) {
        BOOL isInCall = [[SDKCallKitManager sharedManager] isInCall];
        return [AVPictureInPictureController isPictureInPictureSupported] && isInCall;
    } else {
        return NO;
    }
#else
    return NO;
#endif
}

- (instancetype)init {
#if ENABLE_PIP_FOR_VOIP_MEETING
    if (@available(iOS 15.0, *)) {
        if ([AVPictureInPictureController isPictureInPictureSupported]) {
            self = [super init];
            if (self) {
                [[NSNotificationCenter defaultCenter]  addObserver:self
                       selector:@selector(applicationBecomeActiveNotification:)
                           name:UIApplicationDidBecomeActiveNotification
                         object:nil];
                [[NSNotificationCenter defaultCenter]  addObserver:self
                       selector:@selector(applicationResignActiveNotification:)
                           name:UIApplicationWillResignActiveNotification
                         object:nil];
            }
            return self;
        } else {
            return  nil;
        }
    } else {
        return nil;
    }
#else
    return nil;
#endif
}

- (void)dealloc {
    [self cleanUp];
}

- (void)presetPiPWithSrcView:(UIView*)sourceView {
#if ENABLE_PIP_FOR_VOIP_MEETING
    if (@available(iOS 15.0, *)) {
        if (![self.class isPiPSupported] || !sourceView) {
            return;
        }
        
        [self cleanUp];
        
        _pipVideoCallViewCtrl = [[AVPictureInPictureVideoCallViewController alloc] init];
        _pipVideoCallViewCtrl.view.backgroundColor = [UIColor blackColor];
        
        CGRect defRect = (CGRect){CGPointZero, CGSizeMake(280, 210)};
        [_pipVideoCallViewCtrl.view setBounds:defRect];
        
        _pipVideoView = [[SDKPiPWindowView alloc] initWithFrame:defRect];
        [_pipVideoView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        
        [_pipVideoCallViewCtrl.view addSubview:_pipVideoView];
        
        
        _pipVideoCallViewCtrl.preferredContentSize = CGSizeMake(_pipVideoView.frame.size.width, _pipVideoView.frame.size.height);
        
        _pipContentSource =  [[AVPictureInPictureControllerContentSource alloc] initWithActiveVideoCallSourceView:sourceView contentViewController:_pipVideoCallViewCtrl];
        
        _pipController = [[AVPictureInPictureController alloc] initWithContentSource:_pipContentSource];
        _pipController.canStartPictureInPictureAutomaticallyFromInline = YES;
        _pipController.delegate = self;
        
        if (sourceView != _sourceView) self.sourceView = sourceView;
        
        NSLog(@" ----SDKPiPHelper---- presetPiPWithSrcView:%@", sourceView);
    }
#endif
}


- (void)cleanUp {
#if ENABLE_PIP_FOR_VOIP_MEETING
    if (_pipVideoView) {
        _pipVideoView = nil;
    }
    if (@available(iOS 15.0, *)) {
        if (_pipVideoCallViewCtrl) {
            _pipVideoCallViewCtrl = nil;
        }
        
        if (_pipContentSource) {
            _pipContentSource = nil;
        }
        
        if (_pipController) {
            _pipController.delegate = nil;
            _pipController = nil;
        }
    }
#endif
}

- (void)applicationBecomeActiveNotification:(NSNotification *)aNotification {
    if (@available(iOS 15.0, *)) {
        [self cleanUpPictureInPicture];
        
        if ([self.class isPiPSupported]) {
            [self presetPiPWithSrcView:self.sourceView];
        }
    }
}

- (void)applicationResignActiveNotification:(NSNotification *)aNotification {
    if (@available(iOS 15.0, *)) {
        [self startPiPMode];
    }
}

- (BOOL)isInPiPMode {
    if (_pipController) {
        return _pipController.pictureInPictureActive || _pipController.isPictureInPictureSuspended;
    }
    return NO;
}

- (void)startPiPMode {
#if ENABLE_PIP_FOR_VOIP_MEETING
    if ([self.class isPiPSupported] && ![self isInPiPMode] && self.videoUser && self.videoType > 0) {
        if (_pipVideoView) [_pipVideoView startShowActive:self.videoUser videoType:self.videoType];
    }
#endif
}

- (void)cleanUpPictureInPicture {
#if ENABLE_PIP_FOR_VOIP_MEETING
    if (_pipController) {
        [_pipController stopPictureInPicture];
        if (_pipVideoView) [_pipVideoView stopShowActive];
        [self cleanUp];
    }
#endif
}

- (void)updatePiPVideoUser:(ZoomVideoSDKUser *)user videoType:(ZoomVideoSDKVideoType)type {
#if ENABLE_PIP_FOR_VOIP_MEETING
    self.videoUser = user;
    self.videoType = type;
    if ([self.class isPiPSupported] && [self isInPiPMode] && self.videoUser && self.videoType > 0) {
        if (_pipVideoView) [_pipVideoView startShowActive:self.videoUser videoType:self.videoType];
    }
#endif
}

#pragma mark -- AVPictureInPictureControllerDelegate
#if defined(__IPHONE_9_0)
// Delegate can implement this method to be notified when Picture in Picture will start.
- (void)pictureInPictureControllerWillStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController API_AVAILABLE(ios(15.0)) {
}

//Delegate can implement this method to be notified when Picture in Picture did start.
- (void)pictureInPictureControllerDidStartPictureInPicture:(AVPictureInPictureController *)pictureInPictureController API_AVAILABLE(ios(15.0)) {
}


//Delegate can implement this method to be notified when Picture in Picture failed to start.
- (void)pictureInPictureController:(AVPictureInPictureController *)pictureInPictureController failedToStartPictureInPictureWithError:(NSError *)error  API_AVAILABLE(ios(15.0)){
}

//Delegate can implement this method to be notified when Picture in Picture will stop.
- (void)pictureInPictureControllerWillStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController  API_AVAILABLE(ios(15.0)) {
}

//Delegate can implement this method to be notified when Picture in Picture will stop.
- (void)pictureInPictureControllerDidStopPictureInPicture:(AVPictureInPictureController *)pictureInPictureController  API_AVAILABLE(ios(15.0)) {
}

//Delegate can implement this method to restore the user interface before Picture in Picture stops.
- (void)pictureInPictureController:(AVPictureInPictureController *)pictureInPictureController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL restored))completionHandler  API_AVAILABLE(ios(15.0)) {
}
#endif
@end
