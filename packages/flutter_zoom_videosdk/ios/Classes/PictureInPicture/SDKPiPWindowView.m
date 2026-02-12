//
//  SDKPiPWindowView.m
//  MobileRTCSample
//
//  Created by Zoom on 2023/7/11.
//  Copyright © 2023 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKPiPWindowView.h"

@interface SDKPiPWindowView ()

@property (nonatomic, strong) ZoomVideoSDKUser *lastDataUser;
@property (nonatomic, assign) ZoomVideoSDKVideoType lastDataType;

@end

@implementation SDKPiPWindowView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.lastDataType = 0;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    CGSize windowSize = self.bounds.size;
    self.activeVideo = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, windowSize}];
    [self addSubview:self.activeVideo];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize screenSize = self.frame.size;
    if (self.activeVideo && [self.activeVideo superview] == self) {
        [self.activeVideo setFrame:(CGRect){CGPointZero, screenSize}];
    }
}

- (void)startShowActive:(ZoomVideoSDKUser *)user videoType:(ZoomVideoSDKVideoType)type {
    [self cancelPreviousSubscription];
    if (type == ZoomVideoSDKVideoType_ShareData) {
        [[[self getStartedShareAction:user] getShareCanvas] subscribeWithPiPView:self.activeVideo
                                             aspectMode:0
                                          andResolution:ZoomVideoSDKVideoResolution_Auto];
    } else {
        [[user getVideoCanvas] subscribeWithPiPView:self.activeVideo
                                              aspectMode:0
                                           andResolution:ZoomVideoSDKVideoResolution_Auto];
    }
    self.lastDataUser = user;
    self.lastDataType = type;
}

- (void)cancelPreviousSubscription {
    if (!self.lastDataUser) return;
    if (self.lastDataType == ZoomVideoSDKVideoType_ShareData) {
        [[[self getStartedShareAction:self.lastDataUser] getShareCanvas] unSubscribeWithView:self.activeVideo];
    } else if (self.lastDataType == ZoomVideoSDKVideoType_ShareData) {
        [[self.lastDataUser getVideoCanvas] unSubscribeWithView:self.activeVideo];
    }
}

- (void)stopShowActive {
    [self cancelPreviousSubscription];
}

- (ZoomVideoSDKShareAction *)getStartedShareAction:(ZoomVideoSDKUser*)user {
    for (ZoomVideoSDKShareAction * shareAction in [user getShareActionList]) {
        if ([shareAction getShareStatus] == ZoomVideoSDKReceiveSharingStatus_Start) {
            return shareAction;
        }
    }
    return nil;
}

@end
