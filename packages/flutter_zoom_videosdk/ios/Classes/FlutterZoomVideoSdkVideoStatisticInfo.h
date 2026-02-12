#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkVideoStatisticInfo: NSObject

-(void) getUserVideoBpf: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getUserVideoFps: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getUserVideoHeight: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getUserVideoWidth: (FlutterMethodCall *)call withResult:(FlutterResult) result;

@end
