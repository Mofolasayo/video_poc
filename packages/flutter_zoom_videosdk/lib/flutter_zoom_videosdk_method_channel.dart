import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_zoom_videosdk_platform_interface.dart';

/// An implementation of [FlutterZoomVideosdkPlatform] that uses method channels.
class MethodChannelFlutterZoomVideosdk extends FlutterZoomVideosdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
