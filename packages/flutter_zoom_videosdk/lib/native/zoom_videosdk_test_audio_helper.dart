import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
///@nodoc
abstract class ZoomVideoSdkTestAudioHelperPlatform extends PlatformInterface {
  ZoomVideoSdkTestAudioHelperPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkTestAudioHelperPlatform _instance =
      ZoomVideoSdkTestAudioHelper();
  static ZoomVideoSdkTestAudioHelperPlatform get instance => _instance;
  static set instance(ZoomVideoSdkTestAudioHelperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> startMicTest() async {
    throw UnimplementedError('startMicTest() has not been implemented.');
  }

  Future<String> stopMicTest() async {
    throw UnimplementedError('stopMicTest() has not been implemented.');
  }

  Future<String> playMicTest() async {
    throw UnimplementedError('playMicTest() has not been implemented.');
  }

  Future<String> startSpeakerTest() async {
    throw UnimplementedError('startSpeakerTest() has not been implemented.');
  }

  Future<String> stopSpeakerTest() async {
    throw UnimplementedError('stopSpeakerTest() has not been implemented.');
  }
}

/// Zoom Video SDK Test Audio Helper
class ZoomVideoSdkTestAudioHelper extends ZoomVideoSdkTestAudioHelperPlatform {
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Start the mic test. This will start recording the input from the mic.
  /// Once the recording is complete, call stopMicTest to finish the recording.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> startMicTest() async {
    return await methodChannel
        .invokeMethod<String>('startMicTest')
        .then<String>((String? value) => value ?? "");
  }

  /// Stop the microphone test.
  /// Before calling this, you must have successfully started the microphone test by calling startMicTest.
  /// Otherwise this returns an error.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> stopMicTest() async {
    return await methodChannel
        .invokeMethod<String>('stopMicTest')
        .then<String>((String? value) => value ?? "");
  }

  /// Play the microphone recorded sound.
  /// You must complete a microphone test by successfully executing startMicTest and stopMicTest before calling this.
  /// Otherwise this returns an error.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> playMicTest() async {
    return await methodChannel
        .invokeMethod<String>('playMicTest')
        .then<String>((String? value) => value ?? "");
  }

  /// Start the speaker test.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> startSpeakerTest() async {
    return await methodChannel
        .invokeMethod<String>('startSpeakerTest')
        .then<String>((String? value) => value ?? "");
  }

  /// Stop the speaker test.
  /// Before calling this, you must have successfully started the speaker test by calling startSpeakerTest.
  /// Otherwise this returns an error.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> stopSpeakerTest() async {
    return await methodChannel
        .invokeMethod<String>('stopSpeakerTest')
        .then<String>((String? value) => value ?? "");
  }
}
