#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkRemoteCameraControlHelper: NSObject

-(void) requestControlRemoteCamera: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) giveUpControlRemoteCamera: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) turnLeft: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) turnRight: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) turnUp: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) turnDown: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) zoomIn: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) zoomOut: (FlutterMethodCall *)call withResult:(FlutterResult) result;

@end
