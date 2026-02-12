import 'dart:core';

/// Virtual background item interface.
class ZoomVideoSdkVirtualBackgroundItem {
  String filePath; /// Current item image file path.
  String imageName; /// Current item image name.
  String type; /// Current item background type. See [ZoomVideoSDKVirtualBackgroundDataType].
  bool canBeDeleted; /// True if allow. Otherwise returns false.

  ZoomVideoSdkVirtualBackgroundItem(
      this.filePath,
      this.imageName,
      this.type,
      this.canBeDeleted
      );

  ZoomVideoSdkVirtualBackgroundItem.fromJson(Map<String, dynamic> json)
      : filePath = json['filePath'],
        imageName = json['imageName'],
        type = json['type'],
        canBeDeleted = json['canBeDeleted'];

  Map<String, dynamic> toJson() => {
    'filePath': filePath,
    'imageName': imageName,
    'type': type,
    'canBeDeleted': canBeDeleted,
  };
}