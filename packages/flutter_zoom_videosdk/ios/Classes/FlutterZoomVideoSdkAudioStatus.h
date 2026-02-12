#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkAudioStatus: NSObject

-(void) isMuted:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) isTalking:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getAudioType:(FlutterMethodCall *)call withResult:(FlutterResult) result;

@end
