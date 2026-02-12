#import "FlutterZoomVideoSdkCameraDevice.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkCameraDevice

+ (NSString *)mapCameraDevice: (ZoomVideoSDKCameraDevice *) cameraDevice {
    @try {
        return [JSONConvert NSDictionaryToNSString:
            [self mapCameraDeviceDictionary: cameraDevice]];
    }
    @catch (NSException *e) {
        return @"";
    }
}

+ (NSDictionary *) mapCameraDeviceDictionary: (ZoomVideoSDKCameraDevice*)cameraDevice {
    @try {
        if (cameraDevice == nil) {
            return @{};
        }
        NSDictionary *cameraDeviceData = @{
                @"deviceId": [cameraDevice deviceId],
                @"deviceName": [cameraDevice deviceName],
                @"isSelectedDevice": @([cameraDevice isSelectDevice]),
                @"position": [[JSONConvert AVCaptureDevicePositionValuesReversed] objectForKey: @([cameraDevice position])],
                @"deviceType": [cameraDevice deviceType],
                @"maxZoomFactor": @([cameraDevice maxZoomFactor]),
                @"videoZoomFactorUpscaleThreshold": @([cameraDevice videoZoomFactorUpscaleThreshold]),
        };
        return cameraDeviceData;
        }
        @catch (NSException *e) {
            return @"";
        }
}

+ (NSString *) mapCameraDeviceArray: (NSArray <ZoomVideoSDKCameraDevice*>*) cameraDeviceArray {
    NSMutableArray *mappedCameraDeviceArray = [NSMutableArray array];

    @try {
        [cameraDeviceArray enumerateObjectsUsingBlock:^(ZoomVideoSDKCameraDevice * _Nonnull cameraDevice, NSUInteger idx, BOOL * _Nonnull stop) {
            [mappedCameraDeviceArray addObject: [FlutterZoomVideoSdkCameraDevice mapCameraDeviceDictionary: cameraDevice]];
        }];
    }
    @finally {
        return [JSONConvert NSMutableArrayToNSString: mappedCameraDeviceArray];
    }
}

@end

