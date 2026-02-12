import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_user.dart';

class CameraShareView extends HookWidget {
  final Map<String, dynamic> creationParams;
  const CameraShareView({super.key, required this.creationParams});

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    String viewType = 'flutter_zoom_videosdk_camera_share_view';

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        throw UnsupportedError("Unsupported platform");
    }
  }
}

/// getting native View from Zoom Android or iOS native SDK
class View extends HookWidget {
  final Map<String, dynamic> creationParams;
  const View({super.key, required this.creationParams});

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    String viewType = 'flutter_zoom_videosdk_view';

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        throw UnsupportedError("Unsupported platform");
    }
  }
}


/// Define parameters that needed by Zoom native view
abstract class ZoomView extends HookWidget {
  final ZoomVideoSdkUser? user;
  final bool sharing;
  final bool preview;
  final bool focused;
  final bool hasMultiCamera;
  final bool isPiPView;
  final String multiCameraIndex;
  final String videoAspect;
  final bool fullScreen;
  final String resolution;

  const ZoomView({
    super.key,
    required this.user,
    required this.sharing,
    required this.preview,
    required this.focused,
    required this.hasMultiCamera,
    required this.isPiPView,
    required this.multiCameraIndex,
    required this.videoAspect,
    required this.fullScreen,
    required this.resolution,
  });
}
