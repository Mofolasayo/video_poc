#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkShareStatisticInfo: NSObject

-(void) getUserShareBpf: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getUserShareFps: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getUserShareHeight: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getUserShareWidth: (FlutterMethodCall *)call withResult:(FlutterResult) result;

@end