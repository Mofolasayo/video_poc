#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkSession: NSObject

-(void) getMySelf:(FlutterResult) result;

-(void) getRemoteUsers: (FlutterResult) result;

-(void) getSessionHost: (FlutterResult) result;

-(void) getSessionHostName:(FlutterResult) result;

-(void) getSessionName:(FlutterResult) result;

-(void) getSessionID:(FlutterResult) result;

-(void) getSessionPassword:(FlutterResult) result;

-(void) getSessionNumber:(FlutterResult) result;

-(void) getSessionPhonePasscode:(FlutterResult) result;

@end