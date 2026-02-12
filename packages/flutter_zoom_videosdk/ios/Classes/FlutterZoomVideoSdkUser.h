#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDKUser.h>

@interface FlutterZoomVideoSdkUser: NSObject

+ (NSString *)mapUser: (ZoomVideoSDKUser*) user;

+ (NSDictionary *)mapUserDictionary: (ZoomVideoSDKUser*) user;

+ (NSString *)mapUserArray: (NSArray<ZoomVideoSDKUser *> *)userArray;

+ (ZoomVideoSDKUser *)getUser: (NSString*)userId;

-(void) getUserName:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getShareActionList: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) isHost:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) isManager:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) isVideoSpotLighted:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getMultiCameraCanvasList:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) hasIndividualRecordingConsent:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) setUserVolume:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getUserVolume:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) canSetUserVolume:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getUserReference: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getNetworkLevel: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getOverallNetworkLevel: (FlutterMethodCall *)call withResult:(FlutterResult) result;

@end
