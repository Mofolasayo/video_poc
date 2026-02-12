#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkRecordingHelper: NSObject

-(void) canStartRecording: (FlutterResult) result;

-(void) startCloudRecording: (FlutterResult) result;

-(void) stopCloudRecording: (FlutterResult) result;

-(void) pauseCloudRecording: (FlutterResult) result;

-(void) resumeCloudRecording: (FlutterResult) result;

-(void) getCloudRecordingStatus: (FlutterResult) result;

@end