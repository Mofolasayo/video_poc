#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkAudioHelper: NSObject

@property (nonatomic, strong) NSMutableDictionary<NSString*, ZoomVideoSDKAudioDevice*> * _Nullable inputAudioDeviceMap;
@property (nonatomic, strong) NSMutableDictionary<NSString*, ZoomVideoSDKAudioDevice*> * _Nonnull outputAudioDeviceMap;

-(void) canSwitchSpeaker: (FlutterResult _Nonnull ) result;

-(void) getSpeakerStatus: (FlutterResult _Nonnull ) result;

-(void) setSpeaker:(FlutterMethodCall *_Nonnull)call withResult:(FlutterResult _Nonnull ) result;

-(void) startAudio: (FlutterResult _Nonnull ) result;

-(void) stopAudio: (FlutterResult _Nonnull ) result;

-(void) muteAudio:(FlutterMethodCall *_Nonnull)call withResult:(FlutterResult _Nonnull ) result;

-(void) unMuteAudio:(FlutterMethodCall *_Nonnull)call withResult:(FlutterResult _Nonnull ) result;

-(void) muteAllAudio:(FlutterMethodCall *_Nonnull)call withResult:(FlutterResult _Nonnull ) result;

-(void) unmuteAllAudio: (FlutterResult _Nonnull ) result;

-(void) allowAudioUnmutedBySelf:(FlutterMethodCall *_Nonnull)call withResult:(FlutterResult _Nonnull ) result;

-(void) subscribe: (FlutterResult _Nonnull ) result;

-(void) unSubscribe: (FlutterResult _Nonnull ) result;

-(void) resetAudioSession: (FlutterResult _Nonnull ) result;

-(void) cleanAudioSession: (FlutterResult _Nonnull ) result;

-(void) getCurrentAudioOutputRoute: (FlutterResult _Nonnull ) result;

-(void) setAudioOutputRoute:(FlutterMethodCall *_Nonnull)call withResult:(FlutterResult _Nonnull ) result;

-(void) getAvailableAudioOutputRoute: (FlutterResult _Nonnull ) result;

-(void) getCurrentAudioInputDevice: (FlutterResult _Nonnull ) result;

-(void) getAvailableAudioInputsDevice: (FlutterResult _Nonnull ) result;

-(void) setAudioInputDevice:(FlutterMethodCall *_Nonnull)call withResult:(FlutterResult _Nonnull ) result;

@end
