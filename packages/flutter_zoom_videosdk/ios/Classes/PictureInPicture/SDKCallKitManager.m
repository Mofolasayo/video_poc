//
//  SDKCallKitManager.m
//  MobileRTCSample
//
//  Created by Zoom on 2023/7/10.
//  Copyright © 2023 Zoom Video Communications, Inc. All rights reserved.
//

#import "SDKCallKitManager.h"
#import <CallKit/CallKit.h>

@interface SDKCallKitManager () <CXProviderDelegate>

@property (nonatomic, strong) CXProvider *provider API_AVAILABLE(ios(10.0));
@property (nonatomic, strong) CXCallController *callController API_AVAILABLE(ios(10.0));
@property (nonatomic, strong) NSUUID *callingUUID;

@end

@implementation SDKCallKitManager

bool enableCallKit = true;

+ (instancetype)sharedManager {
    static SDKCallKitManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        if (enableCallKit) {
            if (@available(iOS 10.0, *)) {
                CXProviderConfiguration *providerConfig = [[CXProviderConfiguration alloc] initWithLocalizedName:@"VideoSDK"];
                self.provider = [[CXProvider alloc] initWithConfiguration:providerConfig];
                [self.provider setDelegate:self queue:nil];
                self.callController = [[CXCallController alloc] init];
            }
        }
    }
    return self;
}


- (void)setEnableCallKit: (BOOL)enable {
    enableCallKit = enable;
}

- (void)startCallWithHandle:(NSString *)handle complete:(void (^)(void))completion {
    if (enableCallKit) {
        if (self.isInCall) {
            NSLog(@"Already in a call process.");
            return;
        }
        
        if (@available(iOS 10.0, *)) {
            NSUUID *callingUUID = [NSUUID UUID];
            CXHandle *callHandle = [[CXHandle alloc] initWithType:CXHandleTypeGeneric value:handle];
            CXStartCallAction *startCallAction = [[CXStartCallAction alloc] initWithCallUUID:callingUUID handle:callHandle];
            
            CXTransaction *transaction = [[CXTransaction alloc] init];
            [transaction addAction:startCallAction];
            
            __weak typeof(self) weakSelf = self;
            [self.callController requestTransaction:transaction completion:^(NSError * _Nullable error) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (error) {
                    NSLog(@"Error starting call: %@", error.localizedDescription);
                    strongSelf.callingUUID = nil;
                } else {
                    NSLog(@"Call started successfully.");
                    strongSelf.callingUUID = callingUUID;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion();
                    }
                });
            }];
        }
    }
}

- (void)endCallWithComplete:(void (^)(void))completion {
    if (enableCallKit) {
        if (!self.isInCall) {
            NSLog(@"No active call process.");
            return;
        }
        
        if (@available(iOS 10.0, *)) {
            CXEndCallAction *endCallAction = [[CXEndCallAction alloc] initWithCallUUID:self.callingUUID];
            CXTransaction *transaction = [[CXTransaction alloc] init];
            [transaction addAction:endCallAction];
            __weak typeof(self) weakSelf = self;
            [self.callController requestTransaction:transaction completion:^(NSError * _Nullable error) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (error) {
                    NSLog(@"Error ending call: %@", error.localizedDescription);
                } else {
                    NSLog(@"Call ended successfully.");
                    strongSelf.callingUUID = nil;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion();
                    }
                });
            }];
        }
    }
}

- (void)provider:(CXProvider *)provider performStartCallAction:(CXStartCallAction *)action  API_AVAILABLE(ios(10.0)){
    [action fulfill];
}

- (void)provider:(CXProvider *)provider performEndCallAction:(CXEndCallAction *)action  API_AVAILABLE(ios(10.0)){
    ZoomVideoSDKUser *mySelf = [[[ZoomVideoSDK shareInstance] getSession] getMySelf];
    BOOL endSession = [mySelf isHost] ? YES : NO;
    [[ZoomVideoSDK shareInstance] leaveSession:endSession];
    [action fulfill];
}

- (void)providerDidReset:(CXProvider *)provider  API_AVAILABLE(ios(10.0)){
    self.callingUUID = nil;
}

- (void)provider:(CXProvider *)provider performSetMutedCallAction:(CXSetMutedCallAction *)action {
    ZoomVideoSDKUser *mySelf = [[[ZoomVideoSDK shareInstance] getSession] getMySelf];
    BOOL isMute = action.isMuted;
    if (isMute) {
        [[[ZoomVideoSDK shareInstance] getAudioHelper] muteAudio:mySelf];
    }
    else {
        [[[ZoomVideoSDK shareInstance] getAudioHelper] unmuteAudio:mySelf];
    }
    [action fulfill];
}

- (BOOL)isInCall {
    if (self.callingUUID) {
        return YES;
    } else {
        return NO;
    }
}

@end
