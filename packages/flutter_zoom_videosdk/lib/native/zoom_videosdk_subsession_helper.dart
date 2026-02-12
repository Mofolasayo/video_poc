import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_subsession_kit.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
///@nodoc
abstract class ZoomVideoSdkSubSessionHelperPlatform extends PlatformInterface {
  ZoomVideoSdkSubSessionHelperPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkSubSessionHelperPlatform _instance =
      ZoomVideoSdkSubSessionHelper();
  static ZoomVideoSdkSubSessionHelperPlatform get instance => _instance;
  static set instance(ZoomVideoSdkSubSessionHelperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> joinSubSession(String subSessionId) async {
    throw UnimplementedError('joinSubSession() has not been implemented.');
  }

  Future<String> startSubSession() async {
    throw UnimplementedError('startSubSession() has not been implemented.');
  }

  Future<bool> isSubSessionStarted() async {
    throw UnimplementedError('isSubSessionStarted() has not been implemented.');
  }

  Future<String> stopSubSession() async {
    throw UnimplementedError('stopSubSession() has not been implemented.');
  }

  Future<String> broadcastMessage(String message) async {
    throw UnimplementedError('broadcastMessage() has not been implemented.');
  }

  Future<String> returnToMainSession() async {
    throw UnimplementedError('returnToMainSession() has not been implemented.');
  }

  Future<String> requestForHelp() async {
    throw UnimplementedError('requestForHelp() has not been implemented.');
  }

  Future<String> getRequestUserName() async {
    throw UnimplementedError('getRequestUserName() has not been implemented.');
  }

  Future<String> getRequestSubSessionName() async {
    throw UnimplementedError(
        'getRequestSubSessionName() has not been implemented.');
  }

  Future<String> ignoreUserHelpRequest() async {
    throw UnimplementedError(
        'ignoreUserHelpRequest() has not been implemented.');
  }

  Future<String> joinSubSessionByUserRequest() async {
    throw UnimplementedError(
        'joinSubSessionByUserRequest() has not been implemented.');
  }

  Future<String> commitSubSessionList(List<String> subSessionNames) async {
    throw UnimplementedError(
        'commitSubSessionList() has not been implemented.');
  }

  Future<List<ZoomVideoSdkSubSessionKit>> getCommittedSubSessionList() async {
    throw UnimplementedError(
        'getCommittedSubSessionList() has not been implemented.');
  }

  Future<String> withdrawSubSessionList() async {
    throw UnimplementedError(
        'withdrawSubSessionList() has not been implemented.');
  }
}

/// Helper class for managing sub-sessions (breakout rooms) in the session.
class ZoomVideoSdkSubSessionHelper extends ZoomVideoSdkSubSessionHelperPlatform {
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Join a specific sub-session.
  /// <br />[subSessionId] The ID of the sub-session to join
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> joinSubSession(String subSessionId) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("subSessionId", () => subSessionId);

    return await methodChannel
        .invokeMethod<String>('joinSubSession', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Start the sub-session.
  /// <br />Note: Only the session host/manager can start sub-sessions.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> startSubSession() async {
    return await methodChannel
        .invokeMethod<String>('startSubSession')
        .then<String>((String? value) => value ?? "");
  }

  /// Check if the sub-session has been started.
  /// <br />Return true if the sub-session is started, otherwise false.
  @override
  Future<bool> isSubSessionStarted() async {
    return await methodChannel
        .invokeMethod<bool>('isSubSessionStarted')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Stop the sub-session.
  /// <br />Note: Only the session host/manager can stop sub-sessions.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> stopSubSession() async {
    return await methodChannel
        .invokeMethod<String>('stopSubSession')
        .then<String>((String? value) => value ?? "");
  }

  /// Broadcast a message to all sub-sessions.
  /// <br />[message] The message content to broadcast
  /// <br />Note: Only the session host/manager can broadcast messages.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> broadcastMessage(String message) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("message", () => message);

    return await methodChannel
        .invokeMethod<String>('broadcastMessage', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Return to the main session from a sub-session.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> returnToMainSession() async {
    return await methodChannel
        .invokeMethod<String>('returnToMainSession')
        .then<String>((String? value) => value ?? "");
  }

  /// Request help from the host/manager when in a sub-session.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> requestForHelp() async {
    return await methodChannel
        .invokeMethod<String>('requestForHelp')
        .then<String>((String? value) => value ?? "");
  }

  /// Get the name of the user requesting help.
  /// <br />Return the user name as a string.
  @override
  Future<String> getRequestUserName() async {
    return await methodChannel
        .invokeMethod<String>('getRequestUserName')
        .then<String>((String? value) => value ?? "");
  }

  /// Get the name of the sub-session where help is requested.
  /// <br />Return the sub-session name as a string.
  @override
  Future<String> getRequestSubSessionName() async {
    return await methodChannel
        .invokeMethod<String>('getRequestSubSessionName')
        .then<String>((String? value) => value ?? "");
  }

  /// Ignore a help request from a participant in a sub-session.
  /// <br />Note: Only the session host/manager can ignore help requests.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> ignoreUserHelpRequest() async {
    return await methodChannel
        .invokeMethod<String>('ignoreUserHelpRequest')
        .then<String>((String? value) => value ?? "");
  }

  /// Join the sub-session where a user has requested help.
  /// <br />Note: Only the session host/manager can use this function.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> joinSubSessionByUserRequest() async {
    return await methodChannel
        .invokeMethod<String>('joinSubSessionByUserRequest')
        .then<String>((String? value) => value ?? "");
  }

  /// Commit the sub-session list to create or update sub-sessions.
  /// <br />[subSessionNames] A list of sub-session names to create
  /// <br />Note: Only the session host/manager can commit sub-session lists.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> commitSubSessionList(List<String> subSessionNames) async {
    return await methodChannel
        .invokeMethod<String>('commitSubSessionList', subSessionNames)
        .then<String>((String? value) => value ?? "");
  }

  /// Get the list of committed sub-sessions.
  /// <br />Return a JSON string containing the list of committed sub-sessions.
  @override
  Future<List<ZoomVideoSdkSubSessionKit>> getCommittedSubSessionList() async {
    var subSessionListString = await methodChannel
        .invokeMethod<String?>('getCommittedSubSessionList')
        .then<String?>((String? value) => value);

    var subSessionListJson = jsonDecode(subSessionListString!) as List;
    List<ZoomVideoSdkSubSessionKit> subSessionList = subSessionListJson
        .map((subSessionJson) =>
        ZoomVideoSdkSubSessionKit.fromJson(subSessionJson))
        .toList();

    return subSessionList;
  }

  /// Withdraw the sub-session list (cancel uncommitted sub-session changes).
  /// <br />Note: Only the session host/manager can withdraw sub-session lists.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> withdrawSubSessionList() async {
    return await methodChannel
        .invokeMethod<String>('withdrawSubSessionList')
        .then<String>((String? value) => value ?? "");
  }
}
