#import "FlutterZoomVideoSdkShareStatisticInfo.h"
#import "FlutterZoomVideoSdkUser.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkShareStatisticInfo

-(void) getUserShareBpf: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        result(@([[user getShareStatisticInfo] bps]));
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) getUserShareFps: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        result(@([[user getShareStatisticInfo] fps]));
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) getUserShareHeight: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        result(@([[user getShareStatisticInfo] height]));
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) getUserShareWidth: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        result(@([[user getShareStatisticInfo] width]));
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

@end
