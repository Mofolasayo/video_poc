import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_event_listener.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_user.dart';
import 'package:stacked/stacked.dart';
import 'package:video_poc/app/app.locator.dart';
import 'package:video_poc/models/call_state.dart';
import 'package:video_poc/services/zoom_token_service.dart';
import 'package:video_poc/services/zoom_video_service.dart';

class VideoCallViewModel extends BaseViewModel {
  VideoCallViewModel({required this.sessionName, required this.userId});

  final String sessionName;
  final String userId;

  final ZoomVideoService _zoomService = locator<ZoomVideoService>();
  final ZoomTokenService _tokenService = locator<ZoomTokenService>();

  final List<StreamSubscription> _eventSubs = [];
  Timer? _joinTimeoutTimer;

  CallState _state = CallState.idle;
  bool _isMicMuted = false;
  bool _isCameraOff = false;
  ZoomVideoSdkUser? _localUser;
  ZoomVideoSdkUser? _remoteUser;
  String _phase = '';
  String? _lastError;

  CallState get state => _state;
  bool get isMicMuted => _isMicMuted;
  bool get isCameraOff => _isCameraOff;
  ZoomVideoSdkUser? get localUser => _localUser;
  ZoomVideoSdkUser? get remoteUser => _remoteUser;
  String get phase => _phase;
  String? get lastError => _lastError;

  Future<void> startCall() async {
    _lastError = null;
    _localUser = null;
    _remoteUser = null;
    _phase = 'Starting...';
    _joinTimeoutTimer?.cancel();
    setBusy(true);
    _setState(CallState.calling);
    _bindEvents();

    try {
      _setPhase('Initializing Zoom SDK...');
      debugPrint('[VideoCall] initialize...');
      await _zoomService
          .initialize(domain: 'zoom.us')
          .timeout(const Duration(seconds: 10));
      _setPhase('Requesting token...');
      debugPrint('[VideoCall] fetching token...');
      final token = await _tokenService
          .fetchToken(sessionName: sessionName, userId: userId)
          .timeout(const Duration(seconds: 15));
      _setPhase('Joining session...');
      debugPrint(
        '[VideoCall] joinSession(session=$sessionName, user=$userId)...',
      );
      final joinResult = await _zoomService
          .joinSession(sessionName: sessionName, token: token, userId: userId)
          .timeout(const Duration(seconds: 10));
      debugPrint('[VideoCall] joinSession result: $joinResult');
      if (joinResult.toLowerCase().contains('failure')) {
        _lastError = joinResult;
        _setPhase('Failed');
        _setState(CallState.failed);
        return;
      }
      _setPhase('Waiting for join confirmation...');
      _joinTimeoutTimer = Timer(const Duration(seconds: 15), () {
        if (_state == CallState.connected || _state == CallState.ended) {
          return;
        }
        _lastError ??= 'Timed out joining the Zoom session.';
        _setPhase('Failed');
        _setState(CallState.failed);
      });
    } catch (e) {
      debugPrint('[VideoCall] startCall error: $e');
      _lastError = e.toString();
      _setPhase('Failed');
      _setState(CallState.failed);
    } finally {
      setBusy(false);
    }
  }

  Future<void> endCall() async {
    _setState(CallState.ended);
    _joinTimeoutTimer?.cancel();
    _setPhase('Call ended');
    try {
      await _zoomService.leaveSession();
    } catch (_) {}
  }

  Future<void> toggleMic() async {
    _isMicMuted = !_isMicMuted;
    notifyListeners();
    try {
      final user = _localUser ?? await _zoomService.getMySelf();
      if (user == null) {
        return;
      }
      await _zoomService.toggleMic(user: user, muted: _isMicMuted);
    } catch (_) {}
  }

  Future<void> toggleCamera() async {
    _isCameraOff = !_isCameraOff;
    notifyListeners();
    try {
      await _zoomService.toggleCamera(disabled: _isCameraOff);
    } catch (_) {}
  }

  Future<void> switchCamera() async {
    try {
      await _zoomService.switchCamera();
    } catch (_) {}
  }

  @override
  void dispose() {
    _joinTimeoutTimer?.cancel();
    for (final sub in _eventSubs) {
      sub.cancel();
    }
    super.dispose();
  }

  void _bindEvents() {
    if (_eventSubs.isNotEmpty) {
      return;
    }

    _eventSubs.add(
      _zoomService.eventListener.addListener(EventType.onSessionJoin, (
        data,
      ) async {
        debugPrint('[VideoCall] onSessionJoin: $data');
        _joinTimeoutTimer?.cancel();
        final payload = _castMessage(data);
        final sessionUser = payload['sessionUser'];
        if (sessionUser is String) {
          _localUser = ZoomVideoSdkUser.fromJson(
            Map<String, dynamic>.from(jsonDecode(sessionUser)),
          );
        } else if (sessionUser is Map) {
          _localUser = ZoomVideoSdkUser.fromJson(
            Map<String, dynamic>.from(sessionUser),
          );
        }
        _setPhase('Connected');
        _setState(CallState.connected);
        try {
          await _zoomService.setSpeaker(isOn: true);
        } catch (_) {}
        final remotes = await _zoomService.getRemoteUsers();
        _remoteUser = (remotes != null && remotes.isNotEmpty)
            ? remotes.first
            : null;
        await _syncLocalStatus();
      }),
    );

    _eventSubs.add(
      _zoomService.eventListener.addListener(EventType.onSessionLeave, (data) {
        debugPrint('[VideoCall] onSessionLeave: $data');
        _joinTimeoutTimer?.cancel();
        _remoteUser = null;
        _setPhase('Left session');
        _setState(CallState.ended);
      }),
    );

    _eventSubs.add(
      _zoomService.eventListener.addListener(EventType.onUserJoin, (data) {
        debugPrint('[VideoCall] onUserJoin: $data');
        final payload = _castMessage(data);
        final users = _decodeUsers(payload['remoteUsers']);
        _remoteUser = users.isNotEmpty ? users.first : _remoteUser;
        if (_state != CallState.connected) {
          _setState(CallState.connected);
        } else {
          notifyListeners();
        }
      }),
    );

    _eventSubs.add(
      _zoomService.eventListener.addListener(EventType.onUserLeave, (data) {
        debugPrint('[VideoCall] onUserLeave: $data');
        final payload = _castMessage(data);
        final users = _decodeUsers(payload['remoteUsers']);
        _remoteUser = users.isNotEmpty ? users.first : null;
        if (_remoteUser == null) {
          _setState(CallState.ended);
        } else {
          notifyListeners();
        }
      }),
    );

    _eventSubs.add(
      _zoomService.eventListener.addListener(
        EventType.onUserAudioStatusChanged,
        (data) async {
          debugPrint('[VideoCall] onUserAudioStatusChanged: $data');
          final payload = _castMessage(data);
          final users = _decodeUsers(payload['changedUsers']);
          if (_isLocalUserIn(users)) {
            await _syncLocalStatus();
          }
        },
      ),
    );

    _eventSubs.add(
      _zoomService.eventListener.addListener(
        EventType.onUserVideoStatusChanged,
        (data) async {
          debugPrint('[VideoCall] onUserVideoStatusChanged: $data');
          final payload = _castMessage(data);
          final users = _decodeUsers(payload['changedUsers']);
          if (_isLocalUserIn(users)) {
            await _syncLocalStatus();
          }
        },
      ),
    );

    _eventSubs.add(
      _zoomService.eventListener.addListener(EventType.onRequireSystemPermission, (
        data,
      ) {
        debugPrint('[VideoCall] onRequireSystemPermission: $data');
        final payload = _castMessage(data);
        final permissionType = payload['permissionType']?.toString();
        if (permissionType == SystemPermissionType.Camera) {
          _lastError =
              'Camera permission is required. Enable it in Settings and restart the call.';
        } else if (permissionType == SystemPermissionType.Microphone) {
          _lastError =
              'Microphone permission is required. Enable it in Settings and restart the call.';
        } else {
          _lastError = 'Required system permission missing.';
        }
        _setPhase('Permission required');
        _setState(CallState.failed);
      }),
    );

    _eventSubs.add(
      _zoomService.eventListener.addListener(EventType.onError, (data) {
        debugPrint('[VideoCall] onError: $data');
        _joinTimeoutTimer?.cancel();
        final payload = _castMessage(data);
        final errorType = payload['errorType']?.toString();
        final details = payload['details']?.toString();
        if (errorType != null && errorType.isNotEmpty) {
          _lastError = details == null
              ? errorType
              : '$errorType (details: $details)';
        } else if (_lastError == null) {
          _lastError = 'Zoom SDK error';
        }
        _setPhase('Failed');
        _setState(CallState.failed);
      }),
    );
  }

  Map<String, dynamic> _castMessage(dynamic data) {
    if (data is Map && data['message'] is Map) {
      return Map<String, dynamic>.from(data['message'] as Map);
    }
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    return <String, dynamic>{};
  }

  List<ZoomVideoSdkUser> _decodeUsers(dynamic raw) {
    if (raw == null) {
      return [];
    }
    if (raw is String) {
      if (raw.isEmpty) {
        return [];
      }
      final parsed = jsonDecode(raw);
      if (parsed is List) {
        return parsed
            .map(
              (item) =>
                  ZoomVideoSdkUser.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList();
      }
    }
    if (raw is List) {
      return raw
          .map(
            (item) =>
                ZoomVideoSdkUser.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList();
    }
    return [];
  }

  bool _isLocalUserIn(List<ZoomVideoSdkUser> users) {
    final localId = _localUser?.userId;
    if (localId == null) {
      return false;
    }
    return users.any((user) => user.userId == localId);
  }

  Future<void> _syncLocalStatus() async {
    final user = _localUser ?? await _zoomService.getMySelf();
    if (user == null) {
      return;
    }
    _localUser = user;
    _isMicMuted = await user.audioStatus?.isMuted() ?? _isMicMuted;
    final videoOn = await user.videoStatus?.isOn();
    if (videoOn != null) {
      _isCameraOff = !videoOn;
    }
    notifyListeners();
  }

  void _setState(CallState next) {
    _state = next;
    notifyListeners();
  }

  void _setPhase(String value) {
    _phase = value;
    notifyListeners();
  }
}
