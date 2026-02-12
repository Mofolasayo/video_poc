#import "FlutterZoomVideoSdkAudioSettingHelper.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkAudioSettingHelper

- (ZoomVideoSDKAudioSettingHelper *)getAudioSettingHelper {
    ZoomVideoSDKAudioSettingHelper* audioSettingHelper = nil;
    @try {
        audioSettingHelper = [[ZoomVideoSDK shareInstance] getAudioSettingHelper];
        if (audioSettingHelper == nil) {
            NSException *e = [NSException exceptionWithName:@"NoAudioSettingHelperFound" reason:@"No Audio Setting Helper Found" userInfo:nil];
            @throw e;
        }
    } @catch (NSException *e) {
        NSLog(@"%@ - %@", e.name, e.reason);
    }
    return audioSettingHelper;
}

-(void) isMicOriginalInputEnable: (FlutterResult) result {
    if ([[self getAudioSettingHelper] isMicOriginalInputEnable]) {
        result(@YES);
    } else {
        result(@NO);
    }
}

-(void) enableMicOriginalInput: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAudioSettingHelper] enableMicOriginalInput:[call.arguments[@"enable"] boolValue]])]);
    });

}

-(void) isAutoAdjustMicVolumeEnabled: (FlutterResult) result {
    if ([[self getAudioSettingHelper] isAutoAdjustMicVolumeEnabled]) {
        result(@YES);
    } else {
        result(@NO);
    }
}

-(void) enableAutoAdjustMicVolume: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAudioSettingHelper] enableAutoAdjustMicVolume:[call.arguments[@"enable"] boolValue]])]);
    });

}

@end
