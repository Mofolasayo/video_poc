#import "FlutterZoomVideoSdkPhoneHelper.h"
#import "FlutterZoomVideoSdkPhoneSupportCountryInfo.h"
#import "JSONConvert.h"
#import "FlutterZoomVideoSdkSessionDialInNumberInfo.h"

@implementation FlutterZoomVideoSdkPhoneHelper

- (ZoomVideoSDKPhoneHelper *) getPhoneHelper {
    ZoomVideoSDKPhoneHelper* phoneHelper = nil;
    @try {
        phoneHelper = [[ZoomVideoSDK shareInstance] getPhoneHelper];
        if (phoneHelper == nil) {
            NSException *e = [NSException exceptionWithName:@"NoPhoneHelperFound" reason:@"No Phone Helper Found" userInfo:nil];
            @throw e;
        }
    } @catch (NSException *e) {
       NSLog(@"%@ - %@", e.name, e.reason);
    }
    return phoneHelper;
}

-(void) isSupportPhoneFeature: (FlutterResult) result {
    if ([[self getPhoneHelper] isSupportPhoneFeature]) {
        result(@YES);
    } else {
        result(@NO);
    }
}

-(void) getSupportCountryInfo: (FlutterResult) result {
    ZoomVideoSDKPhoneHelper* phoneHelper = [[ZoomVideoSDK shareInstance] getPhoneHelper];

    if (phoneHelper == nil) {
        result(@"phoneHelper_getSupportCountryInfo: No phone helper found");
    }

    result([FlutterZoomVideoSdkPhoneSupportCountryInfo mapPhoneSupportCountryInfo:[phoneHelper getSupportCountryInfo]]);
}

-(void) inviteByPhone: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    ZoomVideoSDKPhoneHelper* phoneHelper = [[ZoomVideoSDK shareInstance] getPhoneHelper];

    NSLog(@"countryCode:%@ , phoneNumber:%@ , name:%@", call.arguments[@"countryCode"], call.arguments[@"phoneNumber"], call.arguments[@"name"]);

    if (phoneHelper.isSupportPhoneFeature == YES) {
        dispatch_async(dispatch_get_main_queue(), ^{
            result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([phoneHelper inviteByPhone: call.arguments[@"countryCode"] phoneNumber: call.arguments[@"phoneNumber"] name: call.arguments[@"name"]])]);
        });
    }
}

-(void) cancelInviteByPhone: (FlutterResult) result {
    ZoomVideoSDKPhoneHelper* phoneHelper = [[ZoomVideoSDK shareInstance] getPhoneHelper];

    if (phoneHelper.isSupportPhoneFeature == YES) {
        dispatch_async(dispatch_get_main_queue(), ^{
            result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([phoneHelper cancelInviteByPhone])]);
        });
    }
}

-(void) getInviteByPhoneStatus: (FlutterResult) result {

    result([[JSONConvert ZoomVideoSDKPhoneStatusValuesReversed] objectForKey: @([[self getPhoneHelper] getInviteByPhoneStatus])]);
}

-(void) getSessionDialInNumbers: (FlutterResult) result {
    ZoomVideoSDKPhoneHelper* phoneHelper = [[ZoomVideoSDK shareInstance] getPhoneHelper];
    result([FlutterZoomVideoSdkSessionDialInNumberInfo mapSessionDialInNumberInfoArray:[phoneHelper getSessionDialInNumbers]]);
}

@end
