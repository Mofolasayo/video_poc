#import "FlutterZoomVideoSdkCmdChannel.h"
#import "FlutterZoomVideoSdkUser.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkCmdChannel

-(void) sendCommand: (FlutterMethodCall *)call withResult:(FlutterResult) result {

    ZoomVideoSDKCmdChannel* cmdChannel = [[ZoomVideoSDK shareInstance] getCmdChannel];
    ZoomVideoSDKUser* receiver = nil;
    
    if (call.arguments[@"receiverId"]) {
        receiver = [FlutterZoomVideoSdkUser getUser: call.arguments[@"receiverId"]];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([cmdChannel sendCommand:call.arguments[@"strCmd"] receiveUser: receiver])]);
    });
}

@end
