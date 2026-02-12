import 'dart:convert';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// Zoom Video SDK camera device.
class ZoomVideoSdkCameraDevice {

  String deviceId; /// camera device id
  String deviceName; /// camera device name
  bool? isSelectedDevice; /// true:if the device is selected
  String? cameraFacingType; /// the camera facing type (Only for Android platform)
  String? position; /// the camera position (Only for iOS platform)
  String? deviceType; /// the camera device type (Only for iOS platform)
  num? maxZoomFactor; /// the camera max zoom factor (Only for iOS platform)
  num? videoZoomFactorUpscaleThreshold; /// the camera video zoom factor upscale threshold (Only for iOS platform)

  ZoomVideoSdkCameraDevice(
      this.deviceId,
      this.deviceName,
      this.isSelectedDevice,
      this.cameraFacingType,
      this.position,
      this.deviceType,
      this.maxZoomFactor,
      this.videoZoomFactorUpscaleThreshold);

  ZoomVideoSdkCameraDevice.fromJson(Map<String, dynamic> json) :
    deviceId = json['deviceId'],
    deviceName = json['deviceName'],
    isSelectedDevice = json['isSelectedDevice'],
    cameraFacingType = json['cameraFacingType'],
    position = json['position'],
    deviceType = json['deviceType'],
    maxZoomFactor = json['maxZoomFactor'],
    videoZoomFactorUpscaleThreshold = json['videoZoomFactorUpscaleThreshold'];

  Map<String, dynamic> toJson() => {
    'deviceId': deviceId,
    'deviceName': deviceName,
    'isSelectedDevice': isSelectedDevice,
    'cameraFacingType': cameraFacingType,
    'position': position,
    'deviceType': deviceType,
    'maxZoomFactor': maxZoomFactor,
    'videoZoomFactorUpscaleThreshold': videoZoomFactorUpscaleThreshold
  };
}
