import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_live_transcription_language.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_live_transcription_message_info.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
///@nodoc
abstract class ZoomVideoSdkLiveTranscriptionHelperPlatform
    extends PlatformInterface {
  ZoomVideoSdkLiveTranscriptionHelperPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkLiveTranscriptionHelperPlatform _instance =
      ZoomVideoSdkLiveTranscriptionHelper();
  static ZoomVideoSdkLiveTranscriptionHelperPlatform get instance => _instance;
  static set instance(ZoomVideoSdkLiveTranscriptionHelperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> canStartLiveTranscription() async {
    throw UnimplementedError(
        'canStartLiveTranscription() has not been implemented.');
  }

  Future<String> startLiveTranscription() async {
    throw UnimplementedError(
        'startLiveTranscription() has not been implemented.');
  }

  Future<String> stopLiveTranscription() async {
    throw UnimplementedError(
        'stopLiveTranscription() has not been implemented.');
  }

  Future<String> getLiveTranscriptionStatus() async {
    throw UnimplementedError(
        'getLiveTranscriptionStatus() has not been implemented.');
  }

  Future<List<ZoomVideoSdkLiveTranscriptionLanguage>?>
      getAvailableSpokenLanguages() async {
    throw UnimplementedError(
        'getAvailableSpokenLanguages() has not been implemented.');
  }

  Future<String> setSpokenLanguage(num languageID) async {
    throw UnimplementedError('setSpokenLanguage() has not been implemented.');
  }

  Future<ZoomVideoSdkLiveTranscriptionLanguage> getSpokenLanguage() async {
    throw UnimplementedError('getSpokenLanguage() has not been implemented.');
  }

  Future<List<ZoomVideoSdkLiveTranscriptionLanguage>?>
      getAvailableTranslationLanguages() async {
    throw UnimplementedError(
        'getAvailableTranslationLanguages() has not been implemented.');
  }

  Future<String> setTranslationLanguage(num languageID) async {
    throw UnimplementedError(
        'setTranslationLanguage() has not been implemented.');
  }

  Future<ZoomVideoSdkLiveTranscriptionLanguage> getTranslationLanguage() async {
    throw UnimplementedError(
        'getTranslationLanguage() has not been implemented.');
  }

  Future<bool> isReceiveSpokenLanguageContentEnabled() async {
    throw UnimplementedError(
        'isReceiveSpokenLanguageContentEnabled() has not been implemented.');
  }

  Future<String> enableReceiveSpokenLanguageContent(bool enable) async {
    throw UnimplementedError(
        'enableReceiveSpokenLanguageContent() has not been implemented.');
  }

  Future<bool> isAllowViewHistoryTranslationMessageEnabled() async {
    throw UnimplementedError(
        'isAllowViewHistoryTranslationMessageEnabled() has not been implemented.');
  }

  Future<List<ZoomVideoSdkLiveTranscriptionMessageInfo>?> getHistoryTranslationMessageList() async {
    throw UnimplementedError(
        'getHistoryTranslationMessageList() has not been implemented.');
  }

}

/// Live transcription interface.
/// <br />Zoom Video SDK supports live transcription (an additional add-on service) which automatically transcribes the audio and speech from the session
/// and provides subtitles for the participants. Contact Video SDK Sales for details: https://explore.zoom.us/docs/en-us/video-sdk.html#sf_form
class ZoomVideoSdkLiveTranscriptionHelper
    extends ZoomVideoSdkLiveTranscriptionHelperPlatform {
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Determine whether the user can start live transcription.
  /// The live transcription service is an add-on, so make sure you have it enabled or this method will always return false.
  /// <br />Return true indicates the user can start live transcription, otherwise this function returns false.
  @override
  Future<bool> canStartLiveTranscription() async {
    return await methodChannel
        .invokeMethod<bool>('canStartLiveTranscription')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Start live transcription.
  /// Users can start live transcription if the session allows multi-language transcription.
  /// When live transcription has successfully started, you will begin to receive the following:
  /// <br />- translated message sent in [onLiveTranscriptionMsgReceived] callback
  /// <br />- error sent in [onLiveTranscriptionMsgError] callback.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> startLiveTranscription() async {
    return await methodChannel
        .invokeMethod<String>('startLiveTranscription')
        .then<String>((String? value) => value ?? "");
  }

  /// Stop live transcription.
  /// Users can stop live transcription (if it has already begun) if the session allows multi-language transcription.
  /// When live transcription has successfully stopped, the transcription service and its callback will no longer be available.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> stopLiveTranscription() async {
    return await methodChannel
        .invokeMethod<String>('stopLiveTranscription')
        .then<String>((String? value) => value ?? "");
  }

  /// Get the current live transcription status to see if it has started or stopped.
  /// The default status is stop, and it will be changed to start when the startLiveTranscription method is called successfully.
  /// <br />Return the current live transcription status.
  @override
  Future<String> getLiveTranscriptionStatus() async {
    return await methodChannel
        .invokeMethod<String>('getLiveTranscriptionStatus')
        .then<String>((String? value) => value ?? "");
  }

  /// Get a list of all available spoken languages during the session.
  /// <br />Return a list of the available spoken languages during a session. If none are available, the return value is null.
  @override
  Future<List<ZoomVideoSdkLiveTranscriptionLanguage>?>
      getAvailableSpokenLanguages() async {
    var languageListString = await methodChannel
        .invokeMethod<String?>('getAvailableSpokenLanguages')
        .then<String?>((String? value) => value);

    var languageListJson = jsonDecode(languageListString!) as List;
    List<ZoomVideoSdkLiveTranscriptionLanguage> languageList = languageListJson
        .map((languageJson) =>
            ZoomVideoSdkLiveTranscriptionLanguage.fromJson(languageJson))
        .toList();

    return languageList;
  }

  /// Set the spoken language of the current user.
  /// This allows captions to be captured accurately from the current user's selected spoken language.
  /// You can retrieve a list of available spoken languages by calling getAvailableSpokenLanguages() above and set with its languageID.
  /// The default spoken language is English.
  /// <br />[languageID] The spoken language ID.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> setSpokenLanguage(num languageID) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("languageID", () => languageID);

    return await methodChannel
        .invokeMethod<String>('setSpokenLanguage', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Get the spoken language of the current user.
  /// <br />Return the spoken language of the current user.
  @override
  Future<ZoomVideoSdkLiveTranscriptionLanguage> getSpokenLanguage() async {
    var languageString = await methodChannel
        .invokeMethod<String?>('getSpokenLanguage')
        .then<String?>((String? value) => value);

    Map<String, dynamic> languageMap = jsonDecode(languageString!);
    var transcriptionLanguage =
        ZoomVideoSdkLiveTranscriptionLanguage.fromJson(languageMap);
    return transcriptionLanguage;
  }

  /// Get the list of all available translation languages in a session.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<List<ZoomVideoSdkLiveTranscriptionLanguage>?>
      getAvailableTranslationLanguages() async {
    var languageListString = await methodChannel
        .invokeMethod<String?>('getAvailableTranslationLanguages')
        .then<String?>((String? value) => value);

    var languageListJson = jsonDecode(languageListString!) as List;
    List<ZoomVideoSdkLiveTranscriptionLanguage> languageList = languageListJson
        .map((languageJson) =>
            ZoomVideoSdkLiveTranscriptionLanguage.fromJson(languageJson))
        .toList();

    return languageList;
  }

  /// Set the translation language of the current user.
  /// This allows captions to be generated and translated into the current user's selected translation language.
  /// You can retrieve a list of available translation languages by calling getAvailableTranslationLanguages() above and set with its languageID.
  /// The default translation language is English.
  /// <br />[languageID] The translation language ID. If the language id is set to -1, live translation will be disabled.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> setTranslationLanguage(num languageID) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("languageID", () => languageID);

    return await methodChannel
        .invokeMethod<String>('setTranslationLanguage', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Get the translation language of the current user.
  /// <br />Return the translation language of the current user.
  @override
  Future<ZoomVideoSdkLiveTranscriptionLanguage> getTranslationLanguage() async {
    var languageString = await methodChannel
        .invokeMethod<String?>('getTranslationLanguage')
        .then<String?>((String? value) => value);

    Map<String, dynamic> languageMap = jsonDecode(languageString!);
    var transcriptionLanguage =
        ZoomVideoSdkLiveTranscriptionLanguage.fromJson(languageMap);
    return transcriptionLanguage;
  }

  /// Determine whether the feature to receive original and translated is available.
  /// <br />Return True indicates that the feature to receive original and translated is available. Otherwise False.
  @override
  Future<bool> isReceiveSpokenLanguageContentEnabled() async {
    return await methodChannel
        .invokeMethod<bool>('isReceiveSpokenLanguageContentEnabled')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Enable or disable to receive original and translated content.If you enable this feature, you must start live transcription.
  /// <br />[enable] true means enable, otherwise false.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> enableReceiveSpokenLanguageContent(bool enable) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("enable", () => enable);

    return await methodChannel
        .invokeMethod<String>('enableReceiveSpokenLanguageContent', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Determine whether the view history translation message is available.
  /// <br />Return True indicates that the view history transcription message is available. Otherwise False.
  @override
  Future<bool> isAllowViewHistoryTranslationMessageEnabled() async {
    return await methodChannel
        .invokeMethod<bool>('isAllowViewHistoryTranslationMessageEnabled')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Get the list of all history translation messages in a session.
  /// <br />If the function succeeds, the return value is a list of all history translation messages in a session.
  /// Otherwise it fails, and the return value is NULL.
  @override
  Future<List<ZoomVideoSdkLiveTranscriptionMessageInfo>?> getHistoryTranslationMessageList() async {
    var messageInfoListString = await methodChannel
        .invokeMethod<String?>('getHistoryTranslationMessageList')
        .then<String?>((String? value) => value);

    var messageInfoListJson = jsonDecode(messageInfoListString!) as List;
    List<ZoomVideoSdkLiveTranscriptionMessageInfo> messageInfoList = messageInfoListJson
        .map((messageJson) =>
        ZoomVideoSdkLiveTranscriptionMessageInfo.fromJson(messageJson))
        .toList();

    return messageInfoList;
  }

}
