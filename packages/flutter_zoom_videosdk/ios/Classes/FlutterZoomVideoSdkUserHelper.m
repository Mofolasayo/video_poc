#import "FlutterZoomVideoSdkUserHelper.h"
#import "FlutterZoomVideoSdkUser.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkUserHelper

-(void) changeName: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    ZoomVideoSDKUserHelper* userHelper = [[ZoomVideoSDK shareInstance] getUserHelper];
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([userHelper changeName:call.arguments[@"name"] withUser:user]) {
                result(@YES);
            } else {
                result(@NO);
            }
        });
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) makeHost: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    ZoomVideoSDKUserHelper* userHelper = [[ZoomVideoSDK shareInstance] getUserHelper];
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([userHelper makeHost:user]) {
                result(@YES);
            } else {
                result(@NO);
            }
        });
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) makeManager: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    ZoomVideoSDKUserHelper* userHelper = [[ZoomVideoSDK shareInstance] getUserHelper];
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([userHelper makeManager:user]) {
                result(@YES);
            } else {
                result(@NO);
            }
        });
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) revokeManager: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    ZoomVideoSDKUserHelper* userHelper = [[ZoomVideoSDK shareInstance] getUserHelper];
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([userHelper revokeManager:user]) {
                result(@YES);
            } else {
                result(@NO);
            }
        });
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) removeUser: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    ZoomVideoSDKUserHelper* userHelper = [[ZoomVideoSDK shareInstance] getUserHelper];
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            result(([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([userHelper removeUser:user])]));
        });
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

@end
