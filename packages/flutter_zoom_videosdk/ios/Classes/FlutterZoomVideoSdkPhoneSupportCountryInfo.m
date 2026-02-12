#import "FlutterZoomVideoSdkPhoneSupportCountryInfo.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkPhoneSupportCountryInfo

+ (NSString *)mapCountry: (ZoomVideoSDKPhoneSupportCountryInfo *) country {
    @try {
        return [JSONConvert NSDictionaryToNSString:
            [FlutterZoomVideoSdkPhoneSupportCountryInfo mapCountryDictionary: country]];
    }
    @catch (NSException *e) {
        return @"";
    }
}

+ (NSDictionary *)mapCountryDictionary: (ZoomVideoSDKPhoneSupportCountryInfo *) country {
    @try {
        return @{
            @"countryID": [country countryID],
            @"countryName": [country countryName],
            @"countryCode": [country countryCode],
        };
    }
    @catch (NSException *e) {
        return @{};
    }
}

+ (NSString *)mapPhoneSupportCountryInfo: (NSArray<ZoomVideoSDKPhoneSupportCountryInfo *> *)countryList {

    NSMutableArray *mappedCountryArray = [NSMutableArray array];

    @try {
        [countryList enumerateObjectsUsingBlock:^(ZoomVideoSDKPhoneSupportCountryInfo * _Nonnull country, NSUInteger idx, BOOL * _Nonnull stop){
            [mappedCountryArray addObject: [FlutterZoomVideoSdkPhoneSupportCountryInfo mapCountryDictionary: country]];
        }];
    }
    @finally {
        return [JSONConvert NSMutableArrayToNSString: mappedCountryArray];
    }
}

@end
