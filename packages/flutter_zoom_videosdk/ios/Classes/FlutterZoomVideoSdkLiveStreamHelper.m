#import "FlutterZoomVideoSdkLiveStreamHelper.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkLiveStreamHelper

- (ZoomVideoSDKLiveStreamHelper *)getLiveStreamHelper {
    ZoomVideoSDKLiveStreamHelper* liveStreamHelper = nil;
    @try {
        liveStreamHelper = [[ZoomVideoSDK shareInstance] getLiveStreamHelper];
        if (liveStreamHelper == nil) {
            NSException *e = [NSException exceptionWithName:@"NoLiveStreamoHelperFound" reason:@"No Live Stream Helper Found" userInfo:nil];
            @throw e;
        }
    } @catch (NSException *e) {
        NSLog(@"%@ - %@", e.name, e.reason);
    }
    return liveStreamHelper;
}

-(void) canStartLiveStream: (FlutterResult) result {
    result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getLiveStreamHelper] canStartLiveStream])]);
}

-(void) startLiveStream: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getLiveStreamHelper] startLiveStreamWithStreamingURL:call.arguments[@"streamUrl"] StreamingKey:call.arguments[@"streamKey"] BroadcastURL:call.arguments[@"broadcastUrl"]])]);
    });
}

-(void) stopLiveStream: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getLiveStreamHelper] stopLiveStream])]);
    });
}

@end
