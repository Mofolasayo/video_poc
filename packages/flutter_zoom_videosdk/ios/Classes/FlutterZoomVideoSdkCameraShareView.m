#import "FlutterZoomVideoSdkCameraShareView.h"

@implementation FlutterZoomVideoSdkCameraShareView

+ (instancetype)sharedInstance {
  static FlutterZoomVideoSdkCameraShareView *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
  });
  return instance;
}

- (instancetype)initWithFrame:(CGRect)frame
                viewIdentifier:(int64_t)viewId
                arguments:(id _Nullable)args
                registrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  if (self = [super init]) {
      _shareCameraView = [[UIView alloc] initWithFrame: frame];
      _shareCameraView.backgroundColor = [UIColor blackColor];
  }
  return self;
}

- (UIView*)view {
  return _shareCameraView;
}

@end
