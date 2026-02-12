import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
///@nodoc
abstract class ZoomVideoSdkCmdChannelPlatform extends PlatformInterface {
  ZoomVideoSdkCmdChannelPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkCmdChannelPlatform _instance = ZoomVideoSdkCmdChannel();
  static ZoomVideoSdkCmdChannelPlatform get instance => _instance;
  static set instance(ZoomVideoSdkCmdChannelPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> sendCommand(String receiverId, String strCmd) async {
    throw UnimplementedError('sendCommand() has not been implemented.');
  }
}

/// The command channel
/// <br />allows users to send commands or data (such as plain text or a binary encoded into string) to other users in the same session.
class ZoomVideoSdkCmdChannel extends ZoomVideoSdkCmdChannelPlatform {
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Send custom commands or data to other users in the current session.
  /// Limit: up to 60 custom commands per second.
  /// <br />[receiverId] userId of the user who receives the command.
  /// <br />[strCmd] the custom commands or data, represented in string format.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> sendCommand(String receiverId, String strCmd) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("receiverId", () => receiverId);
    params.putIfAbsent("strCmd", () => strCmd);

    return await methodChannel
        .invokeMethod<String>('sendCommand', params)
        .then<String>((String? value) => value ?? "");
  }
}
