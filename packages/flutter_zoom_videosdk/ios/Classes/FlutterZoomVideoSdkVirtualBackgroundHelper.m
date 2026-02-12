#import "FlutterZoomVideoSdkVirtualBackgroundHelper.h"
#import "FlutterZoomVideoSdkVirtualBackgroundItem.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkVirtualBackgroundHelper

- (ZoomVideoSDKVirtualBackgroundHelper *)getVirtualBackgroundHelper
{
    ZoomVideoSDKVirtualBackgroundHelper* virtualBackgroundHelper = nil;
    @try {
        virtualBackgroundHelper = [[ZoomVideoSDK shareInstance] getVirtualBackgroundHelper];
        if (virtualBackgroundHelper == nil) {
            NSException *e = [NSException exceptionWithName:@"NoVirtualBackgroundHelperFound" reason:@"No Virtual Background Helper" userInfo:nil];
            @throw e;
        }
    } @catch (NSException *e) {
        NSLog(@"%@ - %@", e.name, e.reason);
    }
    return virtualBackgroundHelper;
}

-(void) isSupportVirtualBackground: (FlutterResult) result {
     dispatch_async(dispatch_get_main_queue(), ^{
         result(@([[self getVirtualBackgroundHelper] isSupportVirtualBackground]));
     });
}

-(void) addVirtualBackgroundItem: (FlutterMethodCall *)call withResult:(FlutterResult) result {
     dispatch_async(dispatch_get_main_queue(), ^{
        NSURL *fileURL = [NSURL fileURLWithPath: call.arguments[@"filePath"]];
        UIImage *img = [UIImage imageWithContentsOfFile:[fileURL path]];
        ZoomVideoSDKVirtualBackgroundItem* item = [[self getVirtualBackgroundHelper] addVirtualBackgroundItem:img];
        result([FlutterZoomVideoSdkVirtualBackgroundItem mapVBItem:item]);
     });
}

-(void) removeVirtualBackgroundItem: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray<ZoomVideoSDKVirtualBackgroundItem * >* itemArray = [[self getVirtualBackgroundHelper] getVirtualBackgroundItemList];
        ZoomVideoSDKError ret = Errors_Wrong_Usage;
        for (ZoomVideoSDKVirtualBackgroundItem* item in itemArray) {
            if ([[item imageName] isEqualToString: call.arguments[@"imageName"]]){
                ret = [[self getVirtualBackgroundHelper] removeVirtualBackgroundItem: item];
            }
        }
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(ret)]);
    });
}

-(void) getVirtualBackgroundItemList: (FlutterResult) result {
     dispatch_async(dispatch_get_main_queue(), ^{
         result([FlutterZoomVideoSdkVirtualBackgroundItem mapItemArray:[[self getVirtualBackgroundHelper] getVirtualBackgroundItemList]]);
     });
}

-(void) setVirtualBackgroundItem: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray<ZoomVideoSDKVirtualBackgroundItem * >* itemArray = [[self getVirtualBackgroundHelper] getVirtualBackgroundItemList];
        ZoomVideoSDKError ret = Errors_Wrong_Usage;
        for (ZoomVideoSDKVirtualBackgroundItem* item in itemArray) {
            if ([[item imageName] isEqualToString: call.arguments[@"imageName"]]){
                ret = [[self getVirtualBackgroundHelper] setVirtualBackgroundItem: item];
            }
        }
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(ret)]);
    });
}

@end
