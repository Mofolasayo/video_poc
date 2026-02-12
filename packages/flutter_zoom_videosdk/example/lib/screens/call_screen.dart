import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zoom_videosdk/flutter_zoom_view.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_audio_device.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_camera_device.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_cmd_channel.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_event_listener.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_live_transcription_message_info.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_share_action.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_subsession_kit.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_user.dart';
import 'package:flutter_zoom_videosdk_example/utils/jwt.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../components/comment_list.dart';
import '../components/video_view.dart';
import 'intro_screen.dart';
import 'join_screen.dart';


class CallScreen extends StatefulHookWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  static TextEditingController changeNameController = TextEditingController();
  static TextEditingController subSessionNameController = TextEditingController();
  double opacityLevel = 1.0;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  Widget build(BuildContext context) {
    var zoom = ZoomVideoSdk();
    var eventListener = ZoomVideoSdkEventListener();
    var isInSession = useState(false);
    var sessionName = useState('');
    var sessionPassword = useState('');
    var users = useState(<ZoomVideoSdkUser>[]);
    var fullScreenUser = useState<ZoomVideoSdkUser?>(null);
    var sharingUser = useState<ZoomVideoSdkUser?>(null);
    var videoInfo = useState<String>('');
    var isSharing = useState(false);
    var isMuted = useState(true);
    var isVideoOn = useState(false);
    var isSpeakerOn = useState(false);
    var isRenameModalVisible = useState(false);
    var isRecordingStarted = useState(false);
    var isMicOriginalOn = useState(false);
    var isMounted = useIsMounted();
    var audioStatusFlag = useState(false);
    var videoStatusFlag = useState(false);
    var userNameFlag = useState(false);
    var userShareStatusFlag = useState(false);
    var isReceiveSpokenLanguageContentEnabled = useState(false);
    var isVideoMirrored = useState(false);
    var isOriginalAspectRatio = useState(false);
    var isPiPView = useState(false);
    var isSharedCamera = useState(false);
    var subSessionKitList = useState(<ZoomVideoSdkSubSessionKit>[]);
    var isSubSessionListVisible = useState(false);
    var isSubSessionRoomVisible = useState(false);
    var isSubSessionStarted = useState(false);
    var isInSubSession = useState(false);
    var subSessionNames = useState(<String>[]);
    CameraShareView cameraShareView = const CameraShareView(creationParams: {});

    //hide status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    var circleButtonSize = 65.0;
    Color backgroundColor = const Color(0xFF232323);
    Color buttonBackgroundColor = const Color.fromRGBO(0, 0, 0, 0.6);
    Color chatTextColor = const Color(0xFFAAAAAA);
    Widget changeNamePopup;
    Widget subSessionListPopup;
    Widget subSessionRoomPopup;
    final args =
    ModalRoute.of(context)!.settings.arguments as CallArguments;

    useEffect(() {
      Future<void>.microtask(() async {
        var token = generateJwt(args.sessionName, args.role);
        try {
          Map<String, bool> SDKaudioOptions = {"connect": true, "mute": true, "autoAdjustSpeakerVolume": false};
          Map<String, bool> SDKvideoOptions = {
            "localVideoOn": true,
          };
          JoinSessionConfig joinSession = JoinSessionConfig(
            sessionName: args.sessionName,
            sessionPassword: args.sessionPwd,
            token: token,
            userName: args.displayName,
            audioOptions: SDKaudioOptions,
            videoOptions: SDKvideoOptions,
            sessionIdleTimeoutMins: int.parse(args.sessionIdleTimeoutMins),
          );
          await zoom.joinSession(joinSession);
        } catch (e) {
          const AlertDialog(
            title: Text("Error"),
            content: Text("Failed to join the session"),
          );
          Future.delayed(const Duration(milliseconds: 1000))
              .asStream()
              .listen((event) {
            Navigator.popAndPushNamed(
              context,
              "Join",
              arguments: JoinArguments(
                  args.isJoin,
                sessionName.value,
                sessionPassword.value,
                args.displayName,
                args.sessionIdleTimeoutMins,
                args.role
              ),
            );
          });
        }
      });
      return null;
    }, []);

    useEffect(() {

      final sessionJoinListener =
      eventListener.addListener(EventType.onSessionJoin, (data) async {
        data = data as Map;
        isInSession.value = true;
        zoom.session
            .getSessionName()
            .then((value) => sessionName.value = value!);
        sessionPassword.value = await zoom.session.getSessionPassword();
        debugPrint("sessionPhonePasscode: ${await zoom.session.getSessionPhonePasscode()}");
        ZoomVideoSdkUser mySelf =
            ZoomVideoSdkUser.fromJson(jsonDecode(data['sessionUser']));
        List<ZoomVideoSdkUser>? remoteUsers =
            await zoom.session.getRemoteUsers();
        var muted = await mySelf.audioStatus?.isMuted();
        var videoOn = await mySelf.videoStatus?.isOn();
        var speakerOn = await zoom.audioHelper.getSpeakerStatus();
        fullScreenUser.value = mySelf;
        remoteUsers?.insert(0, mySelf);
        isMuted.value = muted!;
        isSpeakerOn.value = speakerOn;
        isVideoOn.value = videoOn!;
        users.value = remoteUsers!;
        isReceiveSpokenLanguageContentEnabled.value =
          await zoom.liveTranscriptionHelper.isReceiveSpokenLanguageContentEnabled();
          });

      final sessionLeaveListener =
      eventListener.addListener(EventType.onSessionLeave, (data) async {
        data = data as Map;
        debugPrint("onSessionLeave: ${data['reason']}");
        isInSession.value = false;
        users.value = <ZoomVideoSdkUser>[];
        fullScreenUser.value = null;
        Navigator.popAndPushNamed(
          context,
          "Join",
          arguments: JoinArguments(
              args.isJoin,
              sessionName.value,
              sessionPassword.value,
              args.displayName,
              args.sessionIdleTimeoutMins,
              args.role
          ),
        );
      });

      final sessionNeedPasswordListener =
      eventListener.addListener(EventType.onSessionNeedPassword, (data) async {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Session Need Password'),
            content: const Text('Password is required'),
            actions: <Widget>[
              TextButton(
                onPressed: () async => {Navigator.popAndPushNamed(
                    context,
                    'Join',
                    arguments: JoinArguments(
                        args.isJoin,
                        args.sessionName,
                        "",
                        args.displayName,
                        args.sessionIdleTimeoutMins,
                        args.role
                    )),
                  await zoom.leaveSession(false),
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });

      final sessionPasswordWrongListener =
      eventListener.addListener(EventType.onSessionPasswordWrong, (data) async {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Session Password Incorrect'),
            content: const Text('Password is wrong'),
            actions: <Widget>[
              TextButton(
                onPressed: () async => {Navigator.popAndPushNamed(
                    context,
                    'Join',
                    arguments: JoinArguments(
                        args.isJoin,
                        args.sessionName,
                        "",
                        args.displayName,
                        args.sessionIdleTimeoutMins,
                        args.role
                    )),
                  await zoom.leaveSession(false),
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });

      final userVideoStatusChangedListener =
      eventListener.addListener(EventType.onUserVideoStatusChanged, (data) async {
        data = data as Map;
        ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
        var userListJson = jsonDecode(data['changedUsers']) as List;
        List<ZoomVideoSdkUser> userList = userListJson
            .map((userJson) => ZoomVideoSdkUser.fromJson(userJson))
            .toList();
        for (var user in userList) {
          {
            if (user.userId == mySelf?.userId) {
              mySelf?.videoStatus?.isOn().then((on) => isVideoOn.value = on);
            }
          }
        }
        videoStatusFlag.value = !videoStatusFlag.value;
          });

      final userAudioStatusChangedListener =
          eventListener.addListener(EventType.onUserAudioStatusChanged, (data) async {
        data = data as Map;
        ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
        var userListJson = jsonDecode(data['changedUsers']) as List;
        List<ZoomVideoSdkUser> userList = userListJson
            .map((userJson) => ZoomVideoSdkUser.fromJson(userJson))
            .toList();
        for (var user in userList) {
          {
            if (user.userId == mySelf?.userId) {
              mySelf?.audioStatus
                  ?.isMuted()
                  .then((muted) => isMuted.value = muted);
            }
          }
        }
        audioStatusFlag.value = !audioStatusFlag.value;
      });

      final userShareStatusChangeListener =
          eventListener.addListener(EventType.onUserShareStatusChanged, (data) async {
        data = data as Map;
        ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
        ZoomVideoSdkUser shareUser =
            ZoomVideoSdkUser.fromJson(jsonDecode(data['user'].toString()));
        ZoomVideoSdkShareAction? shareAction =
        ZoomVideoSdkShareAction.fromJson(jsonDecode(data['shareAction']));

        if (shareAction.shareStatus == ShareStatus.Start || shareAction.shareStatus == ShareStatus.Resume) {
          sharingUser.value = shareUser;
          fullScreenUser.value = shareUser;
          isSharing.value = (shareUser.userId == mySelf?.userId);
        } else {
          sharingUser.value = null;
          isSharing.value = false;
          isSharedCamera.value = false;
          fullScreenUser.value = mySelf;
        }
        userShareStatusFlag.value = !userShareStatusFlag.value;
      });

      final shareContentChangedListener = eventListener.addListener(EventType.onShareContentChanged, (data) async {
        data = data as Map;
        ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
        ZoomVideoSdkUser shareUser =
        ZoomVideoSdkUser.fromJson(jsonDecode(data['user'].toString()));
        ZoomVideoSdkShareAction? shareAction =
        ZoomVideoSdkShareAction.fromJson(jsonDecode(data['shareAction']));
        if (shareAction.shareType == ShareType.Camera) {
          debugPrint("Camera share started");
          isSharedCamera.value = (shareUser.userId == mySelf?.userId);
        }
      });

      final userJoinListener = eventListener.addListener(EventType.onUserJoin, (data) async {
        if (!isMounted()) return;
        data = data as Map;
        ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
        var userListJson = jsonDecode(data['remoteUsers']) as List;
        List<ZoomVideoSdkUser> remoteUserList = userListJson
            .map((userJson) => ZoomVideoSdkUser.fromJson(userJson))
            .toList();
        remoteUserList.insert(0, mySelf!);
        users.value = remoteUserList;
      });

      final userLeaveListener = eventListener.addListener(EventType.onUserLeave, (data) async {
        if (!isMounted()) return;
        ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
        data = data as Map;
        List<ZoomVideoSdkUser>? remoteUserList = await zoom.session.getRemoteUsers();
        var leftUserListJson = jsonDecode(data['leftUsers']) as List;
        List<ZoomVideoSdkUser> leftUserLis = leftUserListJson
            .map((userJson) => ZoomVideoSdkUser.fromJson(userJson))
            .toList();
        if (fullScreenUser.value != null) {
          for (var user in leftUserLis) {
            {
              if (fullScreenUser.value?.userId == user.userId) {
                fullScreenUser.value = mySelf;
              }
            }
          }
        } else {
          fullScreenUser.value = mySelf;
        }
        remoteUserList?.add(mySelf!);
        users.value = remoteUserList!;
      });

      final userNameChangedListener =
          eventListener.addListener(EventType.onUserNameChanged, (data) async {
        if (!isMounted()) return;
        data = data as Map;
        ZoomVideoSdkUser? changedUser =
            ZoomVideoSdkUser.fromJson(jsonDecode(data['changedUser']));
        int index;
        for (var user in users.value) {
          if (user.userId == changedUser.userId) {
            index = users.value.indexOf(user);
            users.value[index] = changedUser;
          }
        }
        userNameFlag.value = !userNameFlag.value;
      });

      final userNetworkStatusChangedListener =
      eventListener.addListener(EventType.onUserNetworkStatusChanged, (data) async {
        if (!isMounted()) return;
        data = data as Map;
        ZoomVideoSdkUser? user =
        ZoomVideoSdkUser.fromJson(jsonDecode(data['user']));
        debugPrint(
            "onUserNetworkStatusChanged: ${user.userName}, level: ${data['level']}, dataType: ${data['type']}");

      });

      final userOverallNetworkStatusChangedListener =
      eventListener.addListener(EventType.onUserOverallNetworkStatusChanged, (data) async {
        if (!isMounted()) return;
        data = data as Map;
        ZoomVideoSdkUser? user =
        ZoomVideoSdkUser.fromJson(jsonDecode(data['user']));
        debugPrint(
            "onUserOverallNetworkStatusChanged: ${user.userName}, level: ${data['level']}");

      });

      final commandReceived =
          eventListener.addListener(EventType.onCommandReceived, (data) async {
        data = data as Map;
        debugPrint(
            "sender: ${ZoomVideoSdkUser.fromJson(jsonDecode(data['sender']))}, command: ${data['command']}");
      });

      final liveStreamStatusChangeListener =
          eventListener.addListener(EventType.onLiveStreamStatusChanged, (data) async {
        data = data as Map;
        debugPrint("onLiveStreamStatusChanged: status: ${data['status']}");
      });

      final liveTranscriptionStatusChangeListener =
          eventListener.addListener(EventType.onLiveTranscriptionStatus, (data) async {
        data = data as Map;
        debugPrint("onLiveTranscriptionStatus: status: ${data['status']}");
      });

      final audioSourceTypeChangedListener =
          eventListener.addListener(EventType.onMyAudioSourceTypeChanged, (data) async {
            data = data as Map;
            ZoomVideoSdkAudioDevice? device =
            ZoomVideoSdkAudioDevice.fromJson(jsonDecode(data['device']));
            debugPrint("onMyAudioSourceTypeChanged: device: ${device.deviceName}");
      });

      final cloudRecordingStatusListener =
        eventListener.addListener(EventType.onCloudRecordingStatus, (data) async {
        data = data as Map;
        debugPrint("onCloudRecordingStatus: status: ${data['status']}");
        ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
        if (data['status'] == RecordingStatus.Start) {
          if (mySelf != null && !mySelf.isHost!) {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                content: const Text('The session is being recorded.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      await zoom.acceptRecordingConsent();
                      if (context.mounted) {
                        Navigator.pop(context);
                      };
                    },
                    child: const Text('accept'),
                  ),
                  TextButton(
                    onPressed: () async {
                      String currentConsentType =
                          await zoom.getRecordingConsentType();
                      if (currentConsentType ==
                          ConsentType.ConsentType_Individual) {
                        await zoom.declineRecordingConsent();
                        Navigator.pop(context);
                      } else {
                        await zoom.declineRecordingConsent();
                        zoom.leaveSession(false);
                        if (!context.mounted) return;
                        Navigator.popAndPushNamed(
                          context,
                          "Join",
                          arguments: JoinArguments(
                              args.isJoin,
                              sessionName.value,
                              sessionPassword.value,
                              args.displayName,
                              args.sessionIdleTimeoutMins,
                              args.role
                          ),
                        );
                      }
                    },
                    child: const Text('decline'),
                  ),
                ],
              ),
            );
          }
          isRecordingStarted.value = true;
        } else {
          isRecordingStarted.value = false;
        }
      });

      final liveTranscriptionMsgInfoReceivedListener =
          eventListener.addListener(EventType.onLiveTranscriptionMsgInfoReceived, (data) async {
            data = data as Map;
            ZoomVideoSdkLiveTranscriptionMessageInfo? messageInfo =
            ZoomVideoSdkLiveTranscriptionMessageInfo.fromJson(jsonDecode(data['messageInfo']));
            debugPrint("onLiveTranscriptionMsgInfoReceived: content: ${messageInfo.messageContent}");
      });

      final audioLevelListener =
      eventListener.addListener(EventType.onAudioLevelChanged, (data) async {
        data = data as Map;
        ZoomVideoSdkUser? user =
        ZoomVideoSdkUser.fromJson(jsonDecode(data['user']));
        debugPrint("audioLevelListener: user: ${user.userName}, level: ${data['level']}");
      });


      final inviteByPhoneStatusListener =
          eventListener.addListener(EventType.onInviteByPhoneStatus, (data) async {
        data = data as Map;
        debugPrint(
            "onInviteByPhoneStatus: status: ${data['status']}, reason: ${data['reason']}");
      });

      final multiCameraStreamStatusChangedListener =
          eventListener.addListener(EventType.onMultiCameraStreamStatusChanged, (data) async {
        data = data as Map;
        ZoomVideoSdkUser? changedUser =
            ZoomVideoSdkUser.fromJson(jsonDecode(data['changedUser']));
        var status = data['status'];
        for (var user in users.value) {
          {
            if (changedUser.userId == user.userId) {
              if (status == MultiCameraStreamStatus.Joined) {
                user.hasMultiCamera = true;
              } else if (status == MultiCameraStreamStatus.Left) {
                user.hasMultiCamera = false;
              }
            }
          }
        }
      });

      final requireSystemPermission =
          eventListener.addListener(EventType.onRequireSystemPermission, (data) async {
        data = data as Map;
        ZoomVideoSdkUser? changedUser =
            ZoomVideoSdkUser.fromJson(jsonDecode(data['changedUser']));
        var permissionType = data['permissionType'];
        switch (permissionType) {
          case SystemPermissionType.Camera:
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text("Can't Access Camera"),
                content: const Text(
                    "please turn on the toggle in system settings to grant permission"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            break;
          case SystemPermissionType.Microphone:
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text("Can't Access Microphone"),
                content: const Text(
                    "please turn on the toggle in system settings to grant permission"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            break;
        }
      });

      final networkStatusChangeListener =
      eventListener.addListener(EventType.onUserVideoNetworkStatusChanged, (data) async {
        data = data as Map;
        ZoomVideoSdkUser? networkUser =
        ZoomVideoSdkUser.fromJson(jsonDecode(data['user']));

        if (data['status'] == NetworkStatus.Bad) {
          debugPrint("onUserVideoNetworkStatusChanged: status: ${data['status']}, user: ${networkUser.userName}");
        }
      });

      final eventErrorListener = eventListener.addListener(EventType.onError, (data) async {
        data = data as Map;
        String errorType = data['errorType'];
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Error"),
            content: Text(errorType),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        if (errorType == Errors.SessionJoinFailed ||
            errorType == Errors.SessionDisconnecting) {
          Timer(
              const Duration(milliseconds: 1000),
              () => {
                    Navigator.popAndPushNamed(
                      context,
                      "Join",
                      arguments: JoinArguments(
                          args.isJoin,
                          sessionName.value,
                          sessionPassword.value,
                          args.displayName,
                          args.sessionIdleTimeoutMins,
                          args.role
                      ),
                    ),
                  });
        } else if (errorType == Errors.SessionReconnecting) {
          isInSession.value = false;
          if (isInSubSession.value == true) {
            users.value = <ZoomVideoSdkUser>[];
            fullScreenUser.value = null;
          }
        }
      });

      final userRecordingConsentListener =
          eventListener.addListener(EventType.onUserRecordingConsent, (data) async {
        data = data as Map;
        ZoomVideoSdkUser? user =
            ZoomVideoSdkUser.fromJson(jsonDecode(data['user']));
        debugPrint('userRecordingConsentListener: user= ${user.userName}');
      });

      final callCRCDeviceStatusListener =
          eventListener.addListener(EventType.onCallCRCDeviceStatusChanged, (data) async {
            data = data as Map;
            debugPrint('onCallCRCDeviceStatusChanged: status = ${data['status']}');
      });

      final originalLanguageMsgReceivedListener =
          eventListener.addListener(EventType.onOriginalLanguageMsgReceived, (data) async {
            data = data as Map;
            ZoomVideoSdkLiveTranscriptionMessageInfo? messageInfo =
            ZoomVideoSdkLiveTranscriptionMessageInfo.fromJson(jsonDecode(data['messageInfo']));
            debugPrint("onOriginalLanguageMsgReceived: content: ${messageInfo.messageContent}");
          });

      final chatPrivilegeChangedListener =
      eventListener.addListener(EventType.onChatPrivilegeChanged, (data) async {
        data = data as Map;
        String type = data['privilege'];
        debugPrint('chatPrivilegeChangedListener: type= $type');
      });

      final testMicStatusListener =
      eventListener.addListener(EventType.onTestMicStatusChanged, (data) async {
        data = data as Map;
        String status = data['status'];
        debugPrint('testMicStatusListener: status= $status');
      });

      final micSpeakerVolumeChangedListener =
      eventListener.addListener(EventType.onMicSpeakerVolumeChanged, (data) async {
        data = data as Map;
        int type = data['micVolume'];
        debugPrint('onMicSpeakerVolumeChanged: micVolume= $type, speakerVolume');
      });

      final cameraControlRequestResultListener =
      eventListener.addListener(EventType.onCameraControlRequestResult, (data) async {
        data = data as Map;
        bool approved = data['approved'];
        debugPrint('onCameraControlRequestResult: approved= $approved');
      });

      final callOutUserJoinListener =
      eventListener.addListener(EventType.onCalloutJoinSuccess, (data) async {
        data = data as Map;
        String phoneNumber = data['phoneNumber'];
        ZoomVideoSdkUser? user =
        ZoomVideoSdkUser.fromJson(jsonDecode(data['user']));
        debugPrint('onCalloutJoinSuccess: phoneNumber= $phoneNumber, user= ${user.userName}');
      });

      final whiteboardStatusListener =
      eventListener.addListener(EventType.onUserWhiteboardShareStatusChanged, (data) async {
        data = data as Map;
        ZoomVideoSdkUser shareUser =
        ZoomVideoSdkUser.fromJson(jsonDecode(data['user'].toString()));
        debugPrint('onUserWhiteboardShareStatusChanged: user= ${shareUser.userName}, status= ${data['status']}');
      });

      final whiteboardExportListener = eventListener.addListener(EventType.onWhiteboardExported, (data) async {
        data = data as Map;
        String format = data['format'];
        String exportData = data['data'];
        Uint8List bytes = base64Decode(exportData);
        debugPrint('onWhiteboardExportToImageResult: format= $format');
      });

      final subSessionStatusChangedListener =
      eventListener.addListener(EventType.onSubSessionStatusChanged, (data) async {
        if (!isMounted()) return;
        data = data as Map;
        String status = data['status'];
        debugPrint('onSubSessionStatusChanged: status= $status');
        if (status == SubSessionStatus.Started) {
          isSubSessionStarted.value = true;
        } else if (status == SubSessionStatus.Stopped) {
          isSubSessionStarted.value = false;
        }
      });

      final broadcastMessageFromMainSessionListener =
      eventListener.addListener(EventType.onBroadcastMessageFromMainSession, (data) async {
        if (!isMounted()) return;
        data = data as Map;
        String message = data['message'];
        String userName = data['name'];
        debugPrint('onBroadcastMessageFromMainSession: message= $message, userName= $userName');
      });

      final subSessionUserHelpRequestResultListener =
      eventListener.addListener(EventType.onSubSessionUserHelpRequestResult, (data) async {
        if (!isMounted()) return;
        data = data as Map;
        String result = data['result'];
        debugPrint('onSubSessionUserHelpRequestResult: result= $result');
      });

      final subSessionParticipantJoinListener =
      eventListener.addListener(EventType.onSubSessionParticipantHandle, (data) async {
        isInSubSession.value = !isInSubSession.value;
      });

      return () => {
            sessionJoinListener.cancel(),
            sessionLeaveListener.cancel(),
            sessionPasswordWrongListener.cancel(),
            sessionNeedPasswordListener.cancel(),
            userVideoStatusChangedListener.cancel(),
            userAudioStatusChangedListener.cancel(),
            userJoinListener.cancel(),
            userLeaveListener.cancel(),
            userNameChangedListener.cancel(),
            userShareStatusChangeListener.cancel(),
            liveStreamStatusChangeListener.cancel(),
            cloudRecordingStatusListener.cancel(),
            inviteByPhoneStatusListener.cancel(),
            eventErrorListener.cancel(),
            commandReceived.cancel(),
            liveTranscriptionStatusChangeListener.cancel(),
            liveTranscriptionMsgInfoReceivedListener.cancel(),
            multiCameraStreamStatusChangedListener.cancel(),
            requireSystemPermission.cancel(),
            userRecordingConsentListener.cancel(),
            networkStatusChangeListener.cancel(),
            callCRCDeviceStatusListener.cancel(),
            originalLanguageMsgReceivedListener.cancel(),
            chatPrivilegeChangedListener.cancel(),
            testMicStatusListener.cancel(),
            micSpeakerVolumeChangedListener.cancel(),
            cameraControlRequestResultListener.cancel(),
            callOutUserJoinListener.cancel(),
            shareContentChangedListener.cancel(),
            audioLevelListener.cancel(),
            userNetworkStatusChangedListener.cancel(),
            userOverallNetworkStatusChangedListener.cancel(),
            audioSourceTypeChangedListener.cancel(),
            whiteboardStatusListener.cancel(),
            whiteboardExportListener.cancel(),
            subSessionStatusChangedListener.cancel(),
            broadcastMessageFromMainSessionListener.cancel(),
            subSessionUserHelpRequestResultListener.cancel(),
            subSessionParticipantJoinListener.cancel(),
          };
    }, [zoom, users.value, isMounted]);

    void selectVirtualBackgroundItem() async {
      final ImagePicker picker = ImagePicker();
      // Pick an image.
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      await zoom.virtualBackgroundHelper.addVirtualBackgroundItem(image!.path);
    }

    void onPressAudio() async {
      ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
      if (mySelf != null) {
        final audioStatus = mySelf.audioStatus;
        if (audioStatus != null) {
          var muted = await audioStatus.isMuted();
          if (muted) {
            await zoom.audioHelper.unMuteAudio(mySelf.userId);
          } else {
            await zoom.audioHelper.muteAudio(mySelf.userId);
          }
        }
      }
    }

    void onPressVideo() async {
      ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
      if (mySelf != null) {
        final videoStatus = mySelf.videoStatus;
        if (videoStatus != null) {
          var videoOn = await videoStatus.isOn();
          if (videoOn) {
            await zoom.videoHelper.stopVideo();
          } else {
            await zoom.videoHelper.startVideo();
          }
        }
      }
    }

    void onPressShare() async {
      var isOtherSharing = await zoom.shareHelper.isOtherSharing();
      var isShareLocked = await zoom.shareHelper.isShareLocked();
      String? shareCameraViewResult = Errors.InternalError;

      if (isOtherSharing) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Error"),
            content: const Text('Other is sharing'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (isShareLocked) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Error"),
            content: const Text('Share is locked by host'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else if (isSharing.value) {
        zoom.shareHelper.stopShare();
      } else {
        List<ListTile> options = [
          ListTile(
            title: Text(
              'Share Device Screen',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            onTap: () async => {
              zoom.shareHelper.shareScreen(),
              Navigator.of(context).pop(),
            },
          ),
          ListTile(
            title: Text(
              'Share Camera',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            onTap: () async => {
              shareCameraViewResult = await zoom.shareHelper.startShareCamera(cameraShareView),
              debugPrint('start camera: $shareCameraViewResult'),
              Navigator.of(context).pop(),
            },
          ),
        ];
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                elevation: 0.0,
                insetPadding: const EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                  height: options.length * 60,
                  child: Scrollbar(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: ListTile.divideTiles(
                        context: context,
                        tiles: options,
                      ).toList(),
                    ),
                  ),
                ),
              );
            });
      }
    }

    void onSelectedUserVolume(ZoomVideoSdkUser user) async {
      var isShareAudio = user.isSharing;
      bool canSetVolume =
          await user.canSetUserVolume(user.userId, isShareAudio);
      num userVolume;

      List<ListTile> options = [
        ListTile(
          title: Text(
            'Adjust Volume',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
        ListTile(
          title: Text(
            'Current volume',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            debugPrint('user volume'),
            userVolume = await user.getUserVolume(user.userId, isShareAudio),
            debugPrint('user ${user.userName}\'s volume is ${userVolume!}'),
          },
        ),
      ];
      if (canSetVolume) {
        options.add(
          ListTile(
          title: Text(
            'Volume up',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            userVolume = await user.getUserVolume(user.userId, isShareAudio),
            if (userVolume < 10) {
              await user.setUserVolume(user.userId, userVolume + 1, isShareAudio),
            } else {
              debugPrint("Cannot volume up."),
            }
          },
        ),
        );
        options.add(
          ListTile(
            title: Text(
              'Volume down',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            onTap: () async => {
              userVolume = await user.getUserVolume(user.userId, isShareAudio),
              if (userVolume > 0) {
                await user.setUserVolume(user.userId, userVolume - 1, isShareAudio),
              } else {
                debugPrint("Cannot volume down."),
              }
            },
          ),
        );
      }
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
                elevation: 0.0,
                insetPadding: const EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                  height: options.length * 58,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListView(
                        shrinkWrap: true,
                        children: ListTile.divideTiles(
                          context: context,
                          tiles: options,
                        ).toList(),
                      ),
                    ],
                  ),
                ));
          });
    }

    void onPressCameraList() async {
      List<ListTile> options = [];
      List<ZoomVideoSdkCameraDevice> cameraList =
          await zoom.videoHelper.getCameraList();
      for (var camera in cameraList) {
        options.add(
          ListTile(
            title: Text(
              camera.deviceName,
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            onTap: () async => {
              await zoom.videoHelper.switchCamera(camera.deviceId),
              Navigator.of(context).pop(),
            },
          ),
        );
      }
      options.add(
        ListTile(
          title: Text(
            "Cancel",
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            Navigator.of(context).pop(),
          },
        ),
      );
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              elevation: 0.0,
              insetPadding: const EdgeInsets.symmetric(horizontal: 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: SizedBox(
                height: options.length * 60,
                child: Scrollbar(
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: options,
                    ).toList(),
                  ),
                ),
              ),
            );
          });
    }

    void onPressAudioDeviceList() async {
      List<ListTile> options = [];
      List<ZoomVideoSdkAudioDevice>? audioList;
      if (Platform.isAndroid) {
        audioList = await zoom.audioHelper.getAudioDeviceList();
      } else {
        audioList = await zoom.audioHelper.getAvailableAudioOutputRoute();
      }
      for (var device in audioList!) {
        options.add(
          ListTile(
            title: Text(
              device.deviceName,
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            onTap: () async => {
              debugPrint("select audio device: ${device.deviceName}"),
              if (Platform.isAndroid) {
                debugPrint("switch audio device: ${await zoom.audioHelper.switchToAudioSourceType(device.deviceName)}"),
              } else {
                debugPrint("switch audio device: ${await zoom.audioHelper.setAudioOutputRoute(device.deviceName)}"),
              },
              Navigator.of(context).pop(),
            },
          ),
        );
      }
      options.add(
        ListTile(
          title: Text(
            "Cancel",
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            Navigator.of(context).pop(),
          },
        ),
      );
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              elevation: 0.0,
              insetPadding: const EdgeInsets.symmetric(horizontal: 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: SizedBox(
                height: options.length * 60,
                child: Scrollbar(
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: options,
                    ).toList(),
                  ),
                ),
              ),
            );
          });
    }

    Future<void> onPressMore() async {
      ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
      bool isShareLocked = await zoom.shareHelper.isShareLocked();
      bool canSwitchSpeaker = await zoom.audioHelper.canSwitchSpeaker();
      bool canStartRecording =
          (await zoom.recordingHelper.canStartRecording()) == Errors.Success;

      var startLiveTranscription =
          (await zoom.liveTranscriptionHelper.getLiveTranscriptionStatus()) ==
              LiveTranscriptionStatus.Start;
      bool canStartLiveTranscription =
          await zoom.liveTranscriptionHelper.canStartLiveTranscription();
      bool isHost = (mySelf != null) ? (await mySelf.getIsHost()) : false;
      isOriginalAspectRatio.value =
          await zoom.videoHelper.isOriginalAspectRatioEnabled();
      bool canCallOutToCRC = await zoom.CRCHelper.isCRCEnabled();
      bool supportVB = await zoom.virtualBackgroundHelper.isSupportVirtualBackground();
      List<ZoomVideoSdkShareAction>? shareActionList = await mySelf?.getShareActionList();

      List<ListTile> options = [
        ListTile(
          title: Text(
            'More',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
        ListTile(
          title: Text(
            'Get Chat Privilege',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            debugPrint(
                "Chat Privilege = ${await zoom.chatHelper.getChatPrivilege()}"),
            Navigator.of(context).pop(),
          },
        ),
        ListTile(
          title: Text(
            'Get Session Dial-in Number infos',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            debugPrint(
                "session number = ${await zoom.session.getSessionNumber()}"),
            Navigator.of(context).pop(),
          },
        ),
        ListTile(
          title: Text(
            'Start Share Whiteboard',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            debugPrint(
                "start share = ${await zoom.whiteboardHelper.startShareWhiteboard()}"),
            Navigator.of(context).pop(),
          },
        ),
        ListTile(
          title: Text(
            'Subscribe Whiteboard',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            debugPrint(
                "subscribe = ${await zoom.whiteboardHelper.subscribeWhiteboard(0.0, 0.0, 200.0, 400.0)}"),
            Navigator.of(context).pop(),
          },
        ),
        ListTile(
          title: Text(
            'Get Camera List',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            debugPrint("camera list= ${await zoom.videoHelper.getCameraList()}"),
            onPressCameraList(),
            Navigator.of(context).pop(),
          },
        ),
        ListTile(
          title: Text(
            'Get Audio List',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            onPressAudioDeviceList(),
            Navigator.of(context).pop(),
          },
        ),
        ListTile(
          title: Text(
            '${isMicOriginalOn.value ? 'Disable' : 'Enable'} Original Sound',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            debugPrint("${isMicOriginalOn.value}"),
            await zoom.audioSettingHelper
                .enableMicOriginalInput(!isMicOriginalOn.value),
            isMicOriginalOn.value =
                await zoom.audioSettingHelper.isMicOriginalInputEnable(),
            debugPrint(
                "Original sound ${isMicOriginalOn.value ? 'Enabled' : 'Disabled'}"),
            Navigator.of(context).pop(),
          },
        ),
        ListTile(
          title: Text(
            'Modify subSession name',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            debugPrint("${subSessionNames.value}"),
            isSubSessionListVisible.value = true,
            Navigator.of(context).pop(),
          },
        ),
        ListTile(
          title: Text(
            'Show Sub-sessions',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            subSessionKitList.value = await zoom.subSessionHelper.getCommittedSubSessionList(),
            debugPrint("${subSessionNames.value}"),
            isSubSessionRoomVisible.value = true,
            Navigator.of(context).pop(),
          },
        )
      ];

      if (supportVB) {
        options.add(
          ListTile(
            title: Text(
              'Add Virtual Background',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            onTap: () async => {
              selectVirtualBackgroundItem(),
              Navigator.of(context).pop(),
            },
          ),
        );
      }

      if (canCallOutToCRC) {
        options.add(
            ListTile(
              title: Text(
                'Call-out to CRC devices',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
              onTap: () async => {
                debugPrint('CRC result = ${await zoom.CRCHelper.callCRCDevice("bjn.vc", ZoomVideoSdkCRCProtocolType.SIP)}'),
                Navigator.of(context).pop(),
              },
            ));
        options.add(
            ListTile(
              title: Text(
                'Cancel call-out to CRC devices',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
              onTap: () async => {
                debugPrint('cancel result= ${await zoom.CRCHelper.cancelCallCRCDevice()}'),
                Navigator.of(context).pop(),
              },
            ));
      }

      if (canSwitchSpeaker) {
        options.add(ListTile(
          title: Text(
            'Turn ${isSpeakerOn.value ? 'off' : 'on'} Speaker',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            await zoom.audioHelper.setSpeaker(!isSpeakerOn.value),
            isSpeakerOn.value = await zoom.audioHelper.getSpeakerStatus(),
            debugPrint('Turned ${isSpeakerOn.value ? 'on' : 'off'} Speaker'),
            Navigator.of(context).pop(),
          },
        ));
      }

      if (isHost) {
        options.add(ListTile(
            title: Text(
              '${isShareLocked ? 'Unlock' : 'Lock'} Share',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            onTap: () async => {
                  debugPrint(
                      "isShareLocked = ${await zoom.shareHelper.lockShare(!isShareLocked)}"),
                  Navigator.of(context).pop(),
                }));
        options.add(ListTile(
          title: Text(
            'Change Name',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () => {
            isRenameModalVisible.value = true,
            Navigator.of(context).pop(),
          },
        ));
      }

      if (canStartLiveTranscription) {
        options.add(ListTile(
          title: Text(
            "${startLiveTranscription ? 'Stop' : 'Start'} Live Transcription",
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            if (startLiveTranscription)
              {
                debugPrint(
                    'stopLiveTranscription= ${await zoom.liveTranscriptionHelper.stopLiveTranscription()}'),
              }
            else
              {
                debugPrint(
                    'startLiveTranscription= ${await zoom.liveTranscriptionHelper.startLiveTranscription()}'),
              },
            Navigator.of(context).pop(),
          },
        ));
        options.add(ListTile(
            title: Text(
              '${isReceiveSpokenLanguageContentEnabled.value ? 'Disable' : 'Enable'} receiving original caption',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            onTap: () async => {
              await zoom.liveTranscriptionHelper.enableReceiveSpokenLanguageContent(!isReceiveSpokenLanguageContentEnabled.value),
              isReceiveSpokenLanguageContentEnabled.value = await zoom.liveTranscriptionHelper.isReceiveSpokenLanguageContentEnabled(),
              debugPrint("isReceiveSpokenLanguageContentEnabled = ${isReceiveSpokenLanguageContentEnabled.value}"),
              Navigator.of(context).pop(),
            }));
      }

      if (canStartRecording) {
        options.add(ListTile(
            title: Text(
              '${isRecordingStarted.value ? 'Stop' : 'Start'} Recording',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            onTap: () async => {
                  if (!isRecordingStarted.value)
                    {
                      debugPrint(
                          'isRecordingStarted = ${await zoom.recordingHelper.startCloudRecording()}'),
                    }
                  else
                    {
                      debugPrint(
                          'isRecordingStarted = ${await zoom.recordingHelper.stopCloudRecording()}'),
                    },
                  Navigator.of(context).pop(),
                }));
      }

      if (Platform.isAndroid) {
        bool isFlashlightSupported = await zoom.videoHelper.isSupportFlashlight();
        bool isFlashlightOn = await zoom.videoHelper.isFlashlightOn();
        if (isFlashlightSupported) {
          options.add(ListTile(
              title: Text(
                '${isFlashlightOn ? 'Turn Off' : 'Turn On'} Flashlight',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
              onTap: () async => {
                if (!isFlashlightOn)
                  {
                    await zoom.videoHelper.turnOnOrOffFlashlight(true),
                  }
                else
                  {
                    await zoom.videoHelper.turnOnOrOffFlashlight(false),
                  },
                Navigator.of(context).pop(),
              }));
        }
      }

      if (Platform.isIOS) {
        options.add(ListTile(
            title: Text(
              '${isPiPView.value ? 'Disable' : 'Enable'} picture in picture view',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            onTap: () async => {
              isPiPView.value = !isPiPView.value,
              Navigator.of(context).pop(),
            }));
      }

      if (isVideoOn.value) {
        options.add(ListTile(
            title: Text(
              'Mirror the video',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            onTap: () async => {
                  await zoom.videoHelper.mirrorMyVideo(!isVideoMirrored.value),
                  isVideoMirrored.value =
                      await zoom.videoHelper.isMyVideoMirrored(),
                  Navigator.of(context).pop(),
                }));
        options.add(ListTile(
            title: Text(
              '${isOriginalAspectRatio.value ? 'Enable' : 'Disable'} original aspect ratio',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            onTap: () async => {
                  await zoom.videoHelper
                      .enableOriginalAspectRatio(!isOriginalAspectRatio.value),
                  isOriginalAspectRatio.value =
                      await zoom.videoHelper.isOriginalAspectRatioEnabled(),
                  debugPrint(
                      "isOriginalAspectRatio= ${isOriginalAspectRatio.value}"),
                  Navigator.of(context).pop(),
                }));
      }

      // SubSession Helper functions
      options.add(ListTile(
        title: Text(
          'Is SubSession Started',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
        onTap: () async => {
          debugPrint(
              'isSubSessionStarted = ${await zoom.subSessionHelper.isSubSessionStarted()}'),
          Navigator.of(context).pop(),
        },
      ));

      if (isHost) {
        options.add(ListTile(
          title: Text(
            'Start SubSession',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            debugPrint(
                'startSubSession = ${await zoom.subSessionHelper.startSubSession()}'),
            Navigator.of(context).pop(),
          },
        ));

        options.add(ListTile(
          title: Text(
            'Stop SubSession',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            debugPrint(
                'stopSubSession = ${await zoom.subSessionHelper.stopSubSession()}'),
            Navigator.of(context).pop(),
          },
        ));

        options.add(ListTile(
          title: Text(
            'Broadcast Message',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            debugPrint(
                'broadcastMessage = ${await zoom.subSessionHelper.broadcastMessage("Hello from main session!")}'),
            Navigator.of(context).pop(),
          },
        ));

        options.add(ListTile(
          title: Text(
            'Withdraw SubSession List',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            debugPrint(
                'withdrawSubSessionList = ${await zoom.subSessionHelper.withdrawSubSessionList()}'),
            Navigator.of(context).pop(),
          },
        ));

        options.add(ListTile(
          title: Text(
            'Ignore User Help Request',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            debugPrint(
                'ignoreUserHelpRequest = ${await zoom.subSessionHelper.ignoreUserHelpRequest()}'),
            Navigator.of(context).pop(),
          },
        ));

        options.add(ListTile(
          title: Text(
            'Join SubSession By User Request',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            debugPrint(
                'joinSubSessionByUserRequest = ${await zoom.subSessionHelper.joinSubSessionByUserRequest()}'),
            Navigator.of(context).pop(),
          },
        ));

        options.add(ListTile(
          title: Text(
            'Get Request User Name',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            debugPrint(
                'getRequestUserName = ${await zoom.subSessionHelper.getRequestUserName()}'),
            Navigator.of(context).pop(),
          },
        ));

        options.add(ListTile(
          title: Text(
            'Get Request SubSession Name',
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          onTap: () async => {
            debugPrint(
                'getRequestSubSessionName = ${await zoom.subSessionHelper.getRequestSubSessionName()}'),
            Navigator.of(context).pop(),
          },
        ));
      }

      options.add(ListTile(
        title: Text(
          'Return To Main Session',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
        onTap: () async => {
          debugPrint(
              'returnToMainSession = ${await zoom.subSessionHelper.returnToMainSession()}'),
          Navigator.of(context).pop(),
        },
      ));

      options.add(ListTile(
        title: Text(
          'Request For Help',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
        onTap: () async => {
          debugPrint(
              'requestForHelp = ${await zoom.subSessionHelper.requestForHelp()}'),
          Navigator.of(context).pop(),
        },
      ));

      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
                elevation: 0.0,
                insetPadding: const EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: SizedBox(
                    height: 500,
                    child: Scrollbar(
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: ListTile.divideTiles(
                          context: context,
                          tiles: options,
                        ).toList(),
                      ),
                    ),
                  ),
                );
          });
    }

    void onLeaveSession(bool isEndSession) async {
      await zoom.leaveSession(isEndSession);
    }

    void showLeaveOptions() async {
      ZoomVideoSdkUser? mySelf = await zoom.session.getMySelf();
      bool isHost = await mySelf!.getIsHost();

      Widget endSession;
      Widget leaveSession;
      Widget cancel = TextButton(
        child: const Text('Cancel'),
        onPressed: () {
          Navigator.pop(context); //close Dialog
        },
      );

      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          endSession = TextButton(
            child: const Text('End Session'),
            onPressed: () => onLeaveSession(true),
          );
          leaveSession = TextButton(
            child: const Text('Leave Session'),
            onPressed: () => onLeaveSession(false),
          );
          break;
        default:
          endSession = CupertinoActionSheetAction(
            isDestructiveAction: true,
            child: const Text('End Session'),
            onPressed: () => onLeaveSession(true),
          );
          leaveSession = CupertinoActionSheetAction(
            child: const Text('Leave Session'),
            onPressed: () => onLeaveSession(false),
          );
          break;
      }

      List<Widget> options = [
        leaveSession,
        cancel,
      ];

      if (Platform.isAndroid) {
        if (isHost) {
          options.removeAt(1);
          options.insert(0, endSession);
        }
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text("Do you want to leave this session?"),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2.0))),
                actions: options,
              );
            });
      } else {
        options.removeAt(1);
        if (isHost) {
          options.insert(1, endSession);
        }
        showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
            message:
                const Text('Are you sure that you want to leave the session?'),
            actions: options,
            cancelButton: cancel,
          ),
        );
      }
    }

    final chatMessageController = TextEditingController();

    void sendChatMessage(String message) async {
      await zoom.chatHelper.sendChatToAll(message);
      ZoomVideoSdkUser? self = await zoom.session.getMySelf();
      ZoomVideoSdkCmdChannel cmdChannel = zoom.cmdChannel;
      for (var user in users.value) {
        if (user.userId != self?.userId) {
          await zoom.cmdChannel.sendCommand(user.userId, message);
        }
      }
      chatMessageController.clear();
      // send the chat as a command
    }

    void onSelectedUser(ZoomVideoSdkUser user) async {
      setState(() {
        fullScreenUser.value = user;
      });
    }

    changeNamePopup = Center(
      child: Stack(
        children: [
          Visibility(
              visible: isRenameModalVisible.value,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width - 130,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Center(
                      child: (Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              'Change Name',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 230,
                              child: TextField(
                                onEditingComplete: () {},
                                autofocus: true,
                                cursorColor: Colors.black,
                                controller: changeNameController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: 'New name',
                                  hintStyle: TextStyle(
                                    fontSize: 14.0,
                                    color: chatTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: InkWell(
                                    child: Text(
                                      'Apply',
                                      style: GoogleFonts.lato(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      if (fullScreenUser.value != null) {
                                        ZoomVideoSdkUser? mySelf =
                                        await zoom.session.getMySelf();
                                        await zoom.userHelper.changeName(
                                            (mySelf?.userId)!,
                                            changeNameController.text);
                                        changeNameController.clear();
                                      }
                                      isRenameModalVisible.value = false;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: InkWell(
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.lato(
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      isRenameModalVisible.value = false;
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );

    subSessionRoomPopup = Center(
        child: Stack(
            children: [
              Visibility(
          visible: isSubSessionRoomVisible.value,
          child: Stack(
            children: [
              // Dim background
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => isSubSessionRoomVisible.value = false,
                  child: Container(color: Colors.black.withOpacity(0.35)),
                ),
              ),
              // Centered card
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520, maxHeight: 560),
                  child: Material(
                    elevation: 12,
                    borderRadius: BorderRadius.circular(16),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          color: Theme.of(context).colorScheme.surfaceContainerHighest,
                          child: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Sub-sessions',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                              ),
                              IconButton(
                                tooltip: 'Close',
                                icon: const Icon(Icons.close),
                                onPressed: () => isSubSessionRoomVisible.value = false,
                              ),
                            ],
                          ),
                        ),
                        // List
                        Expanded(
                          child: subSessionKitList.value.isEmpty
                              ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(24),
                              child: Text('No sub-sessions available.'),
                            ),
                          )
                              : ListView.separated(
                            padding: const EdgeInsets.all(12),
                            itemCount: subSessionKitList.value.length,
                            separatorBuilder: (_, __) => const Divider(height: 1),
                            itemBuilder: (_, i) {
                              ZoomVideoSdkSubSessionKit kit = subSessionKitList.value[i];
                              final count = kit.subSessionUserList.length;
                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                title: Text(kit.subSessionName, style: const TextStyle(fontWeight: FontWeight.w500)),
                                leading: Chip(
                                  label: Text('$count'),
                                  avatar: const Icon(Icons.group, size: 18),
                                  visualDensity: VisualDensity.compact,
                                ),
                                trailing: ElevatedButton.icon(
                                  onPressed: isSubSessionStarted.value
                                      ? () async {
                                    debugPrint('join subSession = ${await zoom.subSessionHelper.joinSubSession(kit.subSessionId)}');
                                    isSubSessionRoomVisible.value = false;
                                  } : null, // disables the button when false
                                  icon: const Icon(Icons.login),
                                  label: const Text('Join'),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),)]
        )
    );

    subSessionListPopup = Center(
      child: Stack(
        children: [
          Visibility(
              visible: isSubSessionListVisible.value,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width - 130,
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              'Manage Sub-session Names',
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          // Add field
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: subSessionNameController,
                                    autofocus: true,
                                    cursorColor: Colors.black,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      hintText: 'New name',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () {
                                    final v = subSessionNameController.text.trim();
                                    if (v.isEmpty) return;
                                    subSessionNames.value = [...subSessionNames.value, v];
                                    subSessionNameController.clear();
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(
                                      '+',
                                      style: GoogleFonts.lato(
                                        textStyle: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // List
                          Padding(
                            padding: const EdgeInsets.only(top: 12, left: 20, right: 20),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 230,
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: ValueListenableBuilder<List<String>>(
                                valueListenable: subSessionNames,
                                builder: (context, items, _) {
                                  if (items.isEmpty) {
                                    return const Center(child: Text('No items yet'));
                                  }
                                  return ListView.separated(
                                    itemCount: items.length,
                                    separatorBuilder: (_, __) => const Divider(height: 1),
                                    itemBuilder: (context, i) {
                                      final item = items[i];
                                      return Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                              child: Text(
                                                item,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.lato(
                                                  textStyle: const TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              final next = [...items]..removeAt(i);
                                              subSessionNames.value = next;
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                              child: Text(
                                                '−',
                                                style: GoogleFonts.lato(
                                                  textStyle: const TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),

                          // Actions
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: InkWell(
                                    child: Text(
                                      'Apply',
                                      style: GoogleFonts.lato(
                                        textStyle: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    onTap: () async {
                                      debugPrint(
                                          'commitSubSessionList = ${await zoom.subSessionHelper.commitSubSessionList(subSessionNames.value)}');
                                      isSubSessionListVisible.value = false;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: InkWell(
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.lato(
                                        textStyle: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    onTap: () {
                                      isSubSessionListVisible.value = false;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ])
    );

    Widget fullScreenView;
    Widget smallView;
    Widget cameraView;

    if (isInSession.value &&
        fullScreenUser.value != null &&
        users.value.isNotEmpty) {
      fullScreenView = AnimatedOpacity(
        opacity: opacityLevel,
        duration: const Duration(seconds: 3),
        child: VideoView(
          key: ValueKey('fullscreen_${fullScreenUser.value?.userId}'),
          user: fullScreenUser.value,
          hasMultiCamera: false,
          isPiPView: isPiPView.value,
          sharing: sharingUser.value == null
              ? false
              : (sharingUser.value?.userId == fullScreenUser.value?.userId),
          preview: false,
          focused: false,
          multiCameraIndex: "0",
          videoAspect: VideoAspect.Original,
          fullScreen: true,
          resolution: VideoResolution.Resolution360,
        ),
      );

      smallView = Container(
        height: 110,
        margin: const EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.center,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: users.value.length,
          itemBuilder: (BuildContext context, int index) {
            final user = users.value[index];
            return InkWell(
              key: ValueKey(user.userId),
              onTap: () async {
                onSelectedUser(user);
              },
              onDoubleTap: () async {
                onSelectedUserVolume(user);
              },
              child: Center(
                child: VideoView(
                  key: ValueKey('video_${user.userId}'),
                  user: user,
                  hasMultiCamera: false,
                  isPiPView: false,
                  sharing: false,
                  preview: false,
                  focused: false,
                  multiCameraIndex: "0",
                  videoAspect: VideoAspect.Original,
                  fullScreen: false,
                  resolution: VideoResolution.Resolution180,
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      );
    } else {
      fullScreenView = Container(
          color: Colors.black,
          child: const Center(
            child: Text(
              "Connecting...",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ));
      smallView = Container(
        height: 110,
        color: Colors.transparent,
      );
    }

    cameraView = Offstage(
      offstage: !isSharedCamera.value,
      child: AnimatedOpacity(
        opacity: isSharedCamera.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: cameraShareView,
      ),
    );

    _changeOpacity;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            fullScreenView,
            cameraView,
            Container(
                padding: const EdgeInsets.only(top: 35),
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 80,
                          width: 180,
                          margin: const EdgeInsets.only(top: 16, left: 8),
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            color: buttonBackgroundColor,
                          ),
                          child: InkWell(
                            onTap: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                        elevation: 0.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: FractionallySizedBox(
                                          heightFactor: 0.4,
                                          widthFactor: 0.7,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              ListView(
                                                shrinkWrap: true,
                                                children: ListTile.divideTiles(
                                                  context: context,
                                                  tiles: [
                                                    ListTile(
                                                      title: Text(
                                                        'Session Information',
                                                        style: GoogleFonts.lato(
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Text(
                                                        'Session Name',
                                                        style: GoogleFonts.lato(
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                      subtitle: Text(
                                                        sessionName.value,
                                                        style: GoogleFonts.lato(
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Text(
                                                        'Session Password',
                                                        style: GoogleFonts.lato(
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      subtitle: Text(
                                                        sessionPassword.value,
                                                        style: GoogleFonts.lato(
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Text(
                                                        'Participants',
                                                        style: GoogleFonts.lato(
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      subtitle: Text(
                                                        '${users.value.length}',
                                                        style: GoogleFonts.lato(
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ).toList(),
                                              ),
                                            ],
                                          ),
                                        ));
                                  });
                            },
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical:4)),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        sessionName.value,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5)),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Participants: ${users.value.length}",
                                        style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset(
                                      "assets/icons/unlocked@2x.png",
                                      height: 22,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: (showLeaveOptions),
                            child: Container(
                              alignment: Alignment.topRight,
                              margin: const EdgeInsets.only(top: 16, right: 8),
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 16, right: 16),
                              height: 28,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                                color: buttonBackgroundColor,
                              ),
                              child: const Text(
                                "LEAVE",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE02828),
                                ),
                              ),
                            )),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FractionallySizedBox(
                        widthFactor: 0.2,
                        heightFactor: 0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: onPressAudio,
                              icon: isMuted.value
                                  ? Image.asset("assets/icons/unmute@2x.png")
                                  : Image.asset("assets/icons/mute@2x.png"),
                              iconSize: circleButtonSize,
                              tooltip: isMuted.value == true ? "Unmute" : "Mute",
                            ),
                            IconButton(
                              onPressed: onPressShare,
                              icon: isSharing.value
                                  ? Image.asset("assets/icons/share-off@2x.png")
                                  : Image.asset("assets/icons/share-on@2x.png"),
                              iconSize: circleButtonSize,
                            ),
                            IconButton(
                              onPressed: onPressVideo,
                              iconSize: circleButtonSize,
                              icon: isVideoOn.value
                                  ? Image.asset("assets/icons/video-off@2x.png")
                                  : Image.asset("assets/icons/video-on@2x.png"),
                            ),
                            IconButton(
                              onPressed: onPressMore,
                              icon: Image.asset("assets/icons/more@2x.png"),
                              iconSize: circleButtonSize,
                            ),
                          ],
                        ),
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 40, top: 10),
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom == 0
                            ? 65
                            : MediaQuery.of(context).viewInsets.bottom + 18,
                        child: TextField(
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: chatTextColor),
                          cursorColor: chatTextColor,
                          textAlignVertical: TextAlignVertical.center,
                          controller: chatMessageController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 16, top: 10, bottom: 10, right: 16),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: chatTextColor), //<-- SEE HERE
                            ),
                            hintText: 'Type comment',
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              color: chatTextColor,
                            ),
                          ),
                          onSubmitted: (String str) {
                            sendChatMessage(str);
                          },
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: const EdgeInsets.only(bottom: 120),
                      child: smallView,
                    ),
                    CommentList(zoom: zoom, eventListener: eventListener),
                    changeNamePopup,
                    subSessionListPopup,
                    subSessionRoomPopup,
                  ],
                )),
          ],
        )
        );
  }
}
