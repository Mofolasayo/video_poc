import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_videosdk/flutter_zoom_view.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
///@nodoc
abstract class ZoomVideoSdkShareHelperPlatform extends PlatformInterface {
  ZoomVideoSdkShareHelperPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkShareHelperPlatform _instance = ZoomVideoSdkShareHelper();
  static ZoomVideoSdkShareHelperPlatform get instance => _instance;
  static set instance(ZoomVideoSdkShareHelperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> shareScreen() async {
    throw UnimplementedError('shareScreen() has not been implemented.');
  }

  Future<void> shareView() async {
    throw UnimplementedError('shareView() has not been implemented.');
  }

  Future<String?> lockShare(bool lock) async {
    throw UnimplementedError('lockShare() has not been implemented.');
  }

  Future<String?> stopShare() async {
    throw UnimplementedError('stopShare() has not been implemented.');
  }

  Future<bool> isOtherSharing() async {
    throw UnimplementedError('isOtherSharing() has not been implemented.');
  }

  Future<bool> isScreenSharingOut() async {
    throw UnimplementedError('isScreenSharingOut() has not been implemented.');
  }

  Future<bool> isShareLocked() async {
    throw UnimplementedError('isShareLocked() has not been implemented.');
  }

  Future<bool> isSharingOut() async {
    throw UnimplementedError('isSharingOut() has not been implemented.');
  }

  Future<bool> isShareDeviceAudioEnabled() async {
    throw UnimplementedError(
        'isShareDeviceAudioEnabled() has not been implemented.');
  }

  Future<bool> isAnnotationFeatureSupport() async {
    throw UnimplementedError(
        'isAnnotationFeatureSupport() has not been implemented.');
  }

  Future<String?> disableViewerAnnotation(bool disable) async {
    throw UnimplementedError('disableViewerAnnotation() has not been implemented.');
  }

  Future<bool> isViewerAnnotationDisabled() async {
    throw UnimplementedError(
        'isViewerAnnotationDisabled() has not been implemented.');
  }

  Future<String?> pauseShare() async {
    throw UnimplementedError(
        'pauseShare() has not been implemented.');
  }

  Future<String?> resumeShare() async {
    throw UnimplementedError(
        'resumeShare() has not been implemented.');
  }

  Future<String?> startShareCamera(CameraShareView? view) async {
    throw UnimplementedError(
        'startCameraShare() has not been implemented.');
  }

  Future<String?> setAnnotationVanishingToolTime(num displayTime, num vanishingTime) async {
    throw UnimplementedError(
        'setAnnotationVanishingToolTime() has not been implemented.');
  }

  Future<num> getAnnotationVanishingToolDisplayTime() async {
    throw UnimplementedError(
        'getAnnotationVanishingToolDisplayTime() has not been implemented.');
  }

  Future<num> getAnnotationVanishingToolVanishingTime() async {
    throw UnimplementedError(
        'getAnnotationVanishingToolVanishingTime() has not been implemented.');
  }
}

/// Zoom Video SDK Share Control
class ZoomVideoSdkShareHelper extends ZoomVideoSdkShareHelperPlatform {
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');
  final activityMethodChannel = const MethodChannel('flutter_zoom_videosdk_activity');

  /// Share a selected screen through Intent.
  @override
  Future<void> shareScreen() async {
    return await methodChannel.invokeMethod<void>('shareScreen');
  }

  /// Share a selected view.
  @override
  Future<void> shareView() async {
    return await methodChannel.invokeMethod<void>('shareView');
  }

  /// Lock sharing the view or screen. Only the host can call this method.
  /// <br />[lock] true: if you want to lock share, false: to disable the lock
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> lockShare(bool lock) async {
    var params = <String, dynamic>{};
    params.putIfAbsent('lock', () => lock);
    return await methodChannel
        .invokeMethod<String>('lockShare', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Stop view or screen share.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String?> stopShare() async {
    if (Platform.isAndroid) {
      await activityMethodChannel.invokeMethod<String?>('stopShareScreen');
    }
    return await methodChannel
        .invokeMethod<String?>('stopShare')
        .then<String?>((String? value) => value);
  }

  /// Determine whether other user is sharing.
  /// <br />Return true indicates another user is sharing, otherwise false.
  @override
  Future<bool> isOtherSharing() async {
    return await methodChannel
        .invokeMethod<bool>('isOtherSharing')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Determine whether the current user is sharing the screen.
  /// <br />Return true indicates the current user is sharing the screen, otherwise false.
  @override
  Future<bool> isScreenSharingOut() async {
    return await methodChannel
        .invokeMethod<bool>('isScreenSharingOut')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Determine whether sharing the view or screen is locked.
  /// <br />Return true indicates that sharing is locked, otherwise false.
  @override
  Future<bool> isShareLocked() async {
    return await methodChannel
        .invokeMethod<bool>('isShareLocked')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Determine whether the current user is sharing.
  /// <br />Return true indicates the current user is sharing, otherwise false.
  @override
  Future<bool> isSharingOut() async {
    return await methodChannel
        .invokeMethod<bool>('isSharingOut')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Determine whether the audio of the sharing device is enabled.
  /// <br />Return true indicates that the audio is enabled, otherwise false.
  @override
  Future<bool> isShareDeviceAudioEnabled() async {
    return await methodChannel
        .invokeMethod<bool>('isShareDeviceAudioEnabled')
        .then<bool>((bool? value) => value ?? false);
  }

  @override
  Future<bool> isAnnotationFeatureSupport() async {
    return await methodChannel
        .invokeMethod<bool>('isAnnotationFeatureSupport')
        .then<bool>((bool? value) => value ?? false);
  }

  @override
  Future<String?> disableViewerAnnotation(bool disable) async {
    var params = <String, dynamic>{};
    params.putIfAbsent('disable', () => disable);
    return await methodChannel
        .invokeMethod<String>('disableViewerAnnotation', params)
        .then<String>((String? value) => value ?? "");
  }

  @override
  Future<bool> isViewerAnnotationDisabled() async {
    return await methodChannel
        .invokeMethod<bool>('isViewerAnnotationDisabled')
        .then<bool>((bool? value) => value ?? false);
  }

  @override
  Future<String?> pauseShare() async {
    return await methodChannel
        .invokeMethod<String?>('pauseShare')
        .then<String?>((String? value) => value);
  }

  @override
  Future<String?> resumeShare() async {
    return await methodChannel
        .invokeMethod<String?>('resumeShare')
        .then<String?>((String? value) => value);
  }

  @override
  Future<String?> startShareCamera(CameraShareView? view) async {
    if (view == null) {
      throw Exception('CameraShareView is null');
    }
    return await methodChannel
        .invokeMethod<String?>('startShareCamera')
        .then<String?>((String? value) => value);
  }

  @override
  Future<String?> setAnnotationVanishingToolTime(num displayTime, num vanishingTime) async {
    var params = <String, dynamic>{};
    params.putIfAbsent('displayTime', () => displayTime);
    params.putIfAbsent('vanishingTime', () => vanishingTime);
    return await methodChannel
        .invokeMethod<String>('setAnnotationVanishingToolTime', params)
        .then<String>((String? value) => value ?? "");
  }

  @override
  Future<num> getAnnotationVanishingToolDisplayTime() async {
    return await methodChannel
        .invokeMethod<num>('getAnnotationVanishingToolDisplayTime')
        .then<num>((num? value) => value ?? 0);
  }

  @override
  Future<num> getAnnotationVanishingToolVanishingTime() async {
    return await methodChannel
        .invokeMethod<num>('getAnnotationVanishingToolVanishingTime')
        .then<num>((num? value) => value ?? 0);
  }
}
