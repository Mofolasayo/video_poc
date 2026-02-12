import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
///@nodoc
abstract class ZoomVideoSdkAudioSettingHelperPlatform
    extends PlatformInterface {
  ZoomVideoSdkAudioSettingHelperPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkAudioSettingHelperPlatform _instance =
      ZoomVideoSdkAudioSettingHelper();
  static ZoomVideoSdkAudioSettingHelperPlatform get instance => _instance;
  static set instance(ZoomVideoSdkAudioSettingHelperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isMicOriginalInputEnable() async {
    throw UnimplementedError(
        'isMicOriginalInputEnable() has not been implemented.');
  }

  Future<String> enableMicOriginalInput(bool enable) async {
    throw UnimplementedError(
        'enableMicOriginalInput() has not been implemented.');
  }

  Future<bool> isAutoAdjustMicVolumeEnabled() async {
    throw UnimplementedError(
        'isAutoAdjustMicVolumeEnabled() has not been implemented.');
  }

  Future<String> enableAutoAdjustMicVolume(bool enable) async {
    throw UnimplementedError(
        'enableAutoAdjustMicVolume() has not been implemented.');
  }
}

/// Audio setting interface.
class ZoomVideoSdkAudioSettingHelper
    extends ZoomVideoSdkAudioSettingHelperPlatform {
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Determine whether the original input of the microphone is enabled.
  /// <br />Return true if the original input of the microphone is enabled, otherwise false.
  @override
  Future<bool> isMicOriginalInputEnable() async {
    return await methodChannel
        .invokeMethod<bool>('isMicOriginalInputEnable')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Call this method to enable or disable the original input of mic.
  /// <br />[enable] true to enable the original input of the microphone or false to disable it.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> enableMicOriginalInput(bool enable) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("enable", () => enable);

    return await methodChannel
        .invokeMethod<String>('enableMicOriginalInput', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Determine whether the auto-adjust microphone volume feature is enabled.
  /// <br />Return true if the auto-adjust microphone volume feature is enabled, otherwise false.
  @override
  Future<bool> isAutoAdjustMicVolumeEnabled() async {
    return await methodChannel
        .invokeMethod<bool>('isAutoAdjustMicVolumeEnabled')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Call this method to enable or disable the auto-adjust microphone volume feature.
  /// <br />[enable] true to enable the auto-adjust microphone volume feature or false to disable it.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> enableAutoAdjustMicVolume(bool enable) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("enable", () => enable);

    return await methodChannel
        .invokeMethod<String>('enableAutoAdjustMicVolume', params)
        .then<String>((String? value) => value ?? "");
  }
}
