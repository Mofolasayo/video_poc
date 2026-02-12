#import <ZoomVideoSDK/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkCameraDevice : NSObject

+ (NSString *) mapCameraDevice: (ZoomVideoSDKCameraDevice*) cameraDevice;
+ (NSString *) mapCameraDeviceArray: (NSArray <ZoomVideoSDKCameraDevice*>*) cameraDeviceArray;

@end
