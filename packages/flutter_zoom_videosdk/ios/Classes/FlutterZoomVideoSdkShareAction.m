#import "FlutterZoomVideoSdkShareAction.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkShareAction

+ (NSString *)mapShareAction: (ZoomVideoSDKShareAction *) shareAction {
    @try {
        return [JSONConvert NSDictionaryToNSString:
            [self mapShareActionDictionary: shareAction]];
    }
    @catch (NSException *e) {
        return @"";
    }
}

+ (NSDictionary *) mapShareActionDictionary: (ZoomVideoSDKShareAction*) shareAction {
    @try {
        if (shareAction == nil) {
            return @{};
        }
        NSDictionary *shareActionData = @{
                @"shareSourceId": @([shareAction getShareSourceId]),
                @"shareStatus": [[JSONConvert ZoomVideoSDKReceiveSharingStatusValuesReversed] objectForKey: @([shareAction getShareStatus])],
                @"subscribeFailReason": [[JSONConvert ZoomVideoSDKSubscribeFailReasonValuesReversed] objectForKey: @([shareAction getSubscribeFailReason])],
                @"isAnnotationPrivilegeEnabled": @([shareAction isAnnotationPrivilegeEnabled]),
                @"shareType": [[JSONConvert ZoomVideoSDKShareTypeValuesReversed] objectForKey: @([shareAction getShareType])],
        };
        return shareActionData;
    }
    @catch (NSException *e) {
        return @"";
    }
}

+ (NSString *) mapShareActionArray: (NSArray <ZoomVideoSDKShareAction*>*)shareActionArray {
    NSMutableArray *mappedShareActionArray = [NSMutableArray array];

    @try {
        [shareActionArray enumerateObjectsUsingBlock:^(ZoomVideoSDKShareAction * _Nonnull shareAction, NSUInteger idx, BOOL * _Nonnull stop) {
            [mappedShareActionArray addObject: [FlutterZoomVideoSdkShareAction mapShareActionDictionary: shareAction]];
        }];
    }
    @finally {
        return [JSONConvert NSMutableArrayToNSString: mappedShareActionArray];
    }
}

@end
