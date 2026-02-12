#import "FlutterZoomVideoSdkSessionDialInNumberInfo.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkSessionDialInNumberInfo

+ (NSDictionary *)mapSessionDialInNumberInfoDictionary: (ZoomVideoSDKDialInNumberInfo*) sessionDialInNumberInfo {
    @try {
        if (sessionDialInNumberInfo == nil) {
            return @{};
        }
        NSDictionary *dialInNumberInfoData = @{
                @"countryID": [sessionDialInNumberInfo countryID],
                @"countryCode": [sessionDialInNumberInfo countryCode],
                @"countryName": [sessionDialInNumberInfo countryName],
                @"number": [sessionDialInNumberInfo number],
                @"displayNumber": [sessionDialInNumberInfo displayNumber],
                @"type": [[JSONConvert ZoomVideoSDKDialInNumTypeValuesReversed] objectForKey: @([sessionDialInNumberInfo type])],
        };
        return dialInNumberInfoData;
    }
    @catch (NSException *e) {
        return @{};
    }
}

+ (NSString *)mapSessionDialInNumberInfo: (ZoomVideoSDKDialInNumberInfo*) sessionDialInNumberInfo {
    @try {
        return [JSONConvert NSDictionaryToNSString:
            [self mapSessionDialInNumberInfoDictionary: sessionDialInNumberInfo]];
    }
    @catch (NSException *e) {
        return @"";
    }
}

+ (NSString *)mapSessionDialInNumberInfoArray: (NSArray <ZoomVideoSDKDialInNumberInfo*> *)dialInNumberInfoArray {
    NSMutableArray *mappedDialInNumberInfoArray = [NSMutableArray array];

    @try {
        [dialInNumberInfoArray enumerateObjectsUsingBlock:^(ZoomVideoSDKDialInNumberInfo * _Nonnull sessionDialInNumberInfo, NSUInteger idx, BOOL * _Nonnull stop) {
            [mappedDialInNumberInfoArray addObject: [self mapSessionDialInNumberInfoDictionary: sessionDialInNumberInfo]];
        }];
    }
    @finally {
        return [JSONConvert NSMutableArrayToNSString: mappedDialInNumberInfoArray];
    }
}

@end
