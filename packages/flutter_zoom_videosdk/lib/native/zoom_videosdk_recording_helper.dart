import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
///@nodoc
abstract class ZoomVideoSdkRecordingHelperPlatform extends PlatformInterface {
  ZoomVideoSdkRecordingHelperPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkRecordingHelperPlatform _instance =
      ZoomVideoSdkRecordingHelper();
  static ZoomVideoSdkRecordingHelperPlatform get instance => _instance;
  static set instance(ZoomVideoSdkRecordingHelperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> canStartRecording() async {
    throw UnimplementedError('canStartRecording() has not been implemented.');
  }

  Future<String> startCloudRecording() async {
    throw UnimplementedError('startCloudRecording() has not been implemented.');
  }

  Future<String> stopCloudRecording() async {
    throw UnimplementedError('stopCloudRecording() has not been implemented.');
  }

  Future<String> pauseCloudRecording() async {
    throw UnimplementedError('pauseCloudRecording() has not been implemented.');
  }

  Future<String> resumeCloudRecording() async {
    throw UnimplementedError(
        'resumeCloudRecording() has not been implemented.');
  }

  Future<String> getCloudRecordingStatus() async {
    throw UnimplementedError(
        'getCloudRecordingStatus() has not been implemented.');
  }
}

/// Helper class for using cloud recording in the session.
class ZoomVideoSdkRecordingHelper extends ZoomVideoSdkRecordingHelperPlatform {
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Checks if the current user meets the requirements to start cloud recording.
  /// <br />Return [ZoomVideoSDKError_Success] if the current user meets the requirements to start cloud recording.
  @override
  Future<String> canStartRecording() async {
    return await methodChannel
        .invokeMethod<String>('canStartRecording')
        .then<String>((String? value) => value ?? "");
  }

  /// Start cloud recording.
  /// <br />Since cloud recording involves asynchronous operations, a return value of [ZoomVideoSDKError_Success] does not guarantee that the recording will start.
  /// <br />Return [ZoomVideoSDKError_Success] if the start cloud recording request was successful.
  @override
  Future<String> startCloudRecording() async {
    return await methodChannel
        .invokeMethod<String>('startCloudRecording')
        .then<String>((String? value) => value ?? "");
  }

  /// Stop cloud recording.
  /// <br />Since cloud recording involves asynchronous operations, a return value of [ZoomVideoSDKError_Success] does not guarantee that the recording will stop.
  /// <br />Check [onCloudRecordingStatus] to confirm that recording has ended.
  /// <br />Return [ZoomVideoSDKError_Success] if the stop cloud recording request was successful.
  @override
  Future<String> stopCloudRecording() async {
    return await methodChannel
        .invokeMethod<String>('stopCloudRecording')
        .then<String>((String? value) => value ?? "");
  }

  /// Pause the ongoing cloud recording.
  /// <br />Since cloud recording involves asynchronous operations, a return value of [ZoomVideoSDKError_Success] does not guarantee that the recording will pause.
  /// <br />Check [onCloudRecordingStatus] to confirm that recording has paused.
  /// <br />Return [ZoomVideoSDKError_Success] if the stop cloud recording request was successful.
  @override
  Future<String> pauseCloudRecording() async {
    return await methodChannel
        .invokeMethod<String>('pauseCloudRecording')
        .then<String>((String? value) => value ?? "");
  }

  /// Resume the previously paused cloud recording.
  /// <br />Since cloud recording involves asynchronous operations, a return value of [ZoomVideoSDKError_Success] does not guarantee that the recording will resume.
  /// <br />Check [onCloudRecordingStatus] to confirm that recording has resumed.
  /// <br />Return [ZoomVideoSDKError_Success] if the resume cloud recording request was successful.
  @override
  Future<String> resumeCloudRecording() async {
    return await methodChannel
        .invokeMethod<String>('resumeCloudRecording')
        .then<String>((String? value) => value ?? "");
  }

  /// Get the current status of cloud recording.
  /// <br />Return cloud recording status value.
  @override
  Future<String> getCloudRecordingStatus() async {
    return await methodChannel
        .invokeMethod<String>('getCloudRecordingStatus')
        .then<String>((String? value) => value ?? "");
  }
}
