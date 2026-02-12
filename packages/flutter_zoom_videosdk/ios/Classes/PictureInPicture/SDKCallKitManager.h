//
//  MobileRTCCallKitManager.h
//  MobileRTCSample
//
//  Created by Zoom on 2023/7/10.
//  Copyright © 2023 Zoom Video Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CallKit/CallKit.h>
#import <ZoomVideoSDK/ZoomVideoSDK.h>

#define ENABLE_CALLKIT_VOIP_MEETING 1

@interface SDKCallKitManager : NSObject <CXProviderDelegate>

@property (nonatomic, assign, readonly) BOOL isInCall;

+ (instancetype)sharedManager;
- (void)startCallWithHandle:(NSString *)handle complete:(void (^)(void))completion;
- (void)endCallWithComplete:(void (^)(void))completion;
- (void)setEnableCallKit: (BOOL)enable;

@end
