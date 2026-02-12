#import <Flutter/Flutter.h>
#import <ZoomVideoSdk/ZoomVideoSDK.h>

@interface FlutterZoomVideoSdkLiveTranscriptionHelper: NSObject

-(void) canStartLiveTranscription: (FlutterResult) result;

-(void) getLiveTranscriptionStatus: (FlutterResult) result;

-(void) startLiveTranscription: (FlutterResult) result;

-(void) stopLiveTranscription: (FlutterResult) result;

-(void) getAvailableSpokenLanguages: (FlutterResult) result;

-(void) setSpokenLanguage: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getSpokenLanguage: (FlutterResult) result;

-(void) getAvailableTranslationLanguages: (FlutterResult) result;

-(void) setTranslationLanguage: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getTranslationLanguage: (FlutterResult) result;

-(void) enableReceiveSpokenLanguageContent: (FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) isReceiveSpokenLanguageContentEnabled: (FlutterResult) result;

-(void) isAllowViewHistoryTranslationMessageEnabled: (FlutterResult) result;

-(void) getHistoryTranslationMessageList: (FlutterResult) result;

@end
