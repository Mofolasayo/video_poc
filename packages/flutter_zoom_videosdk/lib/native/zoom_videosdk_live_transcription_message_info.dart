import 'dart:core';

/// Live transcription message interface.
class ZoomVideoSdkLiveTranscriptionMessageInfo {
  String messageID;
  String messageContent;
  String messageType;
  String speakerName;
  String speakerID;
  String timeStamp;

  ZoomVideoSdkLiveTranscriptionMessageInfo(
      this.messageID,
      this.messageContent,
      this.messageType,
      this.speakerName,
      this.speakerID,
      this.timeStamp
      );

  ZoomVideoSdkLiveTranscriptionMessageInfo.fromJson(Map<String, dynamic> json)
      : messageID = json['messageID'],
        messageContent = json['messageContent'],
        messageType = json['messageType'],
        speakerName = json['speakerName'],
        speakerID = json['speakerID'],
        timeStamp = json['timeStamp'];

  Map<String, dynamic> toJson() => {
    'messageID': messageID,
    'messageContent': messageContent,
    'messageType': messageType,
    'speakerName': speakerName,
    'speakerID': speakerID,
    'timeStamp': timeStamp,
  };
}