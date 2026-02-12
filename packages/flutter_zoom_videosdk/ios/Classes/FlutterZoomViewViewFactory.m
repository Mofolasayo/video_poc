#import <Flutter/Flutter.h>
#import "FlutterZoomView.h"
#import "FlutterZoomViewViewFactory.h"

@interface FlutterZoomViewViewFactory() {
  id<FlutterPluginRegistrar> _registrar;
}
@end

@implementation FlutterZoomViewViewFactory
- (instancetype)initWithMessenger:(NSObject<FlutterPluginRegistrar>*)registrar {
  self = [super init];
  if (self) {
    _registrar = registrar;
  }
  return self;
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
  return [[FlutterZoomView alloc] initWithFrame:frame
                              viewIdentifier:viewId
                                   arguments:args
                                   registrar:_registrar];
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
  return [FlutterStandardMessageCodec sharedInstance];
}

@end