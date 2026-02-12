
#import "FlutterZoomVideoSdkRemoteCameraControlHelper.h"
#import "JSONConvert.h"
#import "FlutterZoomVideoSdkUser.h"


@implementation FlutterZoomVideoSdkRemoteCameraControlHelper

- (ZoomVideoSDKRemoteCameraControlHelper *)getCameraControllerHelper:(NSString *)userId
{
    ZoomVideoSDKRemoteCameraControlHelper* cameraControlHelper = nil;
    @try {
        ZoomVideoSDKUser* user = [FlutterZoomVideoSdkUser getUser:userId];
        cameraControlHelper = [user getRemoteCameraControlHelper];

        if (cameraControlHelper == nil) {
            NSException *e = [NSException exceptionWithName:@"NoCameraControlHelper" reason:@"No Camera Control Helper Found" userInfo:nil];
            @throw e;
        }
    } @catch(NSException *e) {
        NSLog(@"%@ - %@", e.name, e.reason);
    }
    return cameraControlHelper;
}

-(void) requestControlRemoteCamera: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* userId = call.arguments[@"userId"];
        if ([userId length] == 0) {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                       message:@"UserId is empty"
                                       details:nil]);
        }
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getCameraControllerHelper: userId] requestControlRemoteCamera])]);
    });
}

-(void) giveUpControlRemoteCamera: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* userId = call.arguments[@"userId"];
        if ([userId length] == 0) {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                       message:@"UserId is empty"
                                       details:nil]);
        }
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getCameraControllerHelper: userId] giveUpControlRemoteCamera])]);
    });
}

-(void) turnLeft: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* userId = call.arguments[@"userId"];
        NSNumber* rangeNum = call.arguments[@"range"];
        if ([userId length] == 0) {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                       message:@"UserId is empty"
                                       details:nil]);
        }
        int range = [rangeNum intValue];
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getCameraControllerHelper: userId] turnLeft:range])]);
        
    });
}

-(void) turnRight: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* userId = call.arguments[@"userId"];
        NSNumber* rangeNum = call.arguments[@"range"];
        if ([userId length] == 0) {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                       message:@"UserId is empty"
                                       details:nil]);
        }
        int range = [rangeNum intValue];
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getCameraControllerHelper: userId] turnRight:range])]);
    });
}

-(void) turnUp: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* userId = call.arguments[@"userId"];
        NSNumber* rangeNum = call.arguments[@"range"];
        if ([userId length] == 0) {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                       message:@"UserId is empty"
                                       details:nil]);
        }
        int range = [rangeNum intValue];
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getCameraControllerHelper: userId] turnUp:range])]);
    });
}

-(void) turnDown: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* userId = call.arguments[@"userId"];
        NSNumber* rangeNum = call.arguments[@"range"];
        if ([userId length] == 0) {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                       message:@"UserId is empty"
                                       details:nil]);
        }
        int range = [rangeNum intValue];
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getCameraControllerHelper: userId] turnDown:range])]);
    });
}

-(void) zoomIn: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* userId = call.arguments[@"userId"];
        NSNumber* rangeNum = call.arguments[@"range"];
        if ([userId length] == 0) {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                       message:@"UserId is empty"
                                       details:nil]);
        }
        int range = [rangeNum intValue];
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getCameraControllerHelper: userId] zoomIn:range])]);
    });
}

-(void) zoomOut: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* userId = call.arguments[@"userId"];
        NSNumber* rangeNum = call.arguments[@"range"];
        if ([userId length] == 0) {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                       message:@"UserId is empty"
                                       details:nil]);
        }
        int range = [rangeNum intValue];
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getCameraControllerHelper: userId] zoomOut:range])]);
    });
}

@end
