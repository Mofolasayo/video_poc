import 'dart:core';

/// Sub-session user interface.
class ZoomVideoSdkSubSessionUser {
  String userGUID;
  String userName;

  ZoomVideoSdkSubSessionUser(
      this.userGUID,
      this.userName
      );

  ZoomVideoSdkSubSessionUser.fromJson(Map<String, dynamic> json)
      : userGUID = json['userGUID'],
        userName = json['userName'];

  Map<String, dynamic> toJson() => {
    'userGUID': userGUID,
    'userName': userName,
  };
}
