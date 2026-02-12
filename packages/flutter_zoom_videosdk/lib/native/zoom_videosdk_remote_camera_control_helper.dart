import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
///@nodoc
abstract class ZoomVideoSdkRemoteCameraControlHelperPlatform extends PlatformInterface {
  ZoomVideoSdkRemoteCameraControlHelperPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkRemoteCameraControlHelperPlatform _instance =
  ZoomVideoSdkRemoteCameraControlHelper();
  static ZoomVideoSdkRemoteCameraControlHelperPlatform get instance => _instance;
  static set instance(ZoomVideoSdkRemoteCameraControlHelperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> giveUpControlRemoteCamera(String userId) async {
    throw UnimplementedError('giveUpControlRemoteCamera() has not been implemented.');
  }

  Future<String> requestControlRemoteCamera(String userId) async {
    throw UnimplementedError('requestControlRemoteCamera() has not been implemented.');
  }

  Future<String> turnLeft(String userId, num range) async {
    throw UnimplementedError('turnLeft() has not been implemented.');
  }

  Future<String> turnRight(String userId, num range) async {
    throw UnimplementedError('turnRight() has not been implemented.');
  }

  Future<String> turnDown(String userId, num range) async {
    throw UnimplementedError('turnDown() has not been implemented.');
  }

  Future<String> turnUp(String userId, num range) async {
    throw UnimplementedError('turnUp() has not been implemented.');
  }

  Future<String> zoomIn(String userId, num range) async {
    throw UnimplementedError('zoomIn() has not been implemented.');
  }

  Future<String> zoomOut(String userId, num range) async {
    throw UnimplementedError('zoomOut() has not been implemented.');
  }

}

/// Interface to control far-end camera (Only for Android)
class ZoomVideoSdkRemoteCameraControlHelper extends ZoomVideoSdkRemoteCameraControlHelperPlatform {
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Give up control of the remote camera from the user with [userId].
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds.
  @override
  Future<String> giveUpControlRemoteCamera(String userId) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    return await methodChannel
        .invokeMethod<String>('giveUpControlRemoteCamera', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Request to control remote camera from the user with [userId].
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds.
  @override
  Future<String> requestControlRemoteCamera(String userId) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    return await methodChannel
        .invokeMethod<String>('requestControlRemoteCamera', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Turn the camera to the left by [range] from the user with [userId].
  /// Rotation range,  10 <= range <= 100.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds.
  @override
  Future<String> turnLeft(String userId, num range) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);
    params.putIfAbsent("range", () => range);

    return await methodChannel
        .invokeMethod<String>('turnLeft', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Turn the camera to the right by [range] from the user with [userId].
  /// Rotation range,  10 <= range <= 100.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds.
  @override
  Future<String> turnRight(String userId, num range) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);
    params.putIfAbsent("range", () => range);

    return await methodChannel
        .invokeMethod<String>('turnRight', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Turn the camera down by [range] from the user with [userId].
  /// Rotation range,  10 <= range <= 100.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds.
  @override
  Future<String> turnDown(String userId, num range) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);
    params.putIfAbsent("range", () => range);

    return await methodChannel
        .invokeMethod<String>('turnDown', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Turn the camera up by [range] from the user with [userId].
  /// Rotation range,  10 <= range <= 100.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds.
  @override
  Future<String> turnUp(String userId, num range) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);
    params.putIfAbsent("range", () => range);

    return await methodChannel
        .invokeMethod<String>('turnUp', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Zoom in the camera by [range] from the user with [userId].
  /// Zoom range,  10 <= range <= 100.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds.
  @override
  Future<String> zoomIn(String userId, num range) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);
    params.putIfAbsent("range", () => range);

    return await methodChannel
        .invokeMethod<String>('zoomIn', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Zoom out the camera by [range] from the user with [userId].
  /// Zoom range,  10 <= range <= 100.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds.
  @override
  Future<String> zoomOut(String userId, num range) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);
    params.putIfAbsent("range", () => range);

    return await methodChannel
        .invokeMethod<String>('zoomOut', params)
        .then<String>((String? value) => value ?? "");
  }

}
