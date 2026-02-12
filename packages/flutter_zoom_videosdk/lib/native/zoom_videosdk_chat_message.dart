import 'dart:convert';
import 'dart:core';

import 'package:flutter_zoom_videosdk/native/zoom_videosdk_user.dart';

/// Zoom Video SDK chat message bean.
class ZoomVideoSdkChatMessage {
  String content; /// the message content
  ZoomVideoSdkUser? receiverUser; /// the message receiver user.
  ZoomVideoSdkUser senderUser; /// sender user
  num timestamp; /// the message time stamp.
  bool? isSelfSend; /// true: if is send by myself
  bool? isChatToAll; /// true:if is send to all
  String messageID; /// message ID

  ZoomVideoSdkChatMessage(this.content, this.receiverUser, this.senderUser,
      this.timestamp, this.isSelfSend, this.isChatToAll, this.messageID);

  ZoomVideoSdkChatMessage.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        receiverUser = (json['receiverUser'] == null)
            ? null
            : ZoomVideoSdkUser.fromJson(jsonDecode(json['receiverUser'])),
        senderUser = ZoomVideoSdkUser.fromJson(jsonDecode(json['senderUser'])),
        timestamp = json['timestamp'],
        isSelfSend = json['isSelfSend'],
        isChatToAll = json['isChatToAll'],
        messageID = json['messageID'];

  Map<String, dynamic> toJson() => {
        'content': content,
        'receiverUser': receiverUser,
        'senderUser': senderUser,
        'timestamp': timestamp,
        'isSelfSend': isSelfSend,
        'hisChatToAll': isChatToAll,
        'messageID': messageID
      };
}
