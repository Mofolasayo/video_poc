#import "FlutterZoomVideoSdkSession.h"
#import "FlutterZoomVideoSdkUser.h"

@implementation FlutterZoomVideoSdkSession

-(void) getMySelf:(FlutterResult) result {
    ZoomVideoSDKSession* session = [[ZoomVideoSDK shareInstance] getSession];

    if (session == nil) {
        result(@"session_getMySelf: No Session Found");
    }

    result([FlutterZoomVideoSdkUser mapUser:[session getMySelf]]);
}

-(void) getRemoteUsers: (FlutterResult) result {
    ZoomVideoSDKSession* session = [[ZoomVideoSDK shareInstance] getSession];

    if (session == nil) {
        result(@"session_getRemoteUsers: No Session Found");
    }

    result([FlutterZoomVideoSdkUser mapUserArray:[session getRemoteUsers]]);
}

-(void) getSessionHost: (FlutterResult) result {
    ZoomVideoSDKSession* session = [[ZoomVideoSDK shareInstance] getSession];

    if (session == nil) {
        result(@"session_getSessionHost: No Session Found");
    }

    result([FlutterZoomVideoSdkUser mapUser:[session getSessionHost]]);
}

-(void) getSessionHostName:(FlutterResult) result {
    ZoomVideoSDKSession* session = [[ZoomVideoSDK shareInstance] getSession];

    if (session == nil) {
        result(@"session_getSessionHostName: No Session Found");
    }

    result([session getSessionHostName]);
}

-(void) getSessionName:(FlutterResult) result {
    ZoomVideoSDKSession* session = [[ZoomVideoSDK shareInstance] getSession];

    if (session == nil) {
        result(@"session_getSessionName: No Session Found");
    }

    result([session getSessionName]);
}

-(void) getSessionID:(FlutterResult) result {
    ZoomVideoSDKSession* session = [[ZoomVideoSDK shareInstance] getSession];

    if (session == nil) {
        result(@"session_getSessionPassword: No Session Found");
    }

    result([session getSessionID]);
}

-(void) getSessionPassword:(FlutterResult) result {
    ZoomVideoSDKSession* session = [[ZoomVideoSDK shareInstance] getSession];

    if (session == nil) {
        result(@"session_getSessionPassword: No Session Found");
    }

    result([session getSessionPassword]);
}

-(void) getSessionNumber:(FlutterResult) result {
    ZoomVideoSDKSession* session = [[ZoomVideoSDK shareInstance] getSession];

    if (session == nil) {
        result(@"session_getSessionNumber: No Session Found");
    }

    result([NSString stringWithFormat:@"%llu", [session getSessionNumber]]);
}

-(void) getSessionPhonePasscode:(FlutterResult) result {
    ZoomVideoSDKSession* session = [[ZoomVideoSDK shareInstance] getSession];

    if (session == nil) {
        result(@"session_getSessionPhonePasscode: No Session Found");
    }

    result([session getSessionPhonePasscode]);
}

@end