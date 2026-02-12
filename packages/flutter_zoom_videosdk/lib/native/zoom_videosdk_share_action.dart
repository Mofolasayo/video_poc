import 'dart:core';

/// The share action interface is used to retrieve the user's share action.
/// <br />For example, you can retrieve the share status and whether the share action can do the annotation.
class ZoomVideoSdkShareAction {
  int shareSourceId;
  String shareStatus;
  String subscribeFailReason;
  bool isAnnotationPrivilegeEnabled;
  String shareType;

  ZoomVideoSdkShareAction(
      this.shareSourceId,
      this. shareStatus,
      this.subscribeFailReason,
      this.isAnnotationPrivilegeEnabled,
      this.shareType);

  ZoomVideoSdkShareAction.fromJson(Map<String, dynamic> json)
      : shareSourceId = json['shareSourceId'],
        shareStatus = json['shareStatus'],
        subscribeFailReason = json['subscribeFailReason'],
        isAnnotationPrivilegeEnabled = json['isAnnotationPrivilegeEnabled'],
        shareType = json['shareType'];

  Map<String, dynamic> toJson() => {
    'shareSourceId': shareSourceId,
    'shareStatus': shareStatus,
    'subscribeFailReason': subscribeFailReason,
    'isAnnotationPrivilegeEnabled': isAnnotationPrivilegeEnabled,
    'shareType': shareType,
  };
}
