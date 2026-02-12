import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

///@nodoc
abstract class ZoomVideoSdkAnnotationHelperPlatform extends PlatformInterface {
  ZoomVideoSdkAnnotationHelperPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkAnnotationHelperPlatform _instance = ZoomVideoSdkAnnotationHelper();
  static ZoomVideoSdkAnnotationHelperPlatform get instance => _instance;
  static set instance(ZoomVideoSdkAnnotationHelperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isSenderDisableAnnotation() async {
    throw UnimplementedError('isSenderDisableAnnotation() has not been implemented.');
  }

  Future<String> startAnnotation() async {
    throw UnimplementedError('startAnnotation() has not been implemented.');
  }

  Future<String> stopAnnotation() async {
    throw UnimplementedError('stopAnnotation() has not been implemented.');
  }

  Future<String> setToolColor(String toolColor) async {
    throw UnimplementedError('setToolColor() has not been implemented.');
  }

  Future<String> getToolColor() async {
    throw UnimplementedError('getToolColor() has not been implemented.');
  }

  Future<String> setToolType(String toolType) async {
    throw UnimplementedError('setToolType() has not been implemented.');
  }

  Future<String> getToolType() async {
    throw UnimplementedError('getToolType() has not been implemented.');
  }

  Future<String> setToolWidth(num width) async {
    throw UnimplementedError('setToolWidth() has not been implemented.');
  }

  Future<num> getToolWidth() async {
    throw UnimplementedError('getToolWidth() has not been implemented.');
  }

  Future<String> undo() async {
    throw UnimplementedError('undo() has not been implemented.');
  }

  Future<String> redo() async {
    throw UnimplementedError('redo() has not been implemented.');
  }

  Future<String> clear(String clearType) async {
    throw UnimplementedError('clear() has not been implemented.');
  }

  Future<bool> canDoAnnotation() async {
    throw UnimplementedError('canDoAnnotation() has not been implemented.');
  }

}

/// Annotation interface
class ZoomVideoSdkAnnotationHelper extends ZoomVideoSdkAnnotationHelperPlatform {
  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  /// Whether the annotation was disabled or not by the share owner.
  /// <br />Return true: disabled
  @Deprecated('Use [canDoAnnotation] instead')
  @override
  Future<bool> isSenderDisableAnnotation() async {
    return await methodChannel
        .invokeMethod<bool>('isSenderDisableAnnotation')
        .then<bool>((bool? value) => value ?? true);
  }

  /// Starts annotation.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> startAnnotation() async {
    return await methodChannel
        .invokeMethod<String>('startAnnotation')
        .then<String>((String? value) => value ?? "");
  }

  /// Stops annotation.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> stopAnnotation() async {
    return await methodChannel
        .invokeMethod<String>('stopAnnotation')
        .then<String>((String? value) => value ?? "");
  }

  /// Sets the annotation tool color with parameter [toolColor].
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> setToolColor(String toolColor) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("toolColor", () => toolColor);

    return await methodChannel
        .invokeMethod<String>('setToolColor', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Gets the annotation tool color.
  /// <br />Return the hex string of the tool color.
  @override
  Future<String> getToolColor() async {
    return await methodChannel
        .invokeMethod<String>('getToolColor')
        .then<String>((String? value) => value ?? "");
  }

  /// Sets the annotation tool type with parameter [toolType].
  /// <br /> The tool type [ZoomVideoSDKAnnotationToolType_Picker] and [ZoomVideoSDKAnnotationToolType_SpotLight] are not support for viewer.
  /// <br /> The following tool types are not support for share screen:
  /// <br />     ZoomVideoSDKAnnotationToolType_Picker,
  /// <br />     ZoomVideoSDKAnnotationToolType_AutoDiamond,
  /// <br />     ZoomVideoSDKAnnotationToolType_AutoStampArrow,
  /// <br />     ZoomVideoSDKAnnotationToolType_AutoStampCheck,
  /// <br />     ZoomVideoSDKAnnotationToolType_AutoStampX,
  /// <br />     ZoomVideoSDKAnnotationToolType_AutoStampStar,
  /// <br />     ZoomVideoSDKAnnotationToolType_AutoStampHeart,
  /// <br />     ZoomVideoSDKAnnotationToolType_AutoStampQm.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> setToolType(String toolType) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("toolType", () => toolType);

    return await methodChannel
        .invokeMethod<String>('setToolType', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Gets the annotation tool type.
  /// <br />Return the current tool type.
  @override
  Future<String> getToolType() async {
    return await methodChannel
        .invokeMethod<String>('getToolType')
        .then<String>((String? value) => value ?? "");
  }

  /// Sets the annotation tool width with parameter [width].
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> setToolWidth(num width) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("width", () => width);

    return await methodChannel
        .invokeMethod<String>('setToolWidth', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Gets the annotation tool width.
  /// <br />Return the current tool width.
  @override
  Future<num> getToolWidth() async {
    return await methodChannel
        .invokeMethod<num>('getToolWidth')
        .then<num>((num? value) => value ?? 0);
  }

  /// Undoes one annotation content step.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> undo() async {
    return await methodChannel
        .invokeMethod<String>('undo')
        .then<String>((String? value) => value ?? "");
  }

  /// Redoes one annotation content step.
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> redo() async {
    return await methodChannel
        .invokeMethod<String>('redo')
        .then<String>((String? value) => value ?? "");
  }

  /// Clears the annotation content with parameter [clearType].
  /// @param [type] the specify clean type. See [ZoomVideoSDKAnnotationClearType].
  /// <br />Return [ZoomVideoSDKError_Success] if the function succeeds. Otherwise, this function returns an error.
  @override
  Future<String> clear(String clearType) async {
    var params = <String, dynamic>{};
    params.putIfAbsent("clearType", () => clearType);

    return await methodChannel
        .invokeMethod<String>('clear', params)
        .then<String>((String? value) => value ?? "");
  }

  /// Whether the current user can do annotation on the share.
  /// <br />Return true means the user can do annotation, otherwise false.
  @override
  Future<bool> canDoAnnotation() async {
    return await methodChannel
        .invokeMethod<bool>('canDoAnnotation')
        .then<bool>((bool? value) => value ?? false);
  }
}