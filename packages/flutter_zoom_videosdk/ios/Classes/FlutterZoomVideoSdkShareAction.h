#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkShareAction: NSObject

+ (NSString *) mapShareAction: (ZoomVideoSDKShareAction*) shareAction;

+ (NSString *) mapShareActionArray: (NSArray <ZoomVideoSDKShareAction*>*)shareActionArray;

@end

