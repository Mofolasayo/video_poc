import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_virtual_background_item.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
///@nodoc
abstract class ZoomVideoSdkVirtualBackgroundHelperPlatform extends PlatformInterface {
  ZoomVideoSdkVirtualBackgroundHelperPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkVirtualBackgroundHelperPlatform _instance = ZoomVideoSdkVirtualBackgroundHelper();
  static ZoomVideoSdkVirtualBackgroundHelperPlatform get instance => _instance;
  static set instance(ZoomVideoSdkVirtualBackgroundHelperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isSupportVirtualBackground() async {
    throw UnimplementedError('isSupportVirtualBackground() has not been implemented.');
  }

  Future<ZoomVideoSdkVirtualBackgroundItem?> addVirtualBackgroundItem(String filePath) async {
    throw UnimplementedError(
        'addVirtualBackgroundItem() has not been implemented.');
  }

  Future<String> removeVirtualBackgroundItem(String imageName) async {
    throw UnimplementedError(
        'removeVirtualBackgroundItem() has not been implemented.');
  }

  Future<List<ZoomVideoSdkVirtualBackgroundItem>> getVirtualBackgroundItemList() async {
    throw UnimplementedError(
        'getVirtualBackgroundItemList() has not been implemented.');
  }

  Future<String> setVirtualBackgroundItem(String imageName) async {
    throw UnimplementedError(
        'setVirtualBackgroundItem() has not been implemented.');
  }

}

/// Helper class for virtual background
class ZoomVideoSdkVirtualBackgroundHelper extends ZoomVideoSdkVirtualBackgroundHelperPlatform {
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Add virtual background object.
  /// <br />[filePath] the image filePath.
  /// <br />If the function succeeds, the return value is the selected virtual background item.
  @override
  Future<ZoomVideoSdkVirtualBackgroundItem?> addVirtualBackgroundItem(String filePath) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("filePath", () => filePath);

    var itemString = await methodChannel
        .invokeMethod<String>('addVirtualBackgroundItem', params)
        .then<String>((String? value) => value ?? "");

    Map<String, dynamic> itemMap = jsonDecode(itemString!);
    var vbItem =
    ZoomVideoSdkVirtualBackgroundItem.fromJson(itemMap);
    return vbItem;
  }

  /// Determine whether the user can support smart virtual backgrounds.
  /// <br />Return true means support, you can use virtual background.
  @override
  Future<bool> isSupportVirtualBackground() async {
    return await methodChannel
        .invokeMethod<bool>('isSupportVirtualBackground')
        .then<bool>((bool? value) => value ?? false);
  }

  /// Remove virtual background object.
  /// <br />[imageName] the image name of virtual background item.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> removeVirtualBackgroundItem(String imageName) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("imageName", () => imageName);

    return await methodChannel
        .invokeMethod<String>('removeVirtualBackgroundItem', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Get virtual background item list.
  /// <br />If the function succeeds, the return value is a list of [ZoomVideoSDKVirtualBackgroundItem] object.
  @override
  Future<List<ZoomVideoSdkVirtualBackgroundItem>> getVirtualBackgroundItemList() async {
    var itemListString = await methodChannel
        .invokeMethod<String?>('getVirtualBackgroundItemList')
        .then<String?>((String? value) => value);

    var itemListJson = jsonDecode(itemListString!) as List;
    List<ZoomVideoSdkVirtualBackgroundItem> itemList = itemListJson
        .map((languageJson) =>
        ZoomVideoSdkVirtualBackgroundItem.fromJson(languageJson))
        .toList();

    return itemList;
  }

  /// Set virtual background item.
  /// <br />[imageName] the image name of virtual background item.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> setVirtualBackgroundItem(String imageName) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("imageName", () => imageName);

    return await methodChannel
        .invokeMethod<String>('setVirtualBackgroundItem', params)
        .then<String>((String? value) => value ?? "");
  }

}