#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkSubSessionHelper: NSObject

+(void) storeSubSessionUserHelpRequestHandler:(ZoomVideoSDKSubSessionUserHelpRequestHandler *)handler;

+(void) storeSubSessionManager:(ZoomVideoSDKSubSessionManager *)manager;

+(void) storeSubSessionParticipant:(ZoomVideoSDKSubSessionParticipant *)participant;

-(void) joinSubSession:(FlutterMethodCall *)call withResult:(FlutterResult)result;

-(void) startSubSession:(FlutterResult)result;

-(void) isSubSessionStarted:(FlutterResult)result;

-(void) stopSubSession:(FlutterResult)result;

-(void) broadcastMessage:(FlutterMethodCall *)call withResult:(FlutterResult)result;

-(void) returnToMainSession:(FlutterResult)result;

-(void) requestForHelp:(FlutterResult)result;

-(void) getRequestUserName:(FlutterResult)result;

-(void) getRequestSubSessionName:(FlutterResult)result;

-(void) ignoreUserHelpRequest:(FlutterResult)result;

-(void) joinSubSessionByUserRequest:(FlutterResult)result;

-(void) commitSubSessionList:(FlutterMethodCall *)call withResult:(FlutterResult)result;

-(void) getCommittedSubSessionList:(FlutterResult)result;

-(void) withdrawSubSessionList:(FlutterResult)result;

@end
