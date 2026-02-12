#import <ZoomVideoSdk/ZoomVideoSDK.h>
#import <Flutter/Flutter.h>

@interface FlutterZoomVideoSdkShareHelper: NSObject

-(instancetype)initWithBundleId:(NSString*)bundleId;

-(void) shareScreen: (FlutterResult) result;

-(void) shareView: (FlutterResult) result;

-(void) lockShare:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) stopShare: (FlutterResult) result;

-(void) isOtherSharing: (FlutterResult) result;

-(void) isScreenSharingOut: (FlutterResult) result;

-(void) isShareLocked: (FlutterResult) result;

-(void) isSharingOut: (FlutterResult) result;

-(void) isShareDeviceAudioEnabled: (FlutterResult) result;

-(void) enableShareDeviceAudio:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) isAnnotationFeatureSupport: (FlutterResult) result;

-(void) disableViewerAnnotation:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) isViewerAnnotationDisabled: (FlutterResult) result;

-(void) pauseShare: (FlutterResult) result;

-(void) resumeShare: (FlutterResult) result;

-(void) startShareCamera:(FlutterResult) result;

-(void) setAnnotationVanishingToolTime:(FlutterMethodCall *)call withResult:(FlutterResult) result;

-(void) getAnnotationVanishingToolDisplayTime: (FlutterResult) result;

-(void) getAnnotationVanishingToolVanishingTime: (FlutterResult) result;

@end
