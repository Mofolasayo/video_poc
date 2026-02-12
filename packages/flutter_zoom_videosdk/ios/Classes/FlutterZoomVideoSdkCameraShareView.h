#import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>

@interface FlutterZoomVideoSdkCameraShareView : NSObject <FlutterPlatformView>

@property (nonatomic, strong) UIView *shareCameraView;

+ (instancetype)sharedInstance;

- (instancetype)initWithFrame:(CGRect)frame
                viewIdentifier:(int64_t)viewId
                arguments:(id _Nullable)args
                registrar:(NSObject<FlutterPluginRegistrar>*)registrar;

- (UIView*)view;

@end
