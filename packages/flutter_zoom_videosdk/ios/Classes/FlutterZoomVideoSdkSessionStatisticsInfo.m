#import "FlutterZoomVideoSdkSessionStatisticsInfo.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkSessionStatisticsInfo

- (ZoomVideoSDKSession *)getSession {
    ZoomVideoSDKSession* session = nil;

    @try {
        session = [[ZoomVideoSDK shareInstance] getSession];
        if (session == nil) {
            NSException *e = [NSException exceptionWithName:@"NoSessionFound" reason:@"No Session Found" userInfo:nil];
            @throw e;
        }
    } @catch (NSException *e) {
        NSLog(@"%@ - %@", e.name, e.reason);
    }

    return session;
}

// -----------------------------------------------------------------------------------------------
// Audio Statistics Info
// -----------------------------------------------------------------------------------------------

-(void) getAudioStatisticsInfo:(FlutterResult) result {
    NSInteger recvFrequency = [[[self getSession] getSessionAudioStatisticInfo] recvFrequency];
    NSInteger recvJitter = [[[self getSession] getSessionAudioStatisticInfo] recvJitter];
    NSInteger recvLatency = [[[self getSession] getSessionAudioStatisticInfo] recvLatency];
    CGFloat recvPacketLossAvg = [[[self getSession] getSessionAudioStatisticInfo] recvPacketLossAvg];
    CGFloat recvPacketLossMax = [[[self getSession] getSessionAudioStatisticInfo] recvPacketLossMax];
    NSInteger sendFrequency = [[[self getSession] getSessionAudioStatisticInfo] sendFrequency];
    NSInteger sendJitter = [[[self getSession] getSessionAudioStatisticInfo] sendJitter];
    NSInteger sendLatency = [[[self getSession] getSessionAudioStatisticInfo] sendLatency];
    CGFloat sendPacketLossAvg = [[[self getSession] getSessionAudioStatisticInfo] sendPacketLossAvg];
    CGFloat sendPacketLossMax = [[[self getSession] getSessionAudioStatisticInfo] sendPacketLossMax];
    NSDictionary *dict = @{
        @"recvFrequency": @(recvFrequency),
        @"recvJitter": @(recvJitter),
        @"recvLatency": @(recvLatency),
        @"recvPacketLossAvg": @(recvPacketLossAvg),
        @"recvPacketLossMax": @(recvPacketLossMax),
        @"sendFrequency": @(sendFrequency),
        @"sendJitter": @(sendJitter),
        @"sendLatency": @(sendLatency),
        @"sendPacketLossAvg": @(sendPacketLossAvg),
        @"sendPacketLossMax": @(sendPacketLossMax),
    };

    result([JSONConvert NSDictionaryToNSString: dict]);
}

// -----------------------------------------------------------------------------------------------
// Video Statistics Info
// -----------------------------------------------------------------------------------------------

-(void) getVideoStatisticsInfo:(FlutterResult) result {
    NSInteger recvFps = [[[self getSession] getSessionVideoStatisticInfo] recvFps];
    NSInteger recvFrameHeight = [[[self getSession] getSessionVideoStatisticInfo] recvFrameHeight];
    NSInteger recvFrameWidth = [[[self getSession] getSessionVideoStatisticInfo] recvFrameWidth];
    NSInteger recvJitter = [[[self getSession] getSessionVideoStatisticInfo] recvJitter];
    NSInteger recvLatency = [[[self getSession] getSessionVideoStatisticInfo] recvLatency];
    CGFloat recvPacketLossAvg = [[[self getSession] getSessionVideoStatisticInfo] recvPacketLossAvg];
    CGFloat recvPacketLossMax = [[[self getSession] getSessionVideoStatisticInfo] recvPacketLossMax];
    NSInteger sendFps = [[[self getSession] getSessionVideoStatisticInfo] sendFps];
    NSInteger sendFrameHeight = [[[self getSession] getSessionVideoStatisticInfo] sendFrameHeight];
    NSInteger sendFrameWidth = [[[self getSession] getSessionVideoStatisticInfo] sendFrameWidth];
    NSInteger sendJitter = [[[self getSession] getSessionVideoStatisticInfo] sendJitter];
    NSInteger sendLatency = [[[self getSession] getSessionVideoStatisticInfo] sendLatency];
    CGFloat sendPacketLossAvg = [[[self getSession] getSessionVideoStatisticInfo] sendPacketLossAvg];
    CGFloat sendPacketLossMax = [[[self getSession] getSessionVideoStatisticInfo] sendPacketLossMax];
    NSDictionary *dict = @{
        @"recvFps": @(recvFps),
        @"recvFrameHeight": @(recvFrameHeight),
        @"recvFrameWidth": @(recvFrameWidth),
        @"recvJitter": @(recvJitter),
        @"recvLatency": @(recvLatency),
        @"recvPacketLossAvg": @(recvPacketLossAvg),
        @"recvPacketLossMax": @(recvPacketLossMax),
        @"sendFps": @(sendFps),
        @"sendFrameHeight": @(sendFrameHeight),
        @"sendFrameWidth": @(sendFrameWidth),
        @"sendJitter": @(sendJitter),
        @"sendLatency": @(sendLatency),
        @"sendPacketLossAvg": @(sendPacketLossAvg),
        @"sendPacketLossMax": @(sendPacketLossMax),
    };

    result([JSONConvert NSDictionaryToNSString: dict]);
}

// -----------------------------------------------------------------------------------------------
// Share Statistics Info
// -----------------------------------------------------------------------------------------------

-(void) getShareStatisticsInfo:(FlutterResult) result {
    NSInteger recvFps = [[[self getSession] getSessionShareStatisticInfo] recvFps];
    NSInteger recvFrameHeight = [[[self getSession] getSessionShareStatisticInfo] recvFrameHeight];
    NSInteger recvFrameWidth = [[[self getSession] getSessionShareStatisticInfo] recvFrameWidth];
    NSInteger recvJitter = [[[self getSession] getSessionShareStatisticInfo] recvJitter];
    NSInteger recvLatency = [[[self getSession] getSessionShareStatisticInfo] recvLatency];
    CGFloat recvPacketLossAvg = [[[self getSession] getSessionShareStatisticInfo] recvPacketLossAvg];
    CGFloat recvPacketLossMax = [[[self getSession] getSessionShareStatisticInfo] recvPacketLossMax];
    NSInteger sendFps = [[[self getSession] getSessionShareStatisticInfo] sendFps];
    NSInteger sendFrameHeight = [[[self getSession] getSessionShareStatisticInfo] sendFrameHeight];
    NSInteger sendFrameWidth = [[[self getSession] getSessionShareStatisticInfo] sendFrameWidth];
    NSInteger sendJitter = [[[self getSession] getSessionShareStatisticInfo] sendJitter];
    NSInteger sendLatency = [[[self getSession] getSessionShareStatisticInfo] sendLatency];
    CGFloat sendPacketLossAvg = [[[self getSession] getSessionShareStatisticInfo] sendPacketLossAvg];
    CGFloat sendPacketLossMax = [[[self getSession] getSessionShareStatisticInfo] sendPacketLossMax];
    NSDictionary *dict = @{
        @"recvFps": @(recvFps),
        @"recvFrameHeight": @(recvFrameHeight),
        @"recvFrameWidth": @(recvFrameWidth),
        @"recvJitter": @(recvJitter),
        @"recvLatency": @(recvLatency),
        @"recvPacketLossAvg": @(recvPacketLossAvg),
        @"recvPacketLossMax": @(recvPacketLossMax),
        @"sendFps": @(sendFps),
        @"sendFrameHeight": @(sendFrameHeight),
        @"sendFrameWidth": @(sendFrameWidth),
        @"sendJitter": @(sendJitter),
        @"sendLatency": @(sendLatency),
        @"sendPacketLossAvg": @(sendPacketLossAvg),
        @"sendPacketLossMax": @(sendPacketLossMax),
    };

    result([JSONConvert NSDictionaryToNSString: dict]);
}

@end
