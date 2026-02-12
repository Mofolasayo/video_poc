import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
///@nodoc
abstract class ZoomVideoSdkUserHelperPlatform extends PlatformInterface {
  ZoomVideoSdkUserHelperPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkUserHelperPlatform _instance = ZoomVideoSdkUserHelper();
  static ZoomVideoSdkUserHelperPlatform get instance => _instance;
  static set instance(ZoomVideoSdkUserHelperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> changeName(String userId, String name) async {
    throw UnimplementedError('changeName() has not been implemented.');
  }

  Future<bool> makeHost(String userId) async {
    throw UnimplementedError('makeHost() has not been implemented.');
  }

  Future<bool> makeManager(String userId) async {
    throw UnimplementedError('makeManager() has not been implemented.');
  }

  Future<bool> revokeManager(String userId) async {
    throw UnimplementedError('revokeManager() has not been implemented.');
  }

  Future<bool> removeUser(String userId) async {
    throw UnimplementedError('removeUser() has not been implemented.');
  }
}

/// Zoom Video SDK User Helper
class ZoomVideoSdkUserHelper extends ZoomVideoSdkUserHelperPlatform {
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Change a specific user's name.
  /// <br />[userId] the identify of the user
  /// <br />[name] the new name of the user
  /// <br />Return true indicates that name change is success. Otherwise, this function returns false.
  @override
  Future<bool> changeName(String userId, String name) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);
    params.putIfAbsent("name", () => name);

    return await methodChannel
        .invokeMethod<bool>('changeName', params)
        .then<bool>((bool? value) => value ?? false);
  }

  /// Assign a user as the session host.
  /// <br />[userId] the identify of the user
  /// <br />Return indicates that the user is now the host. Otherwise, this function returns false.
  @override
  Future<bool> makeHost(String userId) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("makeHost", () => userId);

    return await methodChannel
        .invokeMethod<bool>('makeHost', params)
        .then<bool>((bool? value) => value ?? false);
  }

  /// Assign a user as the session manager.
  /// <br />[userId] the identify of the user
  /// <br />Return indicates that the user is now the manager. Otherwise, this function returns false.
  @override
  Future<bool> makeManager(String userId) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    return await methodChannel
        .invokeMethod<bool>('makeManager', params)
        .then<bool>((bool? value) => value ?? false);
  }

  /// Revoke manager rights from a user.
  /// <br />[userId] the identify of the user
  /// <br />Return true indicates that the user no longer has manager rights. Otherwise, this function returns false.
  @override
  Future<bool> revokeManager(String userId) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    return await methodChannel
        .invokeMethod<bool>('revokeManager', params)
        .then<bool>((bool? value) => value ?? false);
  }

  /// Remove user from session.
  /// <br />[userId] the identify of the user
  /// <br />Return If the function succeeds, the return value is true. Otherwise, this function returns false.
  @override
  Future<bool> removeUser(String userId) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("userId", () => userId);

    return await methodChannel
        .invokeMethod<bool>('removeUser', params)
        .then<bool>((bool? value) => value ?? false);
  }
}
