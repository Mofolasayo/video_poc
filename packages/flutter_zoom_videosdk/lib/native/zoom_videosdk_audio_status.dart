import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
///@nodoc
abstract class ZoomVideoSdkAudioStatusPlatform extends PlatformInterface {
  ZoomVideoSdkAudioStatusPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkAudioStatusPlatform _instance =
      ZoomVideoSdkAudioStatus("0");
  static ZoomVideoSdkAudioStatusPlatform get instance => _instance;
  static set instance(ZoomVideoSdkAudioStatusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isMuted() async {
    throw UnimplementedError('isMuted() has not been implemented.');
  }

  Future<bool> isTalking() async {
    throw UnimplementedError('isTalking() has not been implemented.');
  }

  Future<String> getAudioType() async {
    throw UnimplementedError('getAudioType() has not been implemented.');
  }
}

/// Zoom Video SDK audio status.
class ZoomVideoSdkAudioStatus extends ZoomVideoSdkAudioStatusPlatform {
  final String userId;

  ZoomVideoSdkAudioStatus(this.userId);

  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Determine whether the audio is muted.
  /// <br />Return true if the audio is muted, otherwise false.
  @override
  Future<bool> isMuted() async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    return await methodChannel
        .invokeMethod<bool>('isMuted', params)
        .then<bool>((bool? value) => value ?? false);
  }

  /// Determine whether the user is talking.
  /// <br />Return true if the user is talking, otherwise false.
  @override
  Future<bool> isTalking() async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    return await methodChannel
        .invokeMethod<bool>('isTalking', params)
        .then<bool>((bool? value) => value ?? false);
  }

  /// Get audio type: VOIP (Voice over IP), Telephony, or None.
  /// <br />Return audio type [AudioType]
  @override
  Future<String> getAudioType() async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    return await methodChannel
        .invokeMethod<String>('getAudioType', params)
        .then<String>((String? value) => value ?? "");
  }
}
