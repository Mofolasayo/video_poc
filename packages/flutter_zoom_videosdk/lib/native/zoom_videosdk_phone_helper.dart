import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_phone_support_country_info.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_session_dial_in_number_info.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
///@nodoc
abstract class ZoomVideoSdkPhoneHelperPlatform extends PlatformInterface {
  ZoomVideoSdkPhoneHelperPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkPhoneHelperPlatform _instance = ZoomVideoSdkPhoneHelper();
  static ZoomVideoSdkPhoneHelperPlatform get instance => _instance;
  static set instance(ZoomVideoSdkPhoneHelperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> cancelInviteByPhone() async {
    throw UnimplementedError('cancelInviteByPhone() has not been implemented.');
  }

  Future<String> getInviteByPhoneStatus() async {
    throw UnimplementedError(
        'getInviteByPhoneStatus() has not been implemented.');
  }

  Future<List<ZoomVideoSdkSupportCountryInfo>> getSupportCountryInfo() async {
    throw UnimplementedError(
        'getSupportCountryInfo() has not been implemented.');
  }

  Future<String> inviteByPhone(
      String countryCode, String phoneNumber, String name) async {
    throw UnimplementedError(
        'getSupportCountryInfo() has not been implemented.');
  }

  Future<bool> isSupportPhoneFeature() async {
    throw UnimplementedError(
        'isSupportPhoneFeature() has not been implemented.');
  }

  Future<List<ZoomVideoSdkSessionDialInNumberInfo>?> getSessionDialInNumbers() async {
    throw UnimplementedError(
        'getSessionDialInNumbers() has not been implemented.');
  }
}

/// Invite by phone interface
class ZoomVideoSdkPhoneHelper extends ZoomVideoSdkPhoneHelperPlatform {
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Cancel the invitation that is being called out by phone.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> cancelInviteByPhone() async {
    return await methodChannel
        .invokeMethod<String>('cancelInviteByPhone')
        .then<String>((String? value) => value ?? "");
  }

  /// Get the status of the invitation by phone.
  /// <br />If the function succeeds, the method returns the [PhoneStatus] of the invitation by phone.
  @override
  Future<String> getInviteByPhoneStatus() async {
    return await methodChannel
        .invokeMethod<String>('getInviteByPhoneStatus')
        .then<String>((String? value) => value ?? "");
  }

  /// Get the list of the country information where the session supports to join by telephone.
  /// <br />Return List of the country information returns if the session supports to join by telephone. Otherwise NULL.
  @override
  Future<List<ZoomVideoSdkSupportCountryInfo>> getSupportCountryInfo() async {
    var countryInfoString = await methodChannel
        .invokeMethod<String?>('getSupportCountryInfo')
        .then<String?>((String? value) => value);

    var countryListJson = jsonDecode(countryInfoString!) as List;
    List<ZoomVideoSdkSupportCountryInfo> countryList = countryListJson
        .map((countryJson) => ZoomVideoSdkSupportCountryInfo.fromJson(countryJson))
        .toList();

    return countryList;
  }

  /// Invite the specified user to join the session by phone.
  /// <br />[countryCode] The country code of the specified user must be in the support list.
  /// <br />[phoneNumber] The phone number of specified user.
  /// <br />[name] The screen name of the specified user in the session.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> inviteByPhone(
      String countryCode, String phoneNumber, String name) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("countryCode", () => countryCode);
    params.putIfAbsent("phoneNumber", () => phoneNumber);
    params.putIfAbsent("name", () => name);

    return await methodChannel
        .invokeMethod<String>('inviteByPhone', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Determine if the session supports join by phone or not.
  /// <br />Return true indicates join by phone is supported, otherwise false.
  @override
  Future<bool> isSupportPhoneFeature() async {
    return await methodChannel
        .invokeMethod<bool>('isSupportPhoneFeature')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Get the list of dial in numbers supported by session.
  /// <br />If the function succeeds, the return value is the list of the call-in numbers.
  /// Otherwise failed.
  @override
  Future<List<ZoomVideoSdkSessionDialInNumberInfo>?> getSessionDialInNumbers() async {
    var dialInNumberString = await methodChannel
        .invokeMethod<String?>('getSessionDialInNumbers')
        .then<String?>((String? value) => value);

    var dialInNumberListJson = jsonDecode(dialInNumberString!) as List;
    List<ZoomVideoSdkSessionDialInNumberInfo> dialInNumberList = dialInNumberListJson
        .map((languageJson) =>
        ZoomVideoSdkSessionDialInNumberInfo.fromJson(languageJson))
        .toList();

    return dialInNumberList;
  }
}
