#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkTestAudioDeviceHelper: NSObject

-(void) startMicTest: (FlutterResult) result;

-(void) stopMicTest: (FlutterResult) result;

-(void) playMicTest: (FlutterResult) result;

-(void) startSpeakerTest: (FlutterResult) result;

-(void) stopSpeakerTest: (FlutterResult) result;

@end
