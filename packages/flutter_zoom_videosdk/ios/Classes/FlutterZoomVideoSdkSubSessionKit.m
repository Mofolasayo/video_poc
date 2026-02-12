#import "FlutterZoomVideoSdkSubSessionKit.h"
#import "FlutterZoomVideoSdkSubSessionUser.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkSubSessionKit

+ (NSString *)mapSubSessionKit:(ZoomVideoSDKSubSessionKit *)subSessionKit {
    @try {
        return [JSONConvert NSDictionaryToNSString:
            [self mapSubSessionKitDictionary: subSessionKit]];
    }
    @catch (NSException *e) {
        return @"";
    }
}

+ (NSDictionary *) mapSubSessionKitDictionary:(ZoomVideoSDKSubSessionKit *)subSessionKit {
    @try {
        if (subSessionKit == nil) {
            return @{};
        }
        NSDictionary *subSessionKitData = @{
                @"subSessionId": [subSessionKit getSubSessionID],
                @"subSessionName": [subSessionKit getSubSessionName],
                @"subSessionUserList": [FlutterZoomVideoSdkSubSessionUser mapSubSessionUserArray:[subSessionKit getSubSessionUserList]],
        };
        return subSessionKitData;
    }
    @catch (NSException *e) {
        return @"";
    }
}

+ (NSString *) mapSubSessionKitArray: (NSArray <ZoomVideoSDKSubSessionKit*>*)subSessionKitArray {
    NSMutableArray *mappedSubSessionKitArray = [NSMutableArray array];

    @try {
        [subSessionKitArray enumerateObjectsUsingBlock:^(ZoomVideoSDKSubSessionKit * _Nonnull subSessionKit, NSUInteger idx, BOOL * _Nonnull stop) {
            [mappedSubSessionKitArray addObject: [FlutterZoomVideoSdkSubSessionKit mapSubSessionKitDictionary: subSessionKit]];
        }];
    }
    @finally {
        return [JSONConvert NSMutableArrayToNSString: mappedSubSessionKitArray];
    }
}

@end
