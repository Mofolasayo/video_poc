#import <ZoomVideoSDK/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkAudioDevice : NSObject

+ (NSString *) mapAudioDevice: (ZoomVideoSDKAudioDevice*) audioDevice;
+ (NSString *) mapAudioDeviceArray: (NSArray <ZoomVideoSDKAudioDevice*>*) audioDeviceArray;
+ (NSString *) audioSourceFromPortType:(NSString *)portType;

@end
