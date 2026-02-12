#import "JSONConvert.h"
#import "FlutterZoomVideoSdkAudioStatus.h"
#import "FlutterZoomVideoSdkUser.h"

@implementation FlutterZoomVideoSdkAudioStatus

-(void) isMuted:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        if ([[user audioStatus] isMuted]) {
            result(@(YES));
        } else {
            result(@(NO));
        }
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) isTalking:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        if ([[user audioStatus] talking]) {
            result(@YES);
        } else {
            result(@NO);
        }
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) getAudioType:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        result([[JSONConvert ZoomVideoSDKAudioTypeValuesReversed] objectForKey: @([[user audioStatus] audioType])]);
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

@end
