#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkAnnotationHelper: NSObject

- (void) setAnnotationHelper: (ZoomVideoSDKAnnotationHelper*) helper;

-(void) isSenderDisableAnnotation: (FlutterResult) result;

-(void) canDoAnnotation: (FlutterResult) result;

-(void) startAnnotation: (FlutterResult) result;

-(void) stopAnnotation: (FlutterResult) result;

-(void) setToolColor:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getToolColor: (FlutterResult) result;

-(void) setToolType:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getToolType: (FlutterResult) result;

-(void) setToolWidth:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getToolWidth: (FlutterResult) result;

-(void) undo: (FlutterResult) result;

-(void) redo: (FlutterResult) result;

-(void) clear: (FlutterMethodCall *)call withResult:(FlutterResult) result;

@end
