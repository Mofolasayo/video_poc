#import "FlutterZoomVideoSdkChatHelper.h"
#import "FlutterZoomVideoSdkUser.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkChatHelper

-(void) isChatDisabled: (FlutterResult) result {
    ZoomVideoSDKChatHelper* chatHelper = [[ZoomVideoSDK shareInstance] getChatHelper];
    if ([chatHelper IsChatDisabled]) {
        result(@YES);
    } else {
        result(@NO);
    }
}

-(void) isPrivateChatDisabled: (FlutterResult) result {
    ZoomVideoSDKChatHelper* chatHelper = [[ZoomVideoSDK shareInstance] getChatHelper];
    if ([chatHelper IsPrivateChatDisabled]) {
        result(@YES);
    } else {
        result(@NO);
    }
}

-(void) sendChatToUser: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    ZoomVideoSDKChatHelper* chatHelper = [[ZoomVideoSDK shareInstance] getChatHelper];

    if (chatHelper.IsChatDisabled == NO && chatHelper.IsPrivateChatDisabled == NO) {
        NSString* userId = call.arguments[@"userId"];
        if ([userId length] == 0) {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                       message:@"UserId is empty"
                                       details:nil]);
        }
        ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
        if (user != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([chatHelper SendChatToUser:user Content: call.arguments[@"message"]])]);
            });
        } else {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                       message:@"User not found"
                                       details:nil]);
        }
    }
}

-(void) sendChatToAll: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    ZoomVideoSDKChatHelper* chatHelper = [[ZoomVideoSDK shareInstance] getChatHelper];

    if (chatHelper.IsChatDisabled == NO) {
        dispatch_async(dispatch_get_main_queue(), ^{
            result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([chatHelper SendChatToAll: call.arguments[@"message"]])]);
        });
    }
}

-(void) deleteChatMessage: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    ZoomVideoSDKChatHelper* chatHelper = [[ZoomVideoSDK shareInstance] getChatHelper];

    if (chatHelper.IsChatDisabled == NO) {
        dispatch_async(dispatch_get_main_queue(), ^{
            result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([chatHelper deleteChatMessage: call.arguments[@"msgId"]])]);
        });
    }
}

-(void) canChatMessageBeDeleted: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    ZoomVideoSDKChatHelper* chatHelper = [[ZoomVideoSDK shareInstance] getChatHelper];

    if (chatHelper.IsChatDisabled == NO) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([chatHelper canChatMessageBeDeleted: call.arguments[@"msgId"]]) {
                result(@YES);
            } else {
                result(@NO);
            }
        });
    }
}

-(void) changeChatPrivilege: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    ZoomVideoSDKChatHelper* chatHelper = [[ZoomVideoSDK shareInstance] getChatHelper];
    NSString* privilege = call.arguments[@"privilege"];
    if ([privilege length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"privilege is empty"
                                   details:nil]);
    }
    ZoomVideoSDKChatPrivilegeType type = [JSONConvert ZoomVideoSDKChatPrivilegeType: privilege];
    
    if (chatHelper.IsChatDisabled == NO) {
        dispatch_async(dispatch_get_main_queue(), ^{
            result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([chatHelper changeChatPrivilege: type])]);
        });
    }
}

-(void) getChatPrivilege: (FlutterResult) result {
    ZoomVideoSDKChatHelper* chatHelper = [[ZoomVideoSDK shareInstance] getChatHelper];

    if (chatHelper.IsChatDisabled == NO) {
        dispatch_async(dispatch_get_main_queue(), ^{
            result([[JSONConvert ZoomVideoSDKChatPrivilegeTypeValuesReversed] objectForKey: @([chatHelper getChatPrivilege])]);
        });
    }
}

@end
