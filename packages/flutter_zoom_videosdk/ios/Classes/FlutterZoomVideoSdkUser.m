#import "FlutterZoomVideoSdkUser.h"
#import "FlutterZoomVideoSdkShareAction.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkUser

+ (NSString *)mapUser: (ZoomVideoSDKUser*) user {
    @try {
        NSDictionary* userDic =  @{
            @"userId": [@([user getUserID]) stringValue],
            @"customUserId": [user getCustomUserId],
            @"userName": [user getUserName],
            @"isHost": @([user isHost]),
            @"isManager": @([user isManager]),
            @"isVideoSpotLighted": @([user isVideoSpotLighted]),
        };
        return [JSONConvert NSDictionaryToNSString: userDic];
    }
    @catch (NSException *e) {
        return @"{}";
    }
}

+ (NSDictionary *)mapUserDictionary: (ZoomVideoSDKUser*) user {
    @try {
        return  @{
            @"userId": [@([user getUserID]) stringValue],
            @"customUserId": [user getCustomUserId],
            @"userName": [user getUserName],
            @"isHost": @([user isHost]),
            @"isManager": @([user isManager]),
            @"isVideoSpotLighted": @([user isVideoSpotLighted]),
        };
    }
    @catch (NSException *e) {
        return @{};
    }
}

+ (NSString *)mapUserArray: (NSArray<ZoomVideoSDKUser *> *)userArray {
    NSMutableArray *mappedUserArray = [NSMutableArray array];

    @try {
        [userArray enumerateObjectsUsingBlock:^(ZoomVideoSDKUser * _Nonnull user, NSUInteger idx, BOOL * _Nonnull stop) {
            [mappedUserArray addObject: [self mapUserDictionary: user]];
        }];
    }
    @finally {
        if ([mappedUserArray count] > 0) {
            return [JSONConvert NSMutableArrayToNSString: mappedUserArray];
        } else {
            return @"[]";
        }
    }
}

+ (ZoomVideoSDKUser *)getUser:(NSString*)userId {
    // Check if the user is ourself?
    ZoomVideoSDKUser* myUser = [[[ZoomVideoSDK shareInstance] getSession] getMySelf];
    
    if ([myUser getUserID] == [userId intValue]) {
        return myUser;
    }
    
    // Wasn't us, try remote users
    NSArray<ZoomVideoSDKUser *>* remoteUsers = [[[ZoomVideoSDK shareInstance] getSession] getRemoteUsers];
    for (ZoomVideoSDKUser* user in remoteUsers) {
        if ([user getUserID] == [userId intValue]) {
            return user;
        }
    }
    
    return nil;
}

-(void) getUserName: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        result([user getUserName]);
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) getShareActionList: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        result([FlutterZoomVideoSdkShareAction mapShareActionArray:[user getShareActionList]]);
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) isHost:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        if ([user isHost]) {
            result(@YES);
        } else {
            result(@NO);
        }
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) isManager:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        if ([user isManager]) {
            result(@YES);
        } else {
            result(@NO);
        }
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) isVideoSpotLighted:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        if ([user isVideoSpotLighted]) {
            result(@YES);
        } else {
            result(@NO);
        }
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) getMultiCameraCanvasList:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        result([JSONConvert NSMutableArrayToNSString: [user getMultiCameraCanvasList]]);
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) hasIndividualRecordingConsent:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        if ([user isIndividualRecordAgreed]) {
            result(@YES);
        } else {
            result(@NO);
        }
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) setUserVolume:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        if ([user setUserVolume: [call.arguments[@"volume"] floatValue] isShareAudio: [call.arguments[@"isSharingAudio"] boolValue]]) {
            result(@YES);
        } else {
            result(@NO);
        }
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) getUserVolume:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        float volume;
        [user getUserVolume: &volume isShareAudio: [call.arguments[@"isSharingAudio"] boolValue]];
        result(@(volume));
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) canSetUserVolume:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        if ([user canSetUserVolume: [call.arguments[@"isSharingAudio"] boolValue]]) {
            result(@YES);
        } else {
            result(@NO);
        }
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) getUserReference: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        result([user getUserReference]);
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) getNetworkLevel: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    NSString* dataType = call.arguments[@"dataType"];
    ZoomVideoSDKDataType type = [JSONConvert ZoomVideoSDKDataType: dataType];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        result([[JSONConvert ZoomVideoSDKNetworkStatusValuesReversed] objectForKey: @([user getNetworkLevel:type])]);
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

-(void) getOverallNetworkLevel: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* userId = call.arguments[@"userId"];
    if ([userId length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"UserId is empty"
                                   details:nil]);
    }
    ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
    if (user != nil) {
        result([[JSONConvert ZoomVideoSDKNetworkStatusValuesReversed] objectForKey: @([user getOverallNetworkLevel])]);
    } else {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"User not found"
                                   details:nil]);
    }
}

@end
