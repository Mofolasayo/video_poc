#import "FlutterZoomVideoSdkSubSessionUser.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkSubSessionUser

+ (NSString *)mapSubSessionUser:(ZoomVideoSDKSubSessionUser *)subSessionUser {
    @try {
        return [JSONConvert NSDictionaryToNSString:
            [self mapSubSessionUserDictionary: subSessionUser]];
    }
    @catch (NSException *e) {
        return @"";
    }
}

+ (NSDictionary *) mapSubSessionUserDictionary:(ZoomVideoSDKSubSessionUser *)subSessionUser {
    @try {
        if (subSessionUser == nil) {
            return @{};
        }
        NSDictionary *subSessionUserData = @{
                @"userGUID": [subSessionUser getUserGUID] ?: @"",
                @"userName": [subSessionUser getUserName] ?: @"",
        };
        return subSessionUserData;
    }
    @catch (NSException *e) {
        return @{};
    }
}

+ (NSString *) mapSubSessionUserArray: (NSArray <ZoomVideoSDKSubSessionUser*>*)subSessionUserArray {
    NSMutableArray *mappedSubSessionUserArray = [NSMutableArray array];

    @try {
        [subSessionUserArray enumerateObjectsUsingBlock:^(ZoomVideoSDKSubSessionUser * _Nonnull subSessionUser, NSUInteger idx, BOOL * _Nonnull stop) {
            [mappedSubSessionUserArray addObject: [FlutterZoomVideoSdkSubSessionUser mapSubSessionUserDictionary: subSessionUser]];
        }];
    }
    @finally {
        return [JSONConvert NSMutableArrayToNSString: mappedSubSessionUserArray];
    }
}

@end