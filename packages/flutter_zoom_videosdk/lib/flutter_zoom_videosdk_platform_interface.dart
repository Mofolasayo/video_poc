import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_zoom_videosdk_method_channel.dart';

abstract class FlutterZoomVideosdkPlatform extends PlatformInterface {
  /// Constructs a FlutterZoomVideosdkPlatform.
  FlutterZoomVideosdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterZoomVideosdkPlatform _instance =
      MethodChannelFlutterZoomVideosdk();

  /// The default instance of [FlutterZoomVideosdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterZoomVideosdk].
  static FlutterZoomVideosdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterZoomVideosdkPlatform] when
  /// they register themselves.
  static set instance(FlutterZoomVideosdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
