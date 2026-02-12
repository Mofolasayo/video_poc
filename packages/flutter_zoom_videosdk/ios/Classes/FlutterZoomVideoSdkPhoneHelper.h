#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkPhoneHelper: NSObject

-(void) isSupportPhoneFeature: (FlutterResult) result;

-(void) getSupportCountryInfo: (FlutterResult) result;

-(void) inviteByPhone: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) cancelInviteByPhone: (FlutterResult) result;

-(void) getInviteByPhoneStatus: (FlutterResult) result;

-(void) getSessionDialInNumbers: (FlutterResult) result;

@end