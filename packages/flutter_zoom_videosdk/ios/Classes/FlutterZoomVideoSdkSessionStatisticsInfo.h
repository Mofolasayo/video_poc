#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkSessionStatisticsInfo: NSObject

// -----------------------------------------------------------------------------------------------
// Audio Statistics Info
// -----------------------------------------------------------------------------------------------

-(void) getAudioStatisticsInfo:(FlutterResult) result;

-(void) getAudioRecvFrequency:(FlutterResult) result;

-(void) getAudioRecvJitter:(FlutterResult) result;

-(void) getAudioRecvLatency:(FlutterResult) result;

-(void) getAudioRecvPacketLossAvg:(FlutterResult) result;

-(void) getAudioRecvPacketLossMax:(FlutterResult) result;

-(void) getAudioSendFrequency:(FlutterResult) result;

-(void) getAudioSendJitter:(FlutterResult) result;

-(void) getAudioSendLatency:(FlutterResult) result;

-(void) getAudioSendPacketLossAvg:(FlutterResult) result;

-(void) getAudioSendPacketLossMax:(FlutterResult) result;

// -----------------------------------------------------------------------------------------------
// Video Statistics Info
// -----------------------------------------------------------------------------------------------

-(void) getVideoStatisticsInfo:(FlutterResult) result;

-(void) getVideoRecvFps:(FlutterResult) result;

-(void) getVideoRecvFrameHeight:(FlutterResult) result;

-(void) getVideoRecvFrameWidth:(FlutterResult) result;

-(void) getVideoRecvJitter:(FlutterResult) result;

-(void) getVideoRecvLatency:(FlutterResult) result;

-(void) getVideoRecvPacketLossAvg:(FlutterResult) result;

-(void) getVideoRecvPacketLossMax:(FlutterResult) result;

-(void) getVideoSendFps:(FlutterResult) result;

-(void) getVideoSendFrameHeight:(FlutterResult) result;

-(void) getVideoSendFrameWidth:(FlutterResult) result;

-(void) getVideoSendJitter:(FlutterResult) result;

-(void) getVideoSendLatency:(FlutterResult) result;

-(void) getVideoSendPacketLossAvg:(FlutterResult) result;

-(void) getVideoSendPacketLossMax:(FlutterResult) result;

// -----------------------------------------------------------------------------------------------
// Share Statistics Info
// -----------------------------------------------------------------------------------------------

-(void) getShareStatisticsInfo:(FlutterResult) result;

-(void) getShareRecvFps:(FlutterResult) result;

-(void) getShareRecvFrameHeight:(FlutterResult) result;

-(void) getShareRecvFrameWidth:(FlutterResult) result;

-(void) getShareRecvJitter:(FlutterResult) result;

-(void) getShareRecvLatency:(FlutterResult) result;

-(void) getShareRecvPacketLossAvg:(FlutterResult) result;

-(void) getShareRecvPacketLossMax:(FlutterResult) result;

-(void) getShareSendFps:(FlutterResult) result;

-(void) getShareSendFrameHeight:(FlutterResult) result;

-(void) getShareSendFrameWidth:(FlutterResult) result;

-(void) getShareSendJitter:(FlutterResult) result;

-(void) getShareSendLatency:(FlutterResult) result;

-(void) getShareSendPacketLossAvg:(FlutterResult) result;

-(void) getShareSendPacketLossMax:(FlutterResult) result;

@end
