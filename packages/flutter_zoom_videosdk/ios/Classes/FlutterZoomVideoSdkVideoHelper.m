#import "FlutterZoomVideoSdkVideoHelper.h"
#import "FlutterZoomVideoSdkUser.h"
#import "FlutterZoomVideoSdkCameraDevice.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkVideoHelper

- (ZoomVideoSDKVideoHelper *)getVideoHelper {
 ZoomVideoSDKVideoHelper* videoHelper = nil;
 @try {
     videoHelper = [[ZoomVideoSDK shareInstance] getVideoHelper];
     if (videoHelper == nil) {
         NSException *e = [NSException exceptionWithName:@"NoVideoHelperFound" reason:@"No Video Helper Found" userInfo:nil];
         @throw e;
     }
 } @catch (NSException *e) {
     NSLog(@"%@ - %@", e.name, e.reason);
 }
 return videoHelper;
}

-(void) startVideo: (FlutterResult) result {
 dispatch_async(dispatch_get_main_queue(), ^{
     result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getVideoHelper] startVideo])]);
 });
}

-(void) stopVideo: (FlutterResult) result {
 dispatch_async(dispatch_get_main_queue(), ^{
     result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getVideoHelper] stopVideo])]);
 });
}

-(void) rotateMyVideo: (FlutterMethodCall *)call withResult:(FlutterResult) result {
 dispatch_async(dispatch_get_main_queue(), ^{
    if ([[self getVideoHelper] rotateMyVideo:(UIDeviceOrientation) call.arguments[@"rotation"]]) {
        result(@YES);
    } else {
        result(@NO);
    }
 });
}

-(void) switchCamera: (FlutterMethodCall *)call withResult:(FlutterResult) result {
 dispatch_async(dispatch_get_main_queue(), ^{
     id deviceId = call.arguments[@"deviceId"];
     if (deviceId == nil || [deviceId isKindOfClass:[NSNull class]] || [deviceId length] == 0) {
         [[self getVideoHelper] switchCamera];
         result(@YES);
     } else {
         NSArray *cameraList = [[[ZoomVideoSDK shareInstance] getVideoHelper] getCameraDeviceList];
         for (ZoomVideoSDKCameraDevice *device in cameraList) {
             if ([device.deviceId isEqualToString: call.arguments[@"deviceId"]]) {
                 if ([[[ZoomVideoSDK shareInstance] getVideoHelper] switchCamera:call.arguments[@"deviceId"]]) {
                     result(@YES);
                 } else {
                     result(@NO);
                 }
                 return;
             }
         }
         result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                    message:@"Camera not found"
                                    details:nil]);
     }
 });
}

-(void) getCameraDeviceList: (FlutterResult) result {
 dispatch_async(dispatch_get_main_queue(), ^{
     NSArray <ZoomVideoSDKCameraDevice*>* cameraDeviceList = [[self getVideoHelper] getCameraDeviceList];
     result([FlutterZoomVideoSdkCameraDevice mapCameraDeviceArray: cameraDeviceList]);
 });
}

-(void) mirrorMyVideo: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getVideoHelper] mirrorMyVideo: [call.arguments[@"enable"] boolValue]])]);
    });
}

-(void) isMyVideoMirrored: (FlutterResult) result {
    if ([[self getVideoHelper] isMyVideoMirrored]) {
        result(@YES);
    } else {
        result(@NO);
    }
}

-(void) enableOriginalAspectRatio: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result(@([[self getVideoHelper] enableOriginalAspectRatio: [call.arguments[@"enabled"] boolValue]]));
    });
}

-(void) isOriginalAspectRatioEnabled: (FlutterResult) result {
    if ([[self getVideoHelper] isOriginalAspectRatioEnabled]) {
        result(@YES);
    } else {
        result(@NO);
    }
}

-(void) spotLightVideo: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* userId = call.arguments[@"userId"];
        if ([userId length] == 0) {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                       message:@"UserId is empty"
                                       details:nil]);
        }
        ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
        if (user != nil) {
            result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getVideoHelper] spotLightVideo:user])]);
        } else {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                       message:@"User not found"
                                       details:nil]);
        }
    });
}

-(void) unSpotLightVideo: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* userId = call.arguments[@"userId"];
        if ([userId length] == 0) {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                       message:@"UserId is empty"
                                       details:nil]);
        }
        ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
        if (user != nil) {
            result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getVideoHelper] unSpotLightVideo:user])]);
        } else {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                       message:@"User not found"
                                       details:nil]);
        }
        
    });
}

-(void) unSpotlightAllVideos: (FlutterResult) result {
 dispatch_async(dispatch_get_main_queue(), ^{
     result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getVideoHelper] unSpotlightAllVideos])]);
 });
}

-(void) getSpotlightedVideoUserList: (FlutterResult) result {
 dispatch_async(dispatch_get_main_queue(), ^{
     result([FlutterZoomVideoSdkUser mapUserArray:[[self getVideoHelper] getSpotlightedVideoUserList]]);
 });
}

@end
