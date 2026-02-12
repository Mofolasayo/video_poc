#import "FlutterZoomVideoSdkILiveTranscriptionMessageInfo.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkILiveTranscriptionMessageInfo

+ (NSDictionary *) mapMessageInfoDictionary: (ZoomVideoSDKLiveTranscriptionMessageInfo*) messageInfo {
    @try {
        if (messageInfo == nil) {
            return @{};
        }
        NSDictionary *messageInfoData = @{
                @"messageID": [messageInfo messageID],
                @"messageContent": [messageInfo messageContent],
                @"messageType": [[JSONConvert ZoomVideoSDKLiveTranscriptionOperationTypeValuesReversed] objectForKey: @([messageInfo messageType])],
                @"speakerID": [messageInfo speakerID],
                @"speakerName": [messageInfo speakerName],
                @"timeStamp": [NSString stringWithFormat:@"%d",[messageInfo timeStamp]],
        };
        return messageInfoData;
    }
    @catch (NSException *e) {
        return @{};
    }
}


+ (NSString *) mapMessageInfo: (ZoomVideoSDKLiveTranscriptionMessageInfo*) messageInfo {
    @try {
        return [JSONConvert NSDictionaryToNSString:
            [self mapMessageInfoDictionary: messageInfo]];
    }
    @catch (NSException *e) {
        return @"";
    }
}

+ (NSString *) mapMessageInfoArray: (NSArray <ZoomVideoSDKLiveTranscriptionMessageInfo*>*) messageInfoArray {
    NSMutableArray *mappedMessageInfoArray = [NSMutableArray array];

    @try {
        [messageInfoArray enumerateObjectsUsingBlock:^(ZoomVideoSDKLiveTranscriptionMessageInfo * _Nonnull messageInfo, NSUInteger idx, BOOL * _Nonnull stop) {
            [mappedMessageInfoArray addObject: [self mapMessageInfoDictionary: messageInfo]];
        }];
    }
    @finally {
        return [JSONConvert NSMutableArrayToNSString: mappedMessageInfoArray];
    }
}

@end
