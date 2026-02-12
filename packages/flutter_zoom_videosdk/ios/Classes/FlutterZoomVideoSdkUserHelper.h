#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkUserHelper: NSObject

-(void) changeName: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) makeHost: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) makeManager: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) revokeManager: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) removeUser: (FlutterMethodCall *)call withResult:(FlutterResult) result;

@end
