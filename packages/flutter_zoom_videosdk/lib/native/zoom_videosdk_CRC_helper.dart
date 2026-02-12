import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
///@nodoc
abstract class ZoomVideoSdkCRCHelperPlatform extends PlatformInterface {
  ZoomVideoSdkCRCHelperPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkCRCHelperPlatform _instance = ZoomVideoSdkCRCHelper();
  static ZoomVideoSdkCRCHelperPlatform get instance => _instance;
  static set instance(ZoomVideoSdkCRCHelperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isCRCEnabled() async {
    throw UnimplementedError('isCRCEnabled() has not been implemented.');
  }

  Future<String> callCRCDevice(String address, String protocol) async {
    throw UnimplementedError('callCRCDevice() has not been implemented.');
  }

  Future<String> cancelCallCRCDevice() async {
    throw UnimplementedError('cancelCallCRCDevice() has not been implemented.');
  }

  Future<String> getSessionSIPAddress() async {
    throw UnimplementedError('getSessionSIPAddress() has not been implemented.');
  }
}

/// CRC helper interface.
class ZoomVideoSdkCRCHelper extends ZoomVideoSdkCRCHelperPlatform {
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Query if the CRC feature enabled.
  /// <br />Return true means that the CRC enabled, otherwise it's disabled.
  /// Note: only get the correct value after join session
  @override
  Future<bool> isCRCEnabled() async {
    return await methodChannel
        .invokeMethod<bool>('isCRCEnabled')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Calls CRC device. Only available for the host/co-host.
  /// If the function succeeds, the {@link ZoomVideoSDKDelegate#onCallCRCDeviceStatusChanged(ZoomVideoSDKCRCCallStatus)} will be triggered once the call crc device status changes.
  /// <br />[address] The CRC device's IP address
  /// <br />[protocol] The protocol of the CRC device. See {@link ZoomVideoSDKCRCProtocol}
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> callCRCDevice(String address, String protocol) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("address", () => address);
    params.putIfAbsent("protocol", () => protocol);

    return await methodChannel
        .invokeMethod<String>('callCRCDevice', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Cancels the call to the CRC device.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> cancelCallCRCDevice() async {
    return await methodChannel
        .invokeMethod<String>('cancelCallCRCDevice')
        .then<String>((String? value) => value ?? "");
  }

  /// Get the session SIP address.
  @override
  Future<String> getSessionSIPAddress() async {
    return await methodChannel
        .invokeMethod<String>('getSessionSIPAddress')
        .then<String>((String? value) => value ?? "");
  }
}
