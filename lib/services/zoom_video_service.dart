import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_event_listener.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_user.dart';

class ZoomVideoService {
  final ZoomVideoSdk _sdk = ZoomVideoSdk();
  final ZoomVideoSdkEventListener _eventListener = ZoomVideoSdkEventListener();
  bool _initialized = false;

  ZoomVideoSdk get sdk => _sdk;
  ZoomVideoSdkEventListener get eventListener => _eventListener;

  Future<void> initialize({required String domain}) async {
    if (_initialized) {
      return;
    }
    final res = await _sdk.initSdk(InitConfig(domain: domain, enableLog: true));
    if (!res.toLowerCase().contains('initialized successfully')) {
      throw Exception(res.isEmpty ? 'Zoom SDK init failed' : res);
    }
    _initialized = true;
  }

  Future<String> joinSession({
    required String sessionName,
    required String token,
    required String userId,
  }) async {
    return _sdk.joinSession(
      JoinSessionConfig(
        sessionName: sessionName,
        sessionPassword: '',
        token: token,
        userName: userId,
        audioOptions: {
          'connect': true,
          'mute': false,
          'autoAdjustSpeakerVolume': true,
        },
        videoOptions: {'localVideoOn': true},
        sessionIdleTimeoutMins: 40,
      ),
    );
  }

  Future<void> leaveSession() async {
    await _sdk.leaveSession(false);
  }

  Future<void> toggleMic({
    required ZoomVideoSdkUser user,
    required bool muted,
  }) async {
    if (muted) {
      await _sdk.audioHelper.muteAudio(user.userId);
    } else {
      await _sdk.audioHelper.unMuteAudio(user.userId);
    }
  }

  Future<void> toggleCamera({required bool disabled}) async {
    if (disabled) {
      await _sdk.videoHelper.stopVideo();
    } else {
      await _sdk.videoHelper.startVideo();
    }
  }

  Future<void> setSpeaker({required bool isOn}) async {
    await _sdk.audioHelper.setSpeaker(isOn);
  }

  Future<void> switchCamera() async {
    await _sdk.videoHelper.switchCamera(null);
  }

  Future<ZoomVideoSdkUser?> getMySelf() async {
    return _sdk.session.getMySelf();
  }

  Future<List<ZoomVideoSdkUser>?> getRemoteUsers() async {
    return _sdk.session.getRemoteUsers();
  }
}
