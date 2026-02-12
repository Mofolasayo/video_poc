import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_audio_device.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'dart:io';

///@nodoc
abstract class ZoomVideoSdkAudioHelperPlatform extends PlatformInterface {
  ZoomVideoSdkAudioHelperPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkAudioHelperPlatform _instance = ZoomVideoSdkAudioHelper();
  static ZoomVideoSdkAudioHelperPlatform get instance => _instance;
  static set instance(ZoomVideoSdkAudioHelperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> canSwitchSpeaker() async {
    throw UnimplementedError('canSwitchSpeaker() has not been implemented.');
  }

  Future<bool> getSpeakerStatus() async {
    throw UnimplementedError('getSpeakerStatus() has not been implemented.');
  }

  Future<String> muteAudio(String userId) async {
    throw UnimplementedError('muteAudio() has not been implemented.');
  }

  Future<String> unMuteAudio(String userId) async {
    throw UnimplementedError('unMuteAudio() has not been implemented.');
  }

  Future<String> muteAllAudio(bool allowUnmute) async {
    throw UnimplementedError('muteAllAudio() has not been implemented.');
  }

  Future<String> unmuteAllAudio() async {
    throw UnimplementedError('unmuteAllAudio() has not been implemented.');
  }

  Future<String> allowAudioUnmutedBySelf(bool allowUnmute) async {
    throw UnimplementedError('allowAudioUnmutedBySelf() has not been implemented.');
  }

  Future<void> setSpeaker(bool isOn) async {
    throw UnimplementedError('setSpeaker() has not been implemented.');
  }

  Future<String> startAudio() async {
    throw UnimplementedError('startAudio() has not been implemented.');
  }

  Future<String> stopAudio() async {
    throw UnimplementedError('stopAudio() has not been implemented.');
  }

  Future<String> subscribe() async {
    throw UnimplementedError('subscribe() has not been implemented.');
  }

  Future<String> unSubscribe() async {
    throw UnimplementedError('unSubscribe() has not been implemented.');
  }

  Future<bool> resetAudioSession() async {
    throw UnimplementedError('resetAudioSession() has not been implemented.');
  }

  Future<void> cleanAudioSession() async {
    throw UnimplementedError('cleanAudioSession() has not been implemented.');
  }

  Future<List<ZoomVideoSdkAudioDevice>?> getAudioDeviceList() async {
    throw UnimplementedError('getAudioDeviceList() has not been implemented.');
  }

  Future<ZoomVideoSdkAudioDevice> getUsingAudioDevice() async {
    throw UnimplementedError('getUsingAudioDevice() has not been implemented.');
  }

  Future<String> switchToAudioSourceType(String deviceName) async {
    throw UnimplementedError('switchToAudioSourceType() has not been implemented.');
  }

  Future<List<ZoomVideoSdkAudioDevice>?> getAvailableAudioOutputRoute() async {
    throw UnimplementedError('getAvailableAudioOutputRoute() has not been implemented.');
  }

  Future<ZoomVideoSdkAudioDevice> getCurrentAudioOutputRoute() async {
    throw UnimplementedError('getCurrentAudioOutputRoute() has not been implemented.');
  }

  Future<bool> setAudioOutputRoute(String deviceName) async {
    throw UnimplementedError('setAudioOutputRoute() has not been implemented.');
  }

  Future<List<ZoomVideoSdkAudioDevice>?> getAvailableAudioInputsDevice() async {
    throw UnimplementedError('getAvailableAudioInputsDevice() has not been implemented.');
  }

  Future<ZoomVideoSdkAudioDevice> getCurrentAudioInputDevice() async {
    throw UnimplementedError('getCurrentAudioInputDevice() has not been implemented.');
  }

  Future<bool> setAudioInputDevice(String deviceName) async {
    throw UnimplementedError('setAudioInputDevice() has not been implemented.');
  }
}

/// Audio control interface
class ZoomVideoSdkAudioHelper extends ZoomVideoSdkAudioHelperPlatform {
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Query is audio speaker enable.
  /// <br />Return true: enable false: disable (some pad not support telephony,or some device not support)
  @override
  Future<bool> canSwitchSpeaker() async {
    return await methodChannel
        .invokeMethod<bool>('canSwitchSpeaker')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Get audio speaker status
  /// <br />Return true: speaker false: headset or earSpeaker
  @override
  Future<bool> getSpeakerStatus() async {
    return await methodChannel
        .invokeMethod<bool>('getSpeakerStatus')
        .then<bool>((bool? value) => value ?? false);
  }

  /// mute user's voip audio by [userId]
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> muteAudio(String userId) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    return await methodChannel
        .invokeMethod<String>('muteAudio', params)
        .then<String>((String? value) => value ?? "");
  }

  /// unmute user's voip audio by [userId]
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> unMuteAudio(String userId) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    return await methodChannel
        .invokeMethod<String>('unMuteAudio', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Mute all user's audio except my self.
  /// [allowUnmute] = true means allow the user unmute themself, otherwise false.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> muteAllAudio(bool allowUnmute) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("allowUnmute", () => allowUnmute);

    return await methodChannel
        .invokeMethod<String>('muteAllAudio', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Ask unmute all user's audio. Only host or manager can ask unmute all user's audio. This functinon will trigger the callback [onHostAskUnmute()].
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> unmuteAllAudio() async {
    return await methodChannel
        .invokeMethod<String>('unmuteAllAudio')
        .then<String>((String? value) => value ?? "");
  }

  /// Allow the others unmute by themself or not. For host or manager.
  /// [allowUnmute] = true means allow the user unmute themself, otherwise false.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> allowAudioUnmutedBySelf(bool allowUnmute) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("allowUnmute", () => allowUnmute);

    return await methodChannel
        .invokeMethod<String>('allowAudioUnmutedBySelf', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Set audio speaker
  /// <br />[isOn] = true if is speaker
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<void> setSpeaker(bool isOn) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("isOn", () => isOn);

    await methodChannel.invokeMethod<void>('setSpeaker', params);
  }

  /// Start audio with voip
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> startAudio() async {
    return await methodChannel
        .invokeMethod<String>('startAudio')
        .then<String>((String? value) => value ?? "");
  }

  /// Stop voip
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> stopAudio() async {
    return await methodChannel
        .invokeMethod<String>('stopAudio')
        .then<String>((String? value) => value ?? "");
  }

  /// subscribe audio raw data.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> subscribe() async {
    return await methodChannel
        .invokeMethod<String>('startAudio')
        .then<String>((String? value) => value ?? "");
  }

  /// unsubscribe audio raw data
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> unSubscribe() async {
    return await methodChannel
        .invokeMethod<String>('startAudio')
        .then<String>((String? value) => value ?? "");
  }

  /// reset audio session, it will stop and start audio session
  /// <br />Return true indicates success, otherwise false.
  @override
  Future<bool> resetAudioSession() async {
    return await methodChannel
        .invokeMethod<bool>('startAudio')
        .then<bool>((bool? value) => value ?? false);
  }

  /// clean audio session, it will release audio session
  @override
  Future<void> cleanAudioSession() async {
    await methodChannel.invokeMethod<void>('cleanAudioSession');
  }

  /// Get the audio device list.
  /// <br /> The function is only available for Android platform.
  /// <br /> Return List of the audio device if the function succeeds. Otherwise, NULL.
  @override
  Future<List<ZoomVideoSdkAudioDevice>?> getAudioDeviceList() async {
    if (!Platform.isAndroid) {
      throw UnimplementedError('getAudioDeviceList() is only implemented for Android.');
    }
    var audioDeviceListString = await methodChannel
        .invokeMethod<String?>('getAudioDeviceList')
        .then<String?>((String? value) => value);

    var audioDeviceListJson = jsonDecode(audioDeviceListString!) as List;
    List<ZoomVideoSdkAudioDevice> audioDeviceList = audioDeviceListJson
        .map((languageJson) =>
        ZoomVideoSdkAudioDevice.fromJson(languageJson))
        .toList();

    return audioDeviceList;
  }

  /// Get the current using audio device.
  /// <br /> The function is only available for Android platform.
  /// <br /> Return the current using audio device if the function succeeds. Otherwise, NULL
  @override
  Future<ZoomVideoSdkAudioDevice> getUsingAudioDevice() async {
    if (!Platform.isAndroid) {
      throw UnimplementedError('getUsingAudioDevice() is only implemented for Android.');
    }
    var audioDeviceString = await methodChannel
        .invokeMethod<String?>('getUsingAudioDevice')
        .then<String?>((String? value) => value);

    Map<String, dynamic> audioDeviceMap = jsonDecode(audioDeviceString!);
    ZoomVideoSdkAudioDevice audioDevice =
    ZoomVideoSdkAudioDevice.fromJson(audioDeviceMap);
    return audioDevice;
  }

  /// Switch to the specified audio device by [deviceName].
  /// <br /> [deviceName] The device name of the specified audio device must be in the audio device list.
  /// <br /> This function is only available for Android platform.
  /// <br /> Return true indicates success, otherwise false.
  @override
  Future<String> switchToAudioSourceType(String deviceName) async {
    if (!Platform.isAndroid) {
      throw UnimplementedError('switchToAudioSourceType() is only implemented for Android.');
    }
    var params = <String, dynamic>{};
    params.putIfAbsent("deviceName", () => deviceName);

    return await methodChannel
        .invokeMethod<String>('switchToAudioSourceType', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Get the available audio output route.
  /// <br /> The function is only available for iOS platform.
  /// <br /> Return List of the audio output route if the function succeeds.
  @override
  Future<List<ZoomVideoSdkAudioDevice>?> getAvailableAudioOutputRoute() async {
    if (!Platform.isIOS) {
      throw UnimplementedError('getAvailableAudioOutputRoute() is only implemented for iOS.');
    }
    var audioDeviceListString = await methodChannel
        .invokeMethod<String?>('getAvailableAudioOutputRoute')
        .then<String?>((String? value) => value);

    var audioDeviceListJson = jsonDecode(audioDeviceListString!) as List;
    List<ZoomVideoSdkAudioDevice> audioDeviceList = audioDeviceListJson
        .map((languageJson) =>
        ZoomVideoSdkAudioDevice.fromJson(languageJson))
        .toList();

    return audioDeviceList;
  }

  /// Get the current audio output route.
  /// <br /> The function is only available for iOS platform.
  /// <br /> Return the current audio output route if the function succeeds.
  @override
  Future<ZoomVideoSdkAudioDevice> getCurrentAudioOutputRoute() async {
    if (!Platform.isIOS) {
      throw UnimplementedError('getCurrentAudioOutputRoute() is only implemented for iOS.');
    }
    var audioDeviceString = await methodChannel
        .invokeMethod<String?>('getCurrentAudioOutputRoute')
        .then<String?>((String? value) => value);

    Map<String, dynamic> audioDeviceMap = jsonDecode(audioDeviceString!);
    ZoomVideoSdkAudioDevice audioDevice =
    ZoomVideoSdkAudioDevice.fromJson(audioDeviceMap);
    return audioDevice;
  }

  /// Set the specified audio output route by [deviceName].
  /// <br /> [deviceName] The device name of the specified audio output route must be in the audio output route list.
  /// <br /> This function is only available for iOS platform.
  /// <br /> Return true indicates success, otherwise false.
  @override
  Future<bool> setAudioOutputRoute(String deviceName) async {
    if (!Platform.isIOS) {
      throw UnimplementedError('setAudioOutputRoute() is only implemented for iOS.');
    }
    var params = <String, dynamic>{};
    params.putIfAbsent("deviceName", () => deviceName);

    return await methodChannel
        .invokeMethod<bool>('setAudioOutputRoute', params)
        .then<bool>((bool? value) => value ?? false);
  }

  /// Get the available audio input device.
  /// <br /> The function is only available for iOS platform.
  /// <br /> Return List of the audio input device if the function succeeds.
  @override
  Future<List<ZoomVideoSdkAudioDevice>?> getAvailableAudioInputsDevice() async {
    if (!Platform.isIOS) {
      throw UnimplementedError('getAvailableAudioInputsDevice() is only implemented for iOS.');
    }
    var audioDeviceListString = await methodChannel
        .invokeMethod<String?>('getAvailableAudioInputsDevice')
        .then<String?>((String? value) => value);

    var audioDeviceListJson = jsonDecode(audioDeviceListString!) as List;
    List<ZoomVideoSdkAudioDevice> audioDeviceList = audioDeviceListJson
        .map((languageJson) =>
        ZoomVideoSdkAudioDevice.fromJson(languageJson))
        .toList();

    return audioDeviceList;
  }

  /// Get the current audio input device.
  /// <br /> The function is only available for iOS platform.
  /// <br /> Return the current audio input device if the function succeeds.
  @override
  Future<ZoomVideoSdkAudioDevice> getCurrentAudioInputDevice() async {
    if (!Platform.isIOS) {
      throw UnimplementedError('getCurrentAudioInputDevice() is only implemented for iOS.');
    }
    var audioDeviceString = await methodChannel
        .invokeMethod<String?>('getCurrentAudioInputDevice')
        .then<String?>((String? value) => value);

    Map<String, dynamic> audioDeviceMap = jsonDecode(audioDeviceString!);
    ZoomVideoSdkAudioDevice audioDevice =
    ZoomVideoSdkAudioDevice.fromJson(audioDeviceMap);
    return audioDevice;
  }

  /// Set the specified audio input device by [deviceName].
  /// <br /> [deviceName] The device name of the specified audio input device must be in the audio input device list.
  /// <br /> This function is only available for iOS platform.
  /// <br /> Return true indicates success, otherwise false.
  @override
  Future<bool> setAudioInputDevice(String deviceName) async {
    if (!Platform.isIOS) {
      throw UnimplementedError('setAudioInputDevice() is only implemented for iOS.');
    }
    var params = <String, dynamic>{};
    params.putIfAbsent("deviceName", () => deviceName);

    return await methodChannel
        .invokeMethod<bool>('setAudioInputDevice', params)
        .then<bool>((bool? value) => value ?? false);
  }
}
