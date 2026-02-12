import 'dart:core';

/// Zoom Video SDK Session Dial In Number Information
class ZoomVideoSdkSessionDialInNumberInfo {
  String countryCode; /// the country code of the current information.
  String countryID; /// the country ID of the current information.
  String countryName; /// the country name of the current information.
  String number; /// the telephone number of the current information.
  String displayNumber; /// the display number of the current information.
  String type; /// the call type of the current information.

  ZoomVideoSdkSessionDialInNumberInfo(this.countryCode, this.countryID,
      this.countryName, this.number, this.displayNumber, this.type);

  ZoomVideoSdkSessionDialInNumberInfo.fromJson(Map<String, dynamic> json)
      : countryCode = json['countryCode'],
        countryID = json['countryID'],
        countryName = json['countryName'],
        number = json['number'],
        displayNumber = json['displayNumber'],
        type = json['type'];

  Map<String, dynamic> toJson() => {
        'countryCode': countryCode,
        'countryID': countryID,
        'countryName': countryName,
        'number': number,
        'displayNumber': displayNumber,
        'type': type,
      };
}
