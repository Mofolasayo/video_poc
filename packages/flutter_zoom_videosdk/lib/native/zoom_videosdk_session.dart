import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_session_statistics_info.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_user.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
///@nodoc
abstract class ZoomVideoSdkSessionPlatform extends PlatformInterface {
  ZoomVideoSdkSessionPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkSessionPlatform _instance = ZoomVideoSdkSession();
  static ZoomVideoSdkSessionPlatform get instance => _instance;
  static set instance(ZoomVideoSdkSessionPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<ZoomVideoSdkUser?> getMySelf() async {
    throw UnimplementedError('getMySelf() has not been implemented.');
  }

  Future<List<ZoomVideoSdkUser>?> getRemoteUsers() async {
    throw UnimplementedError('getRemoteUsers() has not been implemented.');
  }

  Future<ZoomVideoSdkUser?> getSessionHost() async {
    throw UnimplementedError('getSessionHost() has not been implemented.');
  }

  Future<String?> getSessionHostName() async {
    throw UnimplementedError('getSessionHostName() has not been implemented.');
  }

  Future<String?> getSessionName() async {
    throw UnimplementedError('getSessionName() has not been implemented.');
  }

  Future<String?> getSessionPassword() async {
    throw UnimplementedError('getSessionPassword() has not been implemented.');
  }

  Future<String?> getSessionID() async {
    throw UnimplementedError('getSessionID() has not been implemented.');
  }

  Future<String?> getSessionNumber() async {
    throw UnimplementedError('getSessionNumber() has not been implemented.');
  }

  Future<String?> getSessionPhonePasscode() async {
    throw UnimplementedError(
        'getSessionPhonePasscode() has not been implemented.');
  }

  Future<ZoomVideoSdkSessionAudioStatisticsInfo?>
      getAudioStatisticsInfo() async {
    throw UnimplementedError(
        'getAudioStatisticsInfo() has not been implemented.');
  }

  Future<ZoomVideoSdkSessionVideoStatisticsInfo?>
      getVideoStatisticsInfo() async {
    throw UnimplementedError(
        'getVideoStatisticsInfo() has not been implemented.');
  }

  Future<ZoomVideoSdkSessionShareStatisticsInfo?>
      getShareStatisticsInfo() async {
    throw UnimplementedError(
        'getShareStatisticsInfo() has not been implemented.');
  }
}

///Session interface
class ZoomVideoSdkSession extends ZoomVideoSdkSessionPlatform {
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Get the session's name.
  /// <br />Return session name
  @override
  Future<String?> getSessionName() async {
    return await methodChannel
        .invokeMethod<String?>('getSessionName')
        .then<String?>((String? value) => value);
  }

  /// Get the session's password.
  /// <br />Return session's password
  @override
  Future<String> getSessionPassword() async {
    var pwd = await methodChannel
        .invokeMethod<String?>('getSessionPassword')
        .then<String?>((String? value) => value);
    return (pwd == null) ? "" : pwd;
  }

  /// Get the session's user object for myself.
  /// <br />Return the user object [ZoomVideoSdkUser]
  @override
  Future<ZoomVideoSdkUser?> getMySelf() async {
    var userString = await methodChannel
        .invokeMethod<String?>('getMySelf')
        .then<String?>((String? value) => value);

    Map<String, dynamic> userMap = jsonDecode(userString!);
    var zoomVideoSdkUser = ZoomVideoSdkUser.fromJson(userMap);
    return zoomVideoSdkUser;
  }

  /// Get a list of the session's remote users.
  /// <br />Return a list of remote users objects [ZoomVideoSdkUser]
  @override
  Future<List<ZoomVideoSdkUser>?> getRemoteUsers() async {
    var userListString = await methodChannel
        .invokeMethod<String?>('getRemoteUsers')
        .then<String?>((String? value) => value);

    var userListJson = jsonDecode(userListString!) as List;
    List<ZoomVideoSdkUser> userList = userListJson
        .map((userJson) => ZoomVideoSdkUser.fromJson(userJson))
        .toList();

    return userList;
  }

  /// Get the session's host user object.
  /// <br />Return the host in user object [ZoomVideoSdkUser] of the session
  @override
  Future<ZoomVideoSdkUser?> getSessionHost() async {
    var userString = await methodChannel
        .invokeMethod<String?>('getSessionHost')
        .then<String?>((String? value) => value);

    Map<String, dynamic> userMap = jsonDecode(userString!);
    var zoomVideoSdkUser = ZoomVideoSdkUser.fromJson(userMap);
    return zoomVideoSdkUser;
  }

  /// Get the host's name.
  /// <br />Return host user name
  @override
  Future<String?> getSessionHostName() async {
    return await methodChannel
        .invokeMethod<String?>('getSessionHostName')
        .then<String?>((String? value) => value);
  }

  /// Get the session Id
  /// Note: Only the host can get the session Id.
  /// <br />Return session id
  @override
  Future<String?> getSessionID() async {
    return await methodChannel
        .invokeMethod<String?>('getSessionID')
        .then<String?>((String? value) => value);
  }

  /// Get the current session number.
  /// <br />Return the current meeting number if the function succeeds, otherwise returns ZERO(0)
  @override
  Future<String?> getSessionNumber() async {
    return await methodChannel
        .invokeMethod<String?>('getSessionNumber')
        .then<String?>((String? value) => value);
  }

  /// Get the session phone passcode.
  /// <br />Return the session phone passcode if the function succeeds, otherwise returns null
  @override
  Future<String?> getSessionPhonePasscode() async {
    return await methodChannel
        .invokeMethod<String?>('getSessionPhonePasscode')
        .then<String?>((String? value) => value);
  }

  /// Get the session's audio statistic information.
  /// <br />Return [ZoomVideoSdkSessionAudioStatisticsInfo]
  @override
  Future<ZoomVideoSdkSessionAudioStatisticsInfo?>
      getAudioStatisticsInfo() async {
    var infoString = await methodChannel
        .invokeMethod<String?>('getAudioStatisticsInfo')
        .then<String?>((String? value) => value);

    Map<String, dynamic> infoMap = jsonDecode(infoString!);
    var sessionAudioStatisticsInfo =
        ZoomVideoSdkSessionAudioStatisticsInfo.fromJson(infoMap);
    return sessionAudioStatisticsInfo;
  }

  /// Get the session's video statistic information.
  /// <br />Return [ZoomVideoSdkSessionVideoStatisticsInfo]
  @override
  Future<ZoomVideoSdkSessionVideoStatisticsInfo?>
      getVideoStatisticsInfo() async {
    var infoString = await methodChannel
        .invokeMethod<String?>('getVideoStatisticsInfo')
        .then<String?>((String? value) => value);

    Map<String, dynamic> infoMap = jsonDecode(infoString!);
    var sessionVideoStatisticsInfo =
        ZoomVideoSdkSessionVideoStatisticsInfo.fromJson(infoMap);
    return sessionVideoStatisticsInfo;
  }

  /// Get the session's screen share statistic information.
  /// <br />Return [ZoomVideoSDKSessionASVStatisticInfo]
  @override
  Future<ZoomVideoSdkSessionShareStatisticsInfo?>
      getShareStatisticsInfo() async {
    var infoString = await methodChannel
        .invokeMethod<String?>('getShareStatisticsInfo')
        .then<String?>((String? value) => value);

    Map<String, dynamic> infoMap = jsonDecode(infoString!);
    var sessionShareStatisticsInfo =
        ZoomVideoSdkSessionShareStatisticsInfo.fromJson(infoMap);
    return sessionShareStatisticsInfo;
  }
}
