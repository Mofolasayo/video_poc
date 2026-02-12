#import "FlutterZoomVideoSdkVideoStatisticInfo.h"
#import "FlutterZoomVideoSdkUser.h"

@implementation FlutterZoomVideoSdkVideoStatisticInfo

-(void) getUserVideoBpf: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser: call.arguments[@"userId"]];
    if (user != nil) {
        result(@([[user getVideoStatisticInfo] bps]));
    }
}

-(void) getUserVideoFps: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser: call.arguments[@"userId"]];
    if (user != nil) {
        result(@([[user getVideoStatisticInfo] fps]));
    }
}

-(void) getUserVideoHeight: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser: call.arguments[@"userId"]];
    if (user != nil) {
        result(@([[user getVideoStatisticInfo] height]));
    }
}

-(void) getUserVideoWidth: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser: call.arguments[@"userId"]];
    if (user != nil) {
        result(@([[user getVideoStatisticInfo] width]));
    }
}

@end
