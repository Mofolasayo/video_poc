import 'dart:convert';
import 'dart:core';
import 'zoom_videosdk_subsession_user.dart';

/// Sub-session kit interface.
class ZoomVideoSdkSubSessionKit {
  String subSessionId;
  String subSessionName;
  List<ZoomVideoSdkSubSessionUser> subSessionUserList;

  ZoomVideoSdkSubSessionKit(
      this.subSessionId,
      this.subSessionName,
      this.subSessionUserList
      );

  ZoomVideoSdkSubSessionKit.fromJson(Map<String, dynamic> json)
      : subSessionId = json['subSessionId'],
        subSessionName = json['subSessionName'],
        subSessionUserList = (jsonDecode(json['subSessionUserList']) as List)
            .map((e) => ZoomVideoSdkSubSessionUser.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
    'subSessionId': subSessionId,
    'subSessionName': subSessionName,
    'subSessionUserList': subSessionUserList.map((e) => e.toJson()).toList(),
  };
}
