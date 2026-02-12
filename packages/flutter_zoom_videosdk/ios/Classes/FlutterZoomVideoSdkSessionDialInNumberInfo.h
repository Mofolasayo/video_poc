#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkSessionDialInNumberInfo: NSObject

+ (NSString *)mapSessionDialInNumberInfo: (ZoomVideoSDKDialInNumberInfo*) sessionDialInNumberInfo;

+ (NSString *)mapSessionDialInNumberInfoArray: (NSArray<ZoomVideoSDKDialInNumberInfo *> *)dialInNumberInfoArray;

@end