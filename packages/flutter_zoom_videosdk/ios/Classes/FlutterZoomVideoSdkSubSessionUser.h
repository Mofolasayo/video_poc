#import <Foundation/Foundation.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkSubSessionUser: NSObject

+ (NSString *)mapSubSessionUser:(ZoomVideoSDKSubSessionUser *)subSessionUser;

+ (NSString *) mapSubSessionUserArray: (NSArray <ZoomVideoSDKSubSessionUser*>*)subSessionUserArray;

@end
