import 'dart:core';

/// Zoom Video SDK Phone Support Country Info.
class ZoomVideoSdkSupportCountryInfo {
  String countryCode; /// The country code.
  String countryID; /// The country ID.
  String countryName; /// The country name.

  ZoomVideoSdkSupportCountryInfo(
      this.countryCode, this.countryID, this.countryName);

  ZoomVideoSdkSupportCountryInfo.fromJson(Map<String, dynamic> json)
      : countryCode = json['countryCode'],
        countryID = json['countryID'],
        countryName = json['countryName'];

  Map<String, dynamic> toJson() => {
        'countryCode': countryCode,
        'countryID': countryID,
        'countryName': countryName,
      };
}
