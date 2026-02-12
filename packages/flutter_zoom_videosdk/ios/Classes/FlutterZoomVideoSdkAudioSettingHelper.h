#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkAudioSettingHelper: NSObject

-(void) isMicOriginalInputEnable: (FlutterResult) result;

-(void) enableMicOriginalInput: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) isAutoAdjustMicVolumeEnabled: (FlutterResult) result;

-(void) enableAutoAdjustMicVolume: (FlutterMethodCall *)call withResult:(FlutterResult) result;

@end
