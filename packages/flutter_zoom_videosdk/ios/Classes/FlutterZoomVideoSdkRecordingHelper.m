#import "FlutterZoomVideoSdkRecordingHelper.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkRecordingHelper

- (ZoomVideoSDKRecordingHelper *)getRecordingHelper {
    ZoomVideoSDKRecordingHelper* recordingHelper = nil;
    @try {
        recordingHelper = [[ZoomVideoSDK shareInstance] getRecordingHelper];
        if (recordingHelper == nil) {
            NSException *e = [NSException exceptionWithName:@"NoRecordingHelperFound" reason:@"No Recording Helper Found" userInfo:nil];
            @throw e;
        }
    } @catch(NSException *e) {
        NSLog(@"%@ - %@", e.name, e.reason);
    }
    return recordingHelper;
}

-(void) canStartRecording: (FlutterResult) result {
    result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getRecordingHelper] canStartRecording])]);
}

-(void) startCloudRecording: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getRecordingHelper] startCloudRecording])]);
   });
}

-(void) stopCloudRecording: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getRecordingHelper] stopCloudRecording])]);
   });
}

-(void) pauseCloudRecording: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getRecordingHelper] pauseCloudRecording])]);
   });
}

-(void) resumeCloudRecording: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getRecordingHelper] resumeCloudRecording])]);
   });
}

-(void) getCloudRecordingStatus: (FlutterResult) result {
    result([[JSONConvert ZoomVideoSDKRecordingStatusValuesReversed] objectForKey: @([[self getRecordingHelper] getCloudRecordingStatus])]);
}

@end
