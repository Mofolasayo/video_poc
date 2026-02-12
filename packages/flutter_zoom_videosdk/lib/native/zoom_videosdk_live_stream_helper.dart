import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
///@nodoc
abstract class ZoomVideoSdkLiveStreamHelperPlatform extends PlatformInterface {
  ZoomVideoSdkLiveStreamHelperPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkLiveStreamHelperPlatform _instance =
      ZoomVideoSdkLiveStreamHelper();
  static ZoomVideoSdkLiveStreamHelperPlatform get instance => _instance;
  static set instance(ZoomVideoSdkLiveStreamHelperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> canStartLiveStream() async {
    throw UnimplementedError('canStartLiveStream() has not been implemented.');
  }

  Future<String> startLiveStream(
      String streamUrl, String streamKey, String broadcastUrl) async {
    throw UnimplementedError('startLiveStream() has not been implemented.');
  }

  Future<String> stopLiveStream() async {
    throw UnimplementedError('stopLiveStream() has not been implemented.');
  }
}

/// Live stream control interface.
/// <br />Zoom Video SDK supports live streaming of a session to Facebook Live, YouTube Live, and a number of other custom live streaming platforms.
/// For more details, see https://marketplace.zoom.us/docs/sdk/video/android/advanced/live-stream/.
class ZoomVideoSdkLiveStreamHelper
    extends ZoomVideoSdkLiveStreamHelperPlatform {
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Determine whether the user can start a live stream.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> canStartLiveStream() async {
    return await methodChannel
        .invokeMethod<String>('canStartLiveStream')
        .then<String>((String? value) => value ?? "");
  }

  /// Start a live stream of the current session to the desired streaming platform, given the live stream url, key and broadcast url.
  /// <br />[streamUrl]    the live stream url
  /// <br />[key]          the live stream key
  /// <br />[broadcastUrl] the live stream broadcast url
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> startLiveStream(
      String streamUrl, String streamKey, String broadcastUrl) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("streamUrl", () => streamUrl);
    params.putIfAbsent("streamKey", () => streamKey);
    params.putIfAbsent("broadcastUrl", () => broadcastUrl);

    return await methodChannel
        .invokeMethod<String>('startLiveStream', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Stop the current session's live stream.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> stopLiveStream() async {
    return await methodChannel
        .invokeMethod<String>('stopLiveStream')
        .then<String>((String? value) => value ?? "");
  }
}
