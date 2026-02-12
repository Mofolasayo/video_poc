#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkVirtualBackgroundItem: NSObject

+ (NSString *)mapVBItem: (ZoomVideoSDKVirtualBackgroundItem *)item;

+ (NSString *)mapItemArray: (NSArray <ZoomVideoSDKVirtualBackgroundItem*> *)itemArray;

@end