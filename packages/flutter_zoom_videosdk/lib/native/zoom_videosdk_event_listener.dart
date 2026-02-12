import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_audio_device.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_chat_message.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_live_transcription_language.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_live_transcription_message_info.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_share_action.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_user.dart';

/// Enum of ZoomVideoSdk Event
class EventType {
  /// The event when the session is joined.
  /// <br />- [data]: {sessionUser: [ZoomVideoSdkUser]}
  static const onSessionJoin = 'onSessionJoin';
  /// The event when the session is left.
  /// <br />- [data]: {reason: [SessionLeaveReason]}
  static const onSessionLeave = 'onSessionLeave';
  /// The event when the user joins the session.
  /// <br />- [data]: {user: [ZoomVideoSdkUser]}
  static const onUserJoin = 'onUserJoin';
  /// The event when the user leaves the session.
  /// <br />- [data]: {user: [ZoomVideoSdkUser]}
  static const onUserLeave = 'onUserLeave';
  /// The event when the users' video status changes.
  /// <br />- [data]: {changedUsers: List<[ZoomVideoSdkUser]>}
  static const onUserVideoStatusChanged = 'onUserVideoStatusChanged';
  /// The event when the users' audio status changes.
  /// <br />- [data]: {changedUsers: List<[ZoomVideoSdkUser]>}
  static const onUserAudioStatusChanged = 'onUserAudioStatusChanged';
  /// The event when the user's share status changes.
  /// <br />- [data]: {user: [ZoomVideoSdkUser], shareAction: [ZoomVideoSdkShareAction]}
  static const onUserShareStatusChanged = 'onUserShareStatusChanged';
  /// The event when the live stream status changes.
  /// <br />- [data]: {status: [LiveStreamStatus]}
  static const onLiveStreamStatusChanged = 'onLiveStreamStatusChanged';
  /// The event when there is a new chat message.
  /// <br />- [data]: {message: [ZoomVideoSdkChatMessage]}
  static const onChatNewMessageNotify = 'onChatNewMessageNotify';
  /// The event when the user's name changes.
  /// <br />- [data]: {changedUser: [ZoomVideoSdkUser]}
  static const onUserNameChanged = 'onUserNameChanged';
  /// THe event when the session host changes.
  /// <br />- [data]: {changedUser: [ZoomVideoSdkUser]}
  static const onUserHostChanged = 'onUserHostChanged';
  /// The event when the session manager changes.
  /// <br />- [data]: {changedUser: [ZoomVideoSdkUser]}
  static const onUserManagerChanged = 'onUserManagerChanged';
  /// The event when the user's active audio changes.
  /// <br />- [data]: {changedUsers: List<[ZoomVideoSdkUser]>}
  static const onUserActiveAudioChanged = 'onUserActiveAudioChanged';
  /// The event when the session password is required.
  static const onSessionNeedPassword = 'onSessionNeedPassword';
  /// The event when the session password is wrong.
  static const onSessionPasswordWrong = 'onSessionPasswordWrong';
  /// The event when there is an error.
  /// <br />- [data]: {errorType: [Errors]}
  static const onError = 'onError';
  /// The event when receiving a message, data, or a command from the command channel.
  /// <br />- [data]: {sender: [ZoomVideoSdkUser], command: String}
  static const onCommandReceived = 'onCommandReceived';
  /// The event when the command channel is connected.
  /// <br />- [data]: {success: bool}
  static const onCommandChannelConnectResult = 'onCommandChannelConnectResult';
  /// The event when cloud recording status has paused, stopped, resumed, or otherwise changed.
  /// <br />- [data]: {status: [RecordingStatus]}
  static const onCloudRecordingStatus = 'onCloudRecordingStatus';
  /// The event when the host requests you to unmute yourself.
  static const onHostAskUnmute = 'onHostAskUnmute';
  /// The event when the invite by phone status changes to any other valid status such as Calling, Ringing, Success, or Failed.
  /// <br />- [data]: {status: [PhoneStatus]}
  static const onInviteByPhoneStatus = 'onInviteByPhoneStatus';
  /// The event when the meeting is deleted
  /// <br />- [data]: {msgID: String, type: ChatMessageDeleteType}
  static const onChatDeleteMessageNotify = 'onChatDeleteMessageNotify';
  /// The event when live transcription status changes.
  /// <br />- [data]: {status: [LiveTranscriptionStatus]}
  static const onLiveTranscriptionStatus = 'onLiveTranscriptionStatus';
  /// The event when a live translation error occurs.
  /// <br />- [data]: {spokenLanguage: [ZoomVideoSdkLiveTranscriptionLanguage], transcriptLanguage: [ZoomVideoSdkLiveTranscriptionLanguage]}
  static const onLiveTranscriptionMsgError = 'onLiveTranscriptionMsgError';
  /// The event when a live translation message is received.
  /// <br />- [data]: {messageInfo: [ZoomVideoSdkLiveTranscriptionMessageInfo]}
  static const onLiveTranscriptionMsgInfoReceived = 'onLiveTranscriptionMsgInfoReceived';
  /// The event when someone in a given session enables or disables multi-camera. All participants in the session receive this callback.
  /// <br />- [data]: {status: [MultiCameraStreamStatus], user: [ZoomVideoSdkUser]}
  static const onMultiCameraStreamStatusChanged =
      'onMultiCameraStreamStatusChanged';
  /// The event when the SDK requires system permissions to continue functioning.
  /// <br />- [data]: {permissionType:[SystemPermissionType]}
  static const onRequireSystemPermission = 'onRequireSystemPermission';
  /// The event when the SSL is verified.
  /// <br />- [data]: {certIssuedTo: String, certIssuedBy: String, certSerialNum: String, certFingerPrint: String}
  static const onSSLCertVerifiedFailNotification =
      'onSSLCertVerifiedFailNotification';
  /// The event when the proxy setting is changed.
  /// <br />- [data]: {proxyHost: String, proxyPort: int, proxyDescription: String}
  static const onProxySettingNotification = 'onProxySettingNotification';
  /// The event when a user consent to individual recording.
  /// <br />- [data]: {user: [ZoomVideoSdkUser]}
  static const onUserRecordingConsent = 'onUserRecordingConsent';
  /// The event when the user's video network status changes.
  /// <br />- [data]: {user: [ZoomVideoSdkUser], status: [NetworkStatus]}
  static const onUserVideoNetworkStatusChanged = 'onUserVideoNetworkStatusChanged';
  /// The event when the current user is granted camera control access. Once the current user sends the camera control request, this callback will be triggered with the result of the request.
  /// <br />- [data]: {user: [ZoomVideoSdkUser], approved: bool}
  static const onCameraControlRequestResult = 'onCameraControlRequestResult';
  /// The event when the CRC device status changes.
  /// <br />- [data]: {status: [ZoomVideoSDKCRCCallStatus]}
  static const onCallCRCDeviceStatusChanged = 'onCallCRCDeviceStatusChanged';
  /// The event when the original language message received.
  /// <br />- [data]: {messageInfo: [ZoomVideoSdkLiveTranscriptionMessageInfo]}
  static const onOriginalLanguageMsgReceived = 'onOriginalLanguageMsgReceived';
  /// The event when the chat privilege of the user has changed.
  /// <br />- [data]: {privilege: [ChatPrivilegeType]}
  static const onChatPrivilegeChanged = 'onChatPrivilegeChanged';
  /// THe event when the annotation helper clean up.
  static const onAnnotationHelperCleanUp = 'onAnnotationHelperCleanUp';
  /// The event when the annotation privilege of the user has changed.
  /// <br />- [data]: {shareAction: [ZoomVideoSdkShareAction], shareOwner: [ZoomVideoSdkUser]}
  static const onAnnotationPrivilegeChange = 'onAnnotationPrivilegeChange';
  /// The event for the subscribed user's share view failure reason.
  /// <br />- [data]: {user: [ZoomVideoSdkUser], shareAction: [ZoomVideoSdkShareAction]}
  static const onShareCanvasSubscribeFail = 'onShareCanvasSubscribeFail';
  /// The event of subscribe user's video fail reason.
  /// <br />- [data]: {user: [ZoomVideoSdkUser], failReason: [SubscribeFailReason]}
  static const onVideoCanvasSubscribeFail = 'onVideoCanvasSubscribeFail';
  /// The event of the test mic status changed.
  /// <br />- [data]: {status: [TestMicStatus]}
  static const onTestMicStatusChanged = 'onTestMicStatusChanged';
  /// The event of the mic speaker volume changed.
  /// <br />- [data]: {micVolume: int, speakerVolume: int}
  static const onMicSpeakerVolumeChanged = 'onMicSpeakerVolumeChanged';
  /// The event when the callout user successfully joins the session.
  /// <br />- [data]: {user: [ZoomVideoSdkUser], phoneNumber: String}
  static const onCalloutJoinSuccess = 'onCalloutJoinSuccess';
  /// The event when the spotlight videos change.
  /// <br />- [data]: {changedUsers: List<[ZoomVideoSdkUser]>}
  static const onSpotlightVideoChanged = 'onSpotlightVideoChanged';
  /// The event of the UVCCamera status change.
  /// <br />- [data]: {status: [UVCCameraStatus]}
  static const onUVCCameraStatusChange = 'onUVCCameraStatusChange';
  /// The event when a user makes changes to their share content type, such as switching camera share to normal share.
  /// <br />- [data]: {user: [ZoomVideoSdkUser], shareAction: [ZoomVideoSdkShareAction]}
  static const onShareContentChanged = 'onShareContentChanged';
  /// The event when the share content size has changed.
  /// <br />- [data]: {user: [ZoomVideoSdkUser], shareAction: [ZoomVideoSdkShareAction]}
  static const onShareContentSizeChanged = 'onShareContentSizeChanged';
  /// The event when the user's audio level changes.
  /// <br />- [data]: {user: [ZoomVideoSdkUser], level: int, audioSharing: bool}
  static const onAudioLevelChanged = 'onAudioLevelChanged';
  /// The event when the user's network status changes.
  /// <br />- [data]: {user: [ZoomVideoSdkUser], level: [NetworkStatus], type: [DataType]}
  static const onUserNetworkStatusChanged = 'onUserNetworkStatusChanged';
  /// The event when the user's overall network status changes.
  /// <br />- [data]: {user: [ZoomVideoSdkUser], level: [NetworkStatus]}
  static const onUserOverallNetworkStatusChanged = 'onUserOverallNetworkStatusChanged';
  /// The event when the audio source type of the current user changes.
  /// <br />- [data]: {device: [ZoomVideoSdkAudioDevice]}
  static const onMyAudioSourceTypeChanged = 'onMyAudioSourceTypeChanged';
  /// The event when the whiteboard share status of a user changes.
  /// <br />- [data]: {user: [ZoomVideoSdkUser], status: [WhiteboardStatus]}
  static const onUserWhiteboardShareStatusChanged = 'onUserWhiteboardShareStatusChanged';
  /// The event when the whiteboard is exported.
  /// <br />- [data]: {format: [ExportFormat], data: String}
  static const onWhiteboardExported = 'onWhiteboardExported';
  /// The event when the subsession status changes.
  /// <br />- [data]: {status: [SubSessionStatus], subSessions: List<[ZoomVideoSdkSubSessionKit]>}
  static const onSubSessionStatusChanged = 'onSubSessionStatusChanged';
  /// The event when the user receives subsession manager privilege.
  static const onSubSessionManagerHandle = 'onSubSessionManagerHandle';
  /// The event when the user receives subsession attendee privilege.
  static const onSubSessionParticipantHandle = 'onSubSessionParticipantHandle';
  /// The event when the users of a subsession are updated.
  /// <br />- [data]: {subSession: [ZoomVideoSdkSubSessionKit]}
  static const onSubSessionUsersUpdate = 'onSubSessionUsersUpdate';
  /// The event when the user receives a broadcast message from main session.
  /// <br />- [data]: {message: String, name: String}
  static const onBroadcastMessageFromMainSession = 'onBroadcastMessageFromMainSession';
  /// The event when the user receives a help request from subsession.
  static const onSubSessionUserHelpRequestHandler = 'onSubSessionUserHelpRequestHandler';
  /// The event when the result of help request is received.
  /// <br />- [data]: {result: [UserHelpRequestResult]}
  static const onSubSessionUserHelpRequestResult = 'onSubSessionUserHelpRequestResult';
}

/// @nodoc
class EventEmitter {
  final Map<String, List<StreamController>> _eventControllers = {};

  StreamSubscription addListener(String event, void Function(dynamic data) handler) {
    if (!_eventControllers.containsKey(event)) {
      _eventControllers[event] = [];
    }

    final controller = StreamController.broadcast();
    _eventControllers[event]!.add(controller);

    return controller.stream.listen(handler);
  }

  void emit(String event, [dynamic data]) {
    if (_eventControllers.containsKey(event)) {
      for (final controller in _eventControllers[event]!) {
        controller.add(data);
      }
    }
  }

  void dispose() {
    for (final controllers in _eventControllers.values) {
      for (final controller in controllers) {
        controller.close();
      }
    }
    _eventControllers.clear();
  }
}

class ZoomVideoSdkEventListener {
  /// The event channel used to interact with the native platform.
  final EventChannel eventChannel = const EventChannel('eventListener');
  var eventEmitter = EventEmitter();

  ZoomVideoSdkEventListener() {
    eventChannel.receiveBroadcastStream().cast().listen((event) {
      eventEmitter.emit(event['name'], event['message']);
    });
  }

  /// Add a listener to the event.
  /// <br />- [event]: [EventType] The event to listen to.
  StreamSubscription addListener(String event, void Function(dynamic data) handler) {
    return eventEmitter.addListener(event, handler);
  }
}
