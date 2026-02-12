import 'dart:io' show Platform;

import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
///@nodoc
abstract class ZoomVideoSdkVideoStatusPlatform extends PlatformInterface {
  ZoomVideoSdkVideoStatusPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkVideoStatusPlatform _instance =
      ZoomVideoSdkVideoStatus("0");
  static ZoomVideoSdkVideoStatusPlatform get instance => _instance;
  static set instance(ZoomVideoSdkVideoStatusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isOn() async {
    throw UnimplementedError('isOn() has not been implemented.');
  }

  Future<bool> hasVideoDevice() async {
    throw UnimplementedError('hasVideoDevice() has not been implemented.');
  }
}

/// Zoom Video SDK Video Status
class ZoomVideoSdkVideoStatus extends ZoomVideoSdkVideoStatusPlatform {
  final String userId;

  ZoomVideoSdkVideoStatus(this.userId);

  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Query if the camera is turned on.
  /// <br />Return true : camera turned on, false : camera turned off
  @override
  Future<bool> isOn() async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    return await methodChannel
        .invokeMethod<bool>('isOn', params)
        .then<bool>((bool? value) => value ?? false);
  }

  /// Query if the user's device has a compatible camera.
  /// <br />Return true : compatible camera detected, false : no compatible camera detected
  @override
  Future<bool> hasVideoDevice() async {
    if (Platform.isIOS) {
      return true;
    }
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    return await methodChannel
        .invokeMethod<bool>('hasVideoDevice', params)
        .then<bool>((bool? value) => value ?? false);
  }
}
