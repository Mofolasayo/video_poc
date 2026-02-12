#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkVirtualBackgroundHelper: NSObject

-(void) isSupportVirtualBackground: (FlutterResult) result;

-(void) addVirtualBackgroundItem: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) removeVirtualBackgroundItem: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getVirtualBackgroundItemList: (FlutterResult) result;

-(void) setVirtualBackgroundItem: (FlutterMethodCall *)call withResult:(FlutterResult) result;

@end