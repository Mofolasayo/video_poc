#import "FlutterZoomVideoSdkVideoStatus.h"
#import "FlutterZoomVideoSdkUser.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkVideoStatus

-(void) isOn: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        if ([[[user getVideoCanvas] videoStatus] on]) {
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

@end
