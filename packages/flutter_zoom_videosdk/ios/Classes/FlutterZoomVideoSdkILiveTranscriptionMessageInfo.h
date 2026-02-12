#import <ZoomVideoSDK/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkILiveTranscriptionMessageInfo : NSObject

+ (NSString *) mapMessageInfo: (ZoomVideoSDKLiveTranscriptionMessageInfo*) messageInfo;
+ (NSString *) mapMessageInfoArray: (NSArray <ZoomVideoSDKLiveTranscriptionMessageInfo*>*) messageInfoArray;

@end

