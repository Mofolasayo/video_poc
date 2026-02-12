import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';

class ZoomVideoSdkAudioDevice {

  String deviceName; /// camera device name
  AudioSourceType? audioSourceType; /// audio source type

  ZoomVideoSdkAudioDevice(
      this.deviceName,
      this.audioSourceType);

  ZoomVideoSdkAudioDevice.fromJson(Map<String, dynamic> json) :
        deviceName = json['deviceName'],
        audioSourceType = json['audioSourceType'];

  Map<String, dynamic> toJson() => {
    'deviceName': deviceName,
    'audioSourceType': audioSourceType,
  };
}