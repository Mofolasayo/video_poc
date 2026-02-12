#import "FlutterZoomVideoSdkAudioHelper.h"
#import "FlutterZoomVideoSdkUser.h"
#import "FlutterZoomVideoSdkAudioDevice.h"
#import "JSONConvert.h"
#import <AVFAudio/AVAudioSession.h>

@implementation FlutterZoomVideoSdkAudioHelper

- (ZoomVideoSDKAudioHelper *)getAudioHelper {
    ZoomVideoSDKAudioHelper* audioHelper = nil;
    @try {
        audioHelper = [[ZoomVideoSDK shareInstance] getAudioHelper];
        if (audioHelper == nil) {
            NSException *e = [NSException exceptionWithName:@"NoAudioHelperFound" reason:@"No Audio Helper Found" userInfo:nil];
            @throw e;
        }
    } @catch (NSException *e) {
        NSLog(@"%@ - %@", e.name, e.reason);
    }
    return audioHelper;
}

-(void) canSwitchSpeaker: (FlutterResult) result {
    // There's no API for retrieving available outputs other than external devices
    // since iOS devices always have "Speaker".
    result(@YES);
}

-(void) getSpeakerStatus: (FlutterResult) result {
    for (AVAudioSessionPortDescription *output in [[[AVAudioSession sharedInstance] currentRoute] outputs]) {
        if ([[output portType] isEqualToString:@"Speaker"]) {
            result(@YES);
        } else {
            result(@NO);
        }
    }
}

-(void) setSpeaker:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSError *error;
    AVAudioSessionPortOverride override =  [call.arguments[@"isOn"] boolValue] ? AVAudioSessionPortOverrideSpeaker : AVAudioSessionPortOverrideNone;
    [[AVAudioSession sharedInstance] overrideOutputAudioPort:override error:&error];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    if (error) {
        NSLog(@"%@", error);
    } else {
        result(@"ZoomVideoSDKError_Success");
    }
}

-(void) startAudio: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAudioHelper] startAudio])]);
    });
}

-(void) stopAudio: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAudioHelper] stopAudio])]);
    });
}

-(void) muteAudio:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* userId = call.arguments[@"userId"];
        if ([userId length] == 0) {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                       message:@"UserId is empty"
                                       details:nil]);
        }
        ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
        if (user != nil) {
            result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAudioHelper] muteAudio:user])]);
        } else {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                       message:@"User not found"
                                       details:nil]);
        }
    });
}

-(void) unMuteAudio:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* userId = call.arguments[@"userId"];
        if ([userId length] == 0) {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                       message:@"UserId is empty"
                                       details:nil]);
        }
        ZoomVideoSDKUser *user = [FlutterZoomVideoSdkUser getUser:userId];
        if (user != nil) {
            result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAudioHelper] unmuteAudio:user])]);
        } else {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                       message:@"User not found"
                                       details:nil]);
        }
    });
}

-(void) muteAllAudio:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAudioHelper] muteAllAudio:[call.arguments[@"allowUnmute"] boolValue]])]);
    });
}

-(void) unmuteAllAudio: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAudioHelper] unmuteAllAudio])]);
    });
}

-(void) allowAudioUnmutedBySelf:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAudioHelper] allowAudioUnmutedBySelf:[call.arguments[@"allowUnmute"] boolValue]])]);
    });
}

-(void) subscribe: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAudioHelper] subscribe])]);
    });
}

-(void) unSubscribe: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAudioHelper] unSubscribe])]);
    });
}

-(void) resetAudioSession: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[self getAudioHelper] resetAudioSession]) {
            result(@YES);
        } else {
            result(@NO);
        }
    }
  );
}

-(void) cleanAudioSession: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self getAudioHelper] cleanAudioSession];
    });
}

-(void) getAvailableAudioOutputRoute: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray <ZoomVideoSDKAudioDevice*>* audioDeviceList = [[self getAudioHelper] getAvailableAudioOutputRoute];
        if (self->_outputAudioDeviceMap == nil) {
            self->_outputAudioDeviceMap = [NSMutableDictionary dictionary];
        }
        [self->_outputAudioDeviceMap removeAllObjects];

        for (ZoomVideoSDKAudioDevice *device in audioDeviceList) {
            if (device && [device getAudioName]) {
                NSString* deviceName = [device getAudioName];
                self->_outputAudioDeviceMap[deviceName] = device;
            }
        }
        result([FlutterZoomVideoSdkAudioDevice mapAudioDeviceArray: audioDeviceList]);
    });
}

-(void) setAudioOutputRoute:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* deviceName = call.arguments[@"deviceName"];
    ZoomVideoSDKAudioDevice *device = _outputAudioDeviceMap[deviceName];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        result(@([[self getAudioHelper] setAudioOutputRoute: device]));
    });
}

-(void) getCurrentAudioOutputRoute: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([FlutterZoomVideoSdkAudioDevice mapAudioDevice: [[self getAudioHelper] getCurrentAudioOutputRoute]]);
    });
}

-(void) getAvailableAudioInputsDevice: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray <ZoomVideoSDKAudioDevice*>* audioDeviceList = [[self getAudioHelper] getAvailableAudioInputsDevice];
        if (self->_inputAudioDeviceMap == nil) {
            self->_inputAudioDeviceMap = [NSMutableDictionary dictionary];
        }
        [self->_inputAudioDeviceMap removeAllObjects];

        for (ZoomVideoSDKAudioDevice *device in audioDeviceList) {
            if (device && [device getAudioName]) {
                NSString* deviceName = [device getAudioName];
                self->_inputAudioDeviceMap[deviceName] = device;
            }
        }
        result([FlutterZoomVideoSdkAudioDevice mapAudioDeviceArray: audioDeviceList]);
    });
}

-(void) setAudioInputDevice:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* deviceName = call.arguments[@"deviceName"];
    ZoomVideoSDKAudioDevice *device = _inputAudioDeviceMap[deviceName];
    dispatch_async(dispatch_get_main_queue(), ^{
        result(@([[self getAudioHelper] setAudioInputDevice: device]));
    });
}

-(void) getCurrentAudioInputDevice: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([FlutterZoomVideoSdkAudioDevice mapAudioDevice: [[self getAudioHelper] getCurrentAudioInputDevice]]);
    });
}

@end
