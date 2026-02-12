#import "FlutterZoomVideoSdkSubSessionHelper.h"
#import "FlutterZoomVideoSdkSubSessionKit.h"
#import "FlutterZoomVideoSdkSubSessionUser.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkSubSessionHelper {
    NSMutableDictionary<NSString *, ZoomVideoSDKSubSessionKit *> *subSessionKitMap;
}

static ZoomVideoSDKSubSessionManager *subSessionManager;
static ZoomVideoSDKSubSessionParticipant *subSessionParticipant;
static ZoomVideoSDKSubSessionUserHelpRequestHandler *subSessionUserHelpRequestHandler;

- (instancetype)init {
    self = [super init];
    if (self) {
        subSessionKitMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (ZoomVideoSDKSubSessionHelper *)getSubSessionHelper {
    ZoomVideoSDKSubSessionHelper *subSessionHelper = nil;

    @try {
        subSessionHelper = [[ZoomVideoSDK shareInstance] getsubSessionHelper];
        if (subSessionHelper == nil) {
            @throw [NSException exceptionWithName:@"SubSessionHelperException"
                                           reason:@"No SubSession Helper Found"
                                         userInfo:nil];
        }
    } @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }

    return subSessionHelper;
}

+(void) storeSubSessionUserHelpRequestHandler:(ZoomVideoSDKSubSessionUserHelpRequestHandler *)handler {
    subSessionUserHelpRequestHandler = handler;
}

+(void) storeSubSessionManager:(ZoomVideoSDKSubSessionManager *)manager {
    subSessionManager = manager;
}

+(void) storeSubSessionParticipant:(ZoomVideoSDKSubSessionParticipant *)participant {
    subSessionParticipant = participant;
}

-(void) joinSubSession:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSDictionary *args = call.arguments;
    if (args == nil) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey:@(Errors_Invalid_Parameter)]
                                   message:@"No call arguments"
                                   details:nil]);
        return;
    }

    NSString *subSessionId = args[@"subSessionId"];
    ZoomVideoSDKSubSessionKit *subSessionKit = subSessionKitMap[subSessionId];
    if (subSessionKit == nil) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey:@(Errors_Invalid_Parameter)]
                                   message:@"No SubSessionKit found for the given subSessionId"
                                   details:nil]);
        return;
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey:@([subSessionKit joinSubSession])]);
    });
}

-(void) startSubSession:(FlutterResult)result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey:@([subSessionManager startSubSession])]);
    });
}

-(void) isSubSessionStarted:(FlutterResult)result {
    if ([subSessionManager isSubSessionStarted]) {
        result(@YES);
    } else {
        result(@NO);
    }
}

-(void) stopSubSession:(FlutterResult)result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey:@([subSessionManager stopSubSession])]);
    });
}

-(void) broadcastMessage:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSDictionary *args = call.arguments;
    NSString *message = args[@"message"];

    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey:@([subSessionManager broadcastMessage:message])]);
    });
}

-(void) returnToMainSession:(FlutterResult)result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey:@([subSessionParticipant returnToMainSession])]);
    });
}

-(void) requestForHelp:(FlutterResult)result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey:@([subSessionParticipant requestForHelp])]);
    });
}

-(void) getRequestUserName:(FlutterResult)result {
    result([subSessionUserHelpRequestHandler getRequestUserName]);
}

-(void) getRequestSubSessionName:(FlutterResult)result {
    result([subSessionUserHelpRequestHandler getRequestSubSessionName]);
}

-(void) ignoreUserHelpRequest:(FlutterResult)result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey:@([subSessionUserHelpRequestHandler ignore])]);
    });
}

-(void) joinSubSessionByUserRequest:(FlutterResult)result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey:@([subSessionUserHelpRequestHandler joinSubSessionByUserRequest])]);
    });
}

-(void) commitSubSessionList:(FlutterMethodCall *)call withResult:(FlutterResult)result {
    NSArray<NSString *> *subSessionNames = call.arguments;

    dispatch_async(dispatch_get_main_queue(), ^{
        ZoomVideoSDKError err = [[self getSubSessionHelper] addSubSessionToPreList: subSessionNames];
        if (err == Errors_Success) {
            result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey:@([[self getSubSessionHelper] commitSubSessionList])]);
        } else {
            result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey:@(err)]
                                       message:@"Not able to commit SubSessionList"
                                       details:nil]);
        }
        
    });
}

-(void) getCommittedSubSessionList:(FlutterResult)result {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray<ZoomVideoSDKSubSessionKit *> *subSessionKits = [[self getSubSessionHelper] getCommittedSubSessionList];
        for (ZoomVideoSDKSubSessionKit *kit in subSessionKits) {
            [self->subSessionKitMap setObject:kit forKey:[kit getSubSessionID]];
        }
        result([FlutterZoomVideoSdkSubSessionKit mapSubSessionKitArray:subSessionKits]);
    });
}

-(void) withdrawSubSessionList:(FlutterResult)result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey:@([[self getSubSessionHelper] withdrawSubSessionList])]);
    });
}

@end
