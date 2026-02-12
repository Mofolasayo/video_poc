#import "FlutterZoomVideoSdkLiveTranscriptionLanguage.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkLiveTranscriptionLanguage

+ (NSDictionary  *) mapLanguageDictionary: (ZoomVideoSDKLiveTranscriptionLanguage*) language {
    @try {
        if (language == nil) {
            return @{};
        }
        NSDictionary *languageData = @{
                @"languageId": @([language languageID]),
                @"languageName": [language languageName],
        };
        return languageData;
    }
    @catch (NSException *e) {
        return @{};
    }
}

+ (NSString *) mapLanguage: (ZoomVideoSDKLiveTranscriptionLanguage*) language {
    @try {
        return [JSONConvert NSDictionaryToNSString:
            [self mapLanguageDictionary: language]];
    }
    @catch (NSException *e) {
        return @"";
    }
}

+ (NSString *)mapLanguageArray: (NSArray <ZoomVideoSDKLiveTranscriptionLanguage*> *)languageArray {
    NSMutableArray *mappedLanguageArray = [NSMutableArray array];

    @try {
        [languageArray enumerateObjectsUsingBlock:^(ZoomVideoSDKLiveTranscriptionLanguage * _Nonnull language, NSUInteger idx, BOOL * _Nonnull stop) {
            [mappedLanguageArray addObject: [self mapLanguageDictionary: language]];
        }];
    }
    @finally {
        return [JSONConvert NSMutableArrayToNSString: mappedLanguageArray];
    }
}

@end
