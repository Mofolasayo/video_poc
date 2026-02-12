#import <Foundation/Foundation.h>

#import "FlutterZoomVideoSdkAudioDevice.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkAudioDevice

+ (NSString *)mapAudioDevice: (ZoomVideoSDKAudioDevice *) audioDevice {
    @try {
        return [JSONConvert NSDictionaryToNSString:
            [self mapAudioDeviceDictionary: audioDevice]];
    }
    @catch (NSException *e) {
        return @"";
    }
}

+ (NSDictionary *) mapAudioDeviceDictionary: (ZoomVideoSDKAudioDevice*)audioDevice {
    @try {
        if (audioDevice == nil) {
            return @{};
        }
        NSDictionary *audioDeviceData = @{
                @"deviceName": [audioDevice getAudioName],
                @"deviceSourceType": [self audioSourceFromPortType: [audioDevice getAudioSourceType]]
        };
        return audioDeviceData;
        }
        @catch (NSException *e) {
            return @{};
        }
}

+ (NSString *) mapAudioDeviceArray: (NSArray <ZoomVideoSDKAudioDevice*>*) audioDeviceArray {
    NSMutableArray *mappedAudioDeviceArray = [NSMutableArray array];

    @try {
        [audioDeviceArray enumerateObjectsUsingBlock:^(ZoomVideoSDKAudioDevice * _Nonnull audioDevice, NSUInteger idx, BOOL * _Nonnull stop) {
            [mappedAudioDeviceArray addObject: [FlutterZoomVideoSdkAudioDevice mapAudioDeviceDictionary: audioDevice]];
        }];
    }
    @finally {
        return [JSONConvert NSMutableArrayToNSString: mappedAudioDeviceArray];
    }
}

+ (NSString*) audioSourceFromPortType:(NSString *)portType {
    if (!portType) return @"AUDIO_SOURCE_NONE";
    // Speakerphone
    if ([portType isEqualToString:AVAudioSessionPortBuiltInSpeaker]) {
        return @"AUDIO_SOURCE_SPEAKER_PHONE";
    }
    // Earpiece
    if ([portType isEqualToString:AVAudioSessionPortBuiltInReceiver]) {
        return @"AUDIO_SOURCE_EAR_PHONE";
    }
    
    if (@available(iOS 17.0, *)) {
        if ([portType isEqualToString:AVAudioSessionPortBuiltInMic] ||
            [portType isEqualToString:AVAudioSessionPortContinuityMicrophone]) {
            return @"AUDIO_SOURCE_BUILTIN_MIC";
        }
    }
    // Wired devices
    if ([portType isEqualToString:AVAudioSessionPortHeadsetMic] ||
        [portType isEqualToString:AVAudioSessionPortHeadphones] ||
        [portType isEqualToString:AVAudioSessionPortLineIn] ||
        [portType isEqualToString:AVAudioSessionPortLineOut] ||
        [portType isEqualToString:AVAudioSessionPortUSBAudio] ||
        [portType isEqualToString:AVAudioSessionPortHDMI] ||
        [portType isEqualToString:AVAudioSessionPortDisplayPort] ||
        [portType isEqualToString:AVAudioSessionPortThunderbolt] ||
        [portType isEqualToString:AVAudioSessionPortPCI] ||
        [portType isEqualToString:AVAudioSessionPortFireWire] ||
        [portType isEqualToString:AVAudioSessionPortAVB]) {
        return @"AUDIO_SOURCE_WIRED";
    }
    // Bluetooth devices
    if ([portType isEqualToString:AVAudioSessionPortBluetoothA2DP] ||
        [portType isEqualToString:AVAudioSessionPortBluetoothHFP] ||
        [portType isEqualToString:AVAudioSessionPortBluetoothLE] ||
        [portType isEqualToString:AVAudioSessionPortCarAudio]) {
        return @"AUDIO_SOURCE_BLUETOOTH";
    }
    
    if ([portType isEqualToString:AVAudioSessionPortAirPlay]) {
        return @"AUDIO_SOURCE_AIRPLAY";
    }
    // Everything else
    return @"AUDIO_SOURCE_NONE";
}

@end
