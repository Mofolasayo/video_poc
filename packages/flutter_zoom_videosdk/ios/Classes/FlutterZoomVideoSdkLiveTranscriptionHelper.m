#import "FlutterZoomVideoSdkLiveTranscriptionHelper.h"
#import "FlutterZoomVideoSdkLiveTranscriptionLanguage.h"
#import "FlutterZoomVideoSdkILiveTranscriptionMessageInfo.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkLiveTranscriptionHelper

- (ZoomVideoSDKLiveTranscriptionHelper *)getLiveTranscriptionHelper {
    ZoomVideoSDKLiveTranscriptionHelper* liveTranscriptionHelper = nil;
    @try {
        liveTranscriptionHelper = [[ZoomVideoSDK shareInstance] getLiveTranscriptionHelper];
        if (liveTranscriptionHelper == nil) {
            NSException *e = [NSException exceptionWithName:@"NoRecordingHelperFound" reason:@"No Live Transcription Helper Found" userInfo:nil];
            @throw e;
        }
    } @catch(NSException *e) {
        NSLog(@"%@ - %@", e.name, e.reason);
    }
    return liveTranscriptionHelper;
}

-(void) canStartLiveTranscription: (FlutterResult) result {
    if ([[self getLiveTranscriptionHelper] canStartLiveTranscription]) {
        result(@YES);
    } else {
        result(@NO);
    }
}

-(void) getLiveTranscriptionStatus: (FlutterResult) result {
    result([[JSONConvert ZoomVideoSDKLiveTranscriptionStatusValuesReversed] objectForKey: @([[self getLiveTranscriptionHelper] getLiveTranscriptionStatus])]);
}

-(void) startLiveTranscription: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getLiveTranscriptionHelper] startLiveTranscription])]);
   });
}

-(void) stopLiveTranscription: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getLiveTranscriptionHelper] stopLiveTranscription])]);
   });
}

-(void) getAvailableSpokenLanguages: (FlutterResult) result {
    NSArray <ZoomVideoSDKLiveTranscriptionLanguage*>* languageList = [[self getLiveTranscriptionHelper] getAvailableSpokenLanguages];

    if (languageList == nil | [languageList count] == 0) {
        result(@"getAvailableSpokenLanguages: No Languages Found");
    }

    result([FlutterZoomVideoSdkLiveTranscriptionLanguage mapLanguageArray:languageList]);
}

-(void) setSpokenLanguage: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getLiveTranscriptionHelper] setSpokenLanguage: [call.arguments[@"languageID"] integerValue]])]);
}

-(void) getSpokenLanguage: (FlutterResult) result {
    ZoomVideoSDKLiveTranscriptionLanguage* language = [[self getLiveTranscriptionHelper] getSpokenLanguage];

    if (language == nil) {
        result(@"getSpokenLanguage: No Languages Found");
    }

    result([FlutterZoomVideoSdkLiveTranscriptionLanguage mapLanguage:language]);
}

-(void) getAvailableTranslationLanguages: (FlutterResult) result {
    NSArray <ZoomVideoSDKLiveTranscriptionLanguage*>* languageList = [[self getLiveTranscriptionHelper] getAvailableTranslationLanguages];

    if (languageList == nil | [languageList count] == 0) {
        result(@"getAvailableTranslationLanguages: No Languages Found");
    }

    result([FlutterZoomVideoSdkLiveTranscriptionLanguage mapLanguageArray:languageList]);
}

-(void) setTranslationLanguage: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getLiveTranscriptionHelper] setTranslationLanguage: [call.arguments[@"languageID"] integerValue]])]);
}

-(void) getTranslationLanguage: (FlutterResult) result {
    ZoomVideoSDKLiveTranscriptionLanguage* language = [[self getLiveTranscriptionHelper] getTranslationLanguage];

    if (language == nil) {
        result(@"getTranslationLanguage: No Languages Found");
    }

    result([FlutterZoomVideoSdkLiveTranscriptionLanguage mapLanguage:language]);
}

-(void) enableReceiveSpokenLanguageContent: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getLiveTranscriptionHelper] enableReceiveSpokenLanguageContent: [call.arguments[@"enabled"] boolValue]])]);
    });
}

-(void) isReceiveSpokenLanguageContentEnabled: (FlutterResult) result {
    result(@([[self getLiveTranscriptionHelper] isReceiveSpokenLanguageContentEnabled]));
}

-(void) isAllowViewHistoryTranslationMessageEnabled: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result(@([[self getLiveTranscriptionHelper] isAllowViewFullTranscriptEnable]));
    });
}

-(void) getHistoryTranslationMessageList: (FlutterResult) result {

    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray <ZoomVideoSDKLiveTranscriptionMessageInfo*>* messageInfoList = [[self getLiveTranscriptionHelper] getHistoryTranslationMessageList];
        result([FlutterZoomVideoSdkILiveTranscriptionMessageInfo mapMessageInfoArray: messageInfoList]);
    });
}

@end
