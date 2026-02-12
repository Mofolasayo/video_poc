#import <Flutter/Flutter.h>

@interface FlutterZoomView : NSObject <FlutterPlatformView>

- (instancetype)initWithFrame:(CGRect)frame
                viewIdentifier:(int64_t)viewId
                arguments:(id _Nullable)args
                registrar:(NSObject<FlutterPluginRegistrar>*)registrar;

- (UIView*)view;

@end

@interface ZoomView : UIView

- (void)setUserId:(NSString*)userId;
- (void)setSharing:(BOOL)sharing;
- (void)setIsPiPView:(BOOL)isPiPView;
- (void)setVideoAspect:(NSString*)videoAspect;
- (void)setPreview: (BOOL)preview;
- (void)setHasMultiCamera:(BOOL)newHasMultiCamera;
- (void)setVideoResolution:(NSString*)newVideoResolution;
- (void)setViewingCanvas;

@end
