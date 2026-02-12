#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkCmdChannel: NSObject

-(void) sendCommand: (FlutterMethodCall *)call withResult:(FlutterResult) result;

@end