import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
///@nodoc
abstract class ZoomVideoSdkChatHelperPlatform extends PlatformInterface {
  ZoomVideoSdkChatHelperPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkChatHelperPlatform _instance = ZoomVideoSdkChatHelper();
  static ZoomVideoSdkChatHelperPlatform get instance => _instance;
  static set instance(ZoomVideoSdkChatHelperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isChatDisabled() async {
    throw UnimplementedError('isChatDisabled() has not been implemented.');
  }

  Future<bool> isPrivateChatDisabled() async {
    throw UnimplementedError(
        'isPrivateChatDisabled() has not been implemented.');
  }

  Future<String> sendChatToUser(String userId, String message) async {
    throw UnimplementedError('sendChatToUser() has not been implemented.');
  }

  Future<String> sendChatToAll(String message) async {
    throw UnimplementedError('sendChatToAll() has not been implemented.');
  }

  Future<String> deleteChatMessage(String msgId) async {
    throw UnimplementedError('deleteChatMessage() has not been implemented.');
  }

  Future<bool> canChatMessageBeDeleted(String msgId) async {
    throw UnimplementedError(
        'canChatMessageBeDeleted() has not been implemented.');
  }

  Future<String> changeChatPrivilege(String privilegeType) async {
    throw UnimplementedError(
        'changeChatPrivilege() has not been implemented.');
  }

  Future<String> getChatPrivilege() async {
    throw UnimplementedError(
        'getChatPrivilege() has not been implemented.');
  }
}

/// Chat interface.
class ZoomVideoSdkChatHelper extends ZoomVideoSdkChatHelperPlatform {
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Determine whether chat is disabled.
  /// <br />Return true if chat is disabled, otherwise false.
  @override
  Future<bool> isChatDisabled() async {
    return await methodChannel
        .invokeMethod<bool>('isChatDisabled')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Determine whether private chat is disabled.
  /// <br />Return true if private chat is disabled, otherwise false.
  @override
  Future<bool> isPrivateChatDisabled() async {
    return await methodChannel
        .invokeMethod<bool>('isPrivateChatDisabled')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Call this method to send a chat message to a specific user.
  /// <br />[userId] the receiver's userId
  /// <br />[message] the message content
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> sendChatToUser(String userId, String message) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);
    params.putIfAbsent("message", () => message);

    return await methodChannel
        .invokeMethod<String>('sendChatToUser', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Call this method to send a chat message to all users.
  /// <br />[message] the message content
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> sendChatToAll(String message) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("message", () => message);

    return await methodChannel
        .invokeMethod<String>('sendChatToAll', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Call this method to delete a specific chat message from the Zoom server.
  /// <br />This does not delete the message in your user interface.
  /// <br />[msgId] the message Id
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> deleteChatMessage(String msgId) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("msgId", () => msgId);

    return await methodChannel
        .invokeMethod<String>('deleteChatMessage', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Determine if a specific message can be deleted.
  /// <br />[msgId] the message Id
  /// <br />Return true if the message can be deleted, otherwise False.
  @override
  Future<bool> canChatMessageBeDeleted(String msgId) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("msgId", () => msgId);

    return await methodChannel
        .invokeMethod<bool>('canChatMessageBeDeleted', params)
        .then<bool>((bool? value) => value ?? false);
  }

  /// Set participant Chat Privilege when in session.
  /// Note: Only session host/manager can run the function
  /// <br />[privilegeType] The chat privilege of the participant
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> changeChatPrivilege(String privilegeType) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("privilege", () => privilegeType);

    return await methodChannel
        .invokeMethod<String>('changeChatPrivilege', params)
        .then<String>((String? value) => value ?? "");
  }

  /// get participant Chat Priviledge when in session
  /// <br />Return the result of participant chat privilege.
  @override
  Future<String> getChatPrivilege() async {
    return await methodChannel
        .invokeMethod<String>('getChatPrivilege')
        .then<String>((String? value) => value ?? "");
  }
}
