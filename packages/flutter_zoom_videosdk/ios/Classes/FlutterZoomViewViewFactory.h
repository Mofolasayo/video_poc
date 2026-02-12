#import <Flutter/Flutter.h>

@interface FlutterZoomViewViewFactory : NSObject <FlutterPlatformViewFactory>

- (instancetype)initWithMessenger:(NSObject<FlutterPluginRegistrar>*)registrar;

@end
