#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkChatHelper: NSObject

-(void) isChatDisabled: (FlutterResult) result;

-(void) isPrivateChatDisabled: (FlutterResult) result;

-(void) sendChatToUser: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) sendChatToAll: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) deleteChatMessage: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) canChatMessageBeDeleted: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) changeChatPrivilege: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getChatPrivilege: (FlutterResult) result;

@end
