import 'dart:core';

/// The live transcription language interface is used to retrieve the ID and name of the language.
/// <br />For example, you can retrieve the language name of English and the ID of 1.
/// <br />Language ID is used to setSpokenLanguage() and setTranslationLanguage()
class ZoomVideoSdkLiveTranscriptionLanguage {
  int languageId;
  String languageName;

  ZoomVideoSdkLiveTranscriptionLanguage(this.languageId, this.languageName);

  ZoomVideoSdkLiveTranscriptionLanguage.fromJson(Map<String, dynamic> json)
      : languageId = json['languageId'],
        languageName = json['languageName'];

  Map<String, dynamic> toJson() => {
        'languageId': languageId,
        'languageName': languageName,
      };
}
