import 'flutter_zoom_videosdk_platform_interface.dart';

class FlutterZoomVideosdk {
  Future<String?> getPlatformVersion() {
    return FlutterZoomVideosdkPlatform.instance.getPlatformVersion();
  }
}
