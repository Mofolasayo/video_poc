//
//  SDKPiPHelper.h
//  MobileRTCSample
//
//  Created by Zoom on 2023/7/11.
//  Copyright © 2023 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import "SDKPiPWindowView.h"

#define ENABLE_PIP_FOR_VOIP_MEETING 1

@interface SDKPiPHelper : NSObject <AVPictureInPictureControllerDelegate>

@property (nonatomic, retain, nullable) AVPictureInPictureController * pipController API_AVAILABLE(ios(15.0));
@property (nonatomic, retain, nullable) AVPictureInPictureVideoCallViewController * pipVideoCallViewCtrl API_AVAILABLE(ios(15.0));
@property (nonatomic, retain, nullable) AVPictureInPictureControllerContentSource * pipContentSource API_AVAILABLE(ios(15.0));

@property (nonatomic, retain, nullable) SDKPiPWindowView * pipVideoView;

@property (nonatomic, strong, readonly) ZoomVideoSDKUser *videoUser;
@property (nonatomic, assign, readonly) ZoomVideoSDKVideoType videoType;

+ (SDKPiPHelper *)shared;

+ (BOOL)isPiPSupported;
- (void)presetPiPWithSrcView:(UIView*)sourceView;
- (void)cleanUpPictureInPicture;

- (void)updatePiPVideoUser:(ZoomVideoSDKUser *)user videoType:(ZoomVideoSDKVideoType)type;

@end
