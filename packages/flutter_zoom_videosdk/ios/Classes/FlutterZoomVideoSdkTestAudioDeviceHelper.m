#import "FlutterZoomVideoSdkTestAudioDeviceHelper.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkTestAudioDeviceHelper

- (ZoomVideoSDKTestAudioDeviceHelper *)getTestAudioDeviceHelper {
    ZoomVideoSDKTestAudioDeviceHelper* testAudioDeviceHelper = nil;
    @try {
        testAudioDeviceHelper = [[ZoomVideoSDK shareInstance] getTestAudioDeviceHelper];
        if (testAudioDeviceHelper == nil) {
            NSException *e = [NSException exceptionWithName:@"NoTestAudioDeviceHelperFound" reason:@"No Test Audio Device Helper Found" userInfo:nil];
            @throw e;
        }
    } @catch(NSException *e) {
        NSLog(@"%@ - %@", e.name, e.reason);
    }
    return testAudioDeviceHelper;
}

-(void) startMicTest: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getTestAudioDeviceHelper] startMicTest])]);
    });
}

-(void) stopMicTest: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getTestAudioDeviceHelper] stopMicTest])]);
   });
}

-(void) playMicTest: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getTestAudioDeviceHelper] playMicTest])]);
   });
}

-(void) startSpeakerTest: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getTestAudioDeviceHelper] startSpeakerTest])]);
   });
}

-(void) stopSpeakerTest: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getTestAudioDeviceHelper] stopSpeakerTest])]);
   });
}

@end
