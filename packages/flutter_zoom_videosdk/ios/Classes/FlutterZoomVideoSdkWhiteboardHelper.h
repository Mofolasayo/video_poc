#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkWhiteboardHelper: NSObject


-(void) subscribeWhiteboard:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) unSubscribeWhiteboard: (FlutterResult) result;

-(void) canStartShareWhiteboard: (FlutterResult) result;

-(void) startShareWhiteboard: (FlutterResult) result;

-(void) canStopShareWhiteboard: (FlutterResult) result;

-(void) stopShareWhiteboard: (FlutterResult) result;

-(void) isOtherSharingWhiteboard: (FlutterResult) result;

-(void) exportWhiteboard:(FlutterMethodCall *)call withResult:(FlutterResult) result;

@end
