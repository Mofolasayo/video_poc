//
//  SDKPiPWindowView.h
//  MobileRTCSample
//
//  Created by Zoom on 2023/7/11.
//  Copyright © 2023 Zoom Video Communications, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZoomVideoSDK/ZoomVideoSDK.h>

@interface SDKPiPWindowView : UIView

@property (nonatomic, strong) UIView *activeVideo;

- (void)startShowActive:(ZoomVideoSDKUser *)user videoType:(ZoomVideoSDKVideoType)type;
- (void)stopShowActive;

@end
