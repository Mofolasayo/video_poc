#import "FlutterZoomVideoSdkChatMessage.h"
#import "FlutterZoomVideoSdkUser.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkChatMessage

+ (NSString *)mapChatMessage: (ZoomVideoSDKChatMessage *)chatMessage {
    @try {
        NSMutableDictionary *mappedChatMessage = [[NSMutableDictionary alloc] init];
        if (chatMessage == nil) {
            return [JSONConvert NSDictionaryToNSString: mappedChatMessage];
        }
        NSDictionary *chatData = @{
            @"content": [chatMessage content],
            @"senderUser": [FlutterZoomVideoSdkUser mapUser:[chatMessage senderUser]],
            @"timestamp": @([chatMessage timeStamp]),
            @"isChatToAll": @([chatMessage isChatToAll]),
            @"isSelfSend": @([chatMessage isSelfSend]),
            @"messageID": [chatMessage messageID]
        };
        [mappedChatMessage setDictionary:chatData];
        ZoomVideoSDKUser *receiverUser = [chatMessage receiverUser];
        if (receiverUser != nil) {
            mappedChatMessage[@"receiverUser"] = [FlutterZoomVideoSdkUser mapUser:receiverUser];
        }
        return [JSONConvert NSDictionaryToNSString: mappedChatMessage];
    }
    @catch (NSException *e) {
        return @"";
    }
}

@end