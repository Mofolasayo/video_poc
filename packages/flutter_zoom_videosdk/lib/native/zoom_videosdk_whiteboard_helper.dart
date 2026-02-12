import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
///@nodoc
abstract class ZoomVideoSdkWhiteboardHelperPlatform extends PlatformInterface {
  ZoomVideoSdkWhiteboardHelperPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkWhiteboardHelperPlatform _instance = ZoomVideoSdkWhiteboardHelper();
  static ZoomVideoSdkWhiteboardHelperPlatform get instance => _instance;
  static set instance(ZoomVideoSdkWhiteboardHelperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> subscribeWhiteboard(num x, num y, num width, num height) async {
    throw UnimplementedError('subscribeWhiteboard() has not been implemented.');
  }

  Future<String> unSubscribeWhiteboard() async {
    throw UnimplementedError(
        'unSubscribeWhiteboard() has not been implemented.');
  }

  Future<bool> canStartShareWhiteboard() async {
    throw UnimplementedError(
        'canStartShareWhiteboard() has not been implemented.');
  }

  Future<String> startShareWhiteboard() async {
    throw UnimplementedError(
        'startShareWhiteboard() has not been implemented.');
  }

  Future<bool> canStopShareWhiteboard() async {
    throw UnimplementedError(
        'canStopShareWhiteboard() has not been implemented.');
  }

  Future<String> stopShareWhiteboard() async {
    throw UnimplementedError(
        'stopShareWhiteboard() has not been implemented.');
  }

  Future<bool> isOtherSharingWhiteboard() async {
    throw UnimplementedError(
        'isOtherSharingWhiteboard() has not been implemented.');
  }

  Future<String> exportWhiteboard(String exportType) async {
    throw UnimplementedError(
        'exportWhiteboard() has not been implemented.');
  }
}

/// Helper class for whiteboard
class ZoomVideoSdkWhiteboardHelper extends ZoomVideoSdkWhiteboardHelperPlatform {
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Subscribe to the whiteboard.
  /// <br />[x] the x coordinate of the whiteboard.
  /// <br />[y] the y coordinate of the whiteboard.
  /// <br />[width] the width of the whiteboard.
  /// <br />[height] the height of the whiteboard.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> subscribeWhiteboard(num x, num y, num width, num height) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("x", () => x);
    params.putIfAbsent("y", () => y);
    params.putIfAbsent("width", () => width);
    params.putIfAbsent("height", () => height);

    return await methodChannel
        .invokeMethod<String>('subscribeWhiteboard', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Unsubscribe from the whiteboard.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> unSubscribeWhiteboard() async {
    return await methodChannel
        .invokeMethod<String>('unSubscribeWhiteboard')
        .then<String>((String? value) => value ?? "");
  }

  /// Determine whether the user can start sharing the whiteboard.
  /// <br />Return true means the user can start sharing the whiteboard.
  @override
  Future<bool> canStartShareWhiteboard() async {
    return await methodChannel
        .invokeMethod<bool>('canStartShareWhiteboard')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Start sharing the whiteboard.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> startShareWhiteboard() async {
    return await methodChannel
        .invokeMethod<String>('startShareWhiteboard')
        .then<String>((String? value) => value ?? "");
  }

  /// Determine whether the user can stop sharing the whiteboard.
  /// <br />Return true means the user can stop sharing the whiteboard.
  @override
  Future<bool> canStopShareWhiteboard() async {
    return await methodChannel
        .invokeMethod<bool>('canStopShareWhiteboard')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Stop sharing the whiteboard.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> stopShareWhiteboard() async {
    return await methodChannel
        .invokeMethod<String>('stopShareWhiteboard')
        .then<String>((String? value) => value ?? "");
  }

  /// Determine whether another user is sharing the whiteboard.
  /// <br />Return true means another user is sharing the whiteboard.
  @override
  Future<bool> isOtherSharingWhiteboard() async {
    return await methodChannel
        .invokeMethod<bool>('isOtherSharingWhiteboard')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Export the whiteboard content.
  /// <br />[exportType] the export type for the whiteboard.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> exportWhiteboard(String exportType) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("exportFormat", () => exportType);

    return await methodChannel
        .invokeMethod<String>('exportWhiteboard', params)
        .then<String>((String? value) => value ?? "");
  }

}
