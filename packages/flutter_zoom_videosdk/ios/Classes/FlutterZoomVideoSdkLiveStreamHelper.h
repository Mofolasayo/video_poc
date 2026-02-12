#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkLiveStreamHelper: NSObject

-(void) canStartLiveStream: (FlutterResult) result;

-(void) startLiveStream: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) stopLiveStream: (FlutterResult) result;

@end

