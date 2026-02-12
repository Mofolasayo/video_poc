#import "FlutterZoomVideoSdkCRCHelper.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkCRCHelper

-(void) isCRCEnabled: (FlutterResult) result {
    ZoomVideoSDKCRCHelper* CRCHelper = [[ZoomVideoSDK shareInstance] getCRCHelper];
    if ([CRCHelper isCRCEnabled]) {
        result(@YES);
    } else {
        result(@NO);
    }
}

-(void) callCRCDevice: (FlutterMethodCall *)call withResult:(FlutterResult) result {
  dispatch_async(dispatch_get_main_queue(), ^{
    ZoomVideoSDKCRCHelper* CRCHelper = [[ZoomVideoSDK shareInstance] getCRCHelper];
    ZoomVideoSDKCRCProtocol protocolEnum = [JSONConvert ZoomVideoSDKCRCProtocol: call.arguments[@"protocol"]];
    ZoomVideoSDKError ret = [CRCHelper callCRCDevice: call.arguments[@"address"] protocol: protocolEnum];
    result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(ret)]);
  });
}

-(void) cancelCallCRCDevice: (FlutterResult) result {
  ZoomVideoSDKCRCHelper* CRCHelper = [[ZoomVideoSDK shareInstance] getCRCHelper];
  dispatch_async(dispatch_get_main_queue(), ^{
    result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([CRCHelper cancelCallCRCDevice])]);
  });
}

-(void) getSessionSIPAddress: (FlutterResult) result {
    ZoomVideoSDKCRCHelper* CRCHelper = [[ZoomVideoSDK shareInstance] getCRCHelper];
    dispatch_async(dispatch_get_main_queue(), ^{
        result([CRCHelper getSessionSIPAddress]);
    });
}
@end
