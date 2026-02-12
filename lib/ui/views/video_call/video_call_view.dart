import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_videosdk/flutter_zoom_view.dart'
    as flutter_zoom_view;
import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_user.dart';
import 'package:stacked/stacked.dart';
import 'package:video_poc/models/call_state.dart';
import 'package:video_poc/ui/common/app_colors.dart';
import 'package:video_poc/ui/common/ui_helpers.dart';
import 'package:video_poc/ui/widgets/responsive/responsive_text.dart';

import 'video_call_viewmodel.dart';

class VideoCallView extends StatelessWidget {
  const VideoCallView({super.key, this.sessionName, this.userId});

  final String? sessionName;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideoCallViewModel>.reactive(
      viewModelBuilder: () => VideoCallViewModel(
        sessionName: sessionName ?? 'poc-session',
        userId: userId ?? 'user-a',
      ),
      onViewModelReady: (model) => model.startCall(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: _RemoteVideoView(
                  state: model.state,
                  user: model.remoteUser,
                ),
              ),
              Positioned(
                top: 16.sp,
                left: 16.sp,
                right: 16.sp,
                child: _CallStatusBanner(
                  state: model.state,
                  phase: model.phase,
                  lastError: model.lastError,
                  isBusy: model.isBusy,
                ),
              ),
              Positioned(
                top: 90.sp,
                right: 16.sp,
                child: _LocalVideoView(
                  state: model.state,
                  user: model.localUser,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 24.sp,
                child: _CallControls(
                  isMicMuted: model.isMicMuted,
                  isCameraOff: model.isCameraOff,
                  onToggleMic: model.toggleMic,
                  onToggleCamera: model.toggleCamera,
                  onSwitchCamera: model.switchCamera,
                  onEndCall: model.endCall,
                ),
              ),
              if (model.isBusy)
                Positioned(
                  left: 16.sp,
                  right: 16.sp,
                  bottom: 110.sp,
                  child: IgnorePointer(
                    ignoring: true,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.sp,
                        vertical: 10.sp,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        borderRadius: k12pxBorderRadius,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 16.sp,
                            height: 16.sp,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                          horizontalSpaceSmall,
                          const Expanded(
                            child: ResponsiveText.w400(
                              'Working...',
                              fontSize: 12,
                              color: Colors.white70,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CallStatusBanner extends StatelessWidget {
  const _CallStatusBanner({
    required this.state,
    required this.phase,
    required this.lastError,
    required this.isBusy,
  });

  final CallState state;
  final String phase;
  final String? lastError;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: k12pxBorderRadius,
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10.sp,
                height: 10.sp,
                decoration: BoxDecoration(
                  color: _stateColor(state),
                  shape: BoxShape.circle,
                ),
              ),
              horizontalSpaceSmall,
              ResponsiveText.w500(
                _stateLabel(state),
                fontSize: 14,
                color: Colors.white,
              ),
              if (isBusy) ...[
                horizontalSpaceSmall,
                SizedBox(
                  width: 12.sp,
                  height: 12.sp,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white70,
                  ),
                ),
              ],
            ],
          ),
          if (phase.isNotEmpty) ...[
            verticalSpaceTiny,
            ResponsiveText.w400(
              phase,
              fontSize: 12,
              color: Colors.white70,
              maxLines: 2,
            ),
          ],
          if (lastError != null && lastError!.isNotEmpty) ...[
            verticalSpaceTiny,
            ResponsiveText.w400(
              lastError!,
              fontSize: 12,
              color: Colors.white70,
              maxLines: 4,
            ),
          ],
        ],
      ),
    );
  }

  String _stateLabel(CallState state) {
    switch (state) {
      case CallState.idle:
        return 'Idle';
      case CallState.calling:
        return 'Calling...';
      case CallState.connected:
        return 'Connected';
      case CallState.ended:
        return 'Call Ended';
      case CallState.failed:
        return 'Call Failed';
    }
  }

  Color _stateColor(CallState state) {
    switch (state) {
      case CallState.connected:
        return Colors.greenAccent;
      case CallState.failed:
        return kFF3B30;
      case CallState.ended:
        return Colors.orangeAccent;
      case CallState.calling:
        return Colors.blueAccent;
      case CallState.idle:
        return Colors.grey;
    }
  }
}

class _RemoteVideoView extends StatelessWidget {
  const _RemoteVideoView({required this.state, required this.user});

  final CallState state;
  final ZoomVideoSdkUser? user;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return _VideoPlaceholder(label: 'Web not supported');
    }

    if (state == CallState.failed) {
      return _VideoPlaceholder(label: 'Call failed');
    }
    if (state == CallState.ended) {
      return _VideoPlaceholder(label: 'Call ended');
    }
    if (state != CallState.connected) {
      return _VideoPlaceholder(label: 'Connecting...');
    }

    if (user == null) {
      return _VideoPlaceholder(label: 'Waiting for participant...');
    }

    return flutter_zoom_view.View(
      key: ValueKey('remote-${user!.userId}'),
      creationParams: _zoomViewParams(
        userId: user!.userId,
        preview: false,
        fullScreen: true,
      ),
    );
  }
}

class _LocalVideoView extends StatelessWidget {
  const _LocalVideoView({required this.state, required this.user});

  final CallState state;
  final ZoomVideoSdkUser? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.sp,
      height: 160.sp,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: k12pxBorderRadius,
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      clipBehavior: Clip.hardEdge,
      child: (state == CallState.connected && user != null)
          ? _platformView(user!)
          : const _VideoPlaceholder(label: 'Local video'),
    );
  }

  Widget _platformView(ZoomVideoSdkUser user) {
    if (kIsWeb) {
      return const _VideoPlaceholder(label: 'Web not supported');
    }
    return flutter_zoom_view.View(
      key: ValueKey('local-${user.userId}'),
      creationParams: _zoomViewParams(
        userId: user.userId,
        preview: false,
        fullScreen: false,
      ),
    );
  }
}

Map<String, dynamic> _zoomViewParams({
  required String userId,
  required bool preview,
  required bool fullScreen,
}) {
  return <String, dynamic>{
    'userId': preview ? '' : userId,
    'sharing': false,
    'preview': preview,
    'focused': true,
    'hasMultiCamera': false,
    'isPiPView': false,
    'multiCameraIndex': '',
    'videoAspect': VideoAspect.PanAndScan,
    'aspect': VideoAspect.PanAndScan,
    'fullScreen': fullScreen,
    'resolution': VideoResolution.Resolution360,
  };
}

class _VideoPlaceholder extends StatelessWidget {
  const _VideoPlaceholder({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      alignment: Alignment.center,
      child: ResponsiveText.w400(label, fontSize: 12, color: Colors.white70),
    );
  }
}

class _CallControls extends StatelessWidget {
  const _CallControls({
    required this.isMicMuted,
    required this.isCameraOff,
    required this.onToggleMic,
    required this.onToggleCamera,
    required this.onSwitchCamera,
    required this.onEndCall,
  });

  final bool isMicMuted;
  final bool isCameraOff;
  final VoidCallback onToggleMic;
  final VoidCallback onToggleCamera;
  final VoidCallback onSwitchCamera;
  final VoidCallback onEndCall;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ControlButton(
          icon: isMicMuted ? Icons.mic_off : Icons.mic,
          label: isMicMuted ? 'Unmute' : 'Mute',
          onPressed: onToggleMic,
        ),
        horizontalSpaceMedium,
        _ControlButton(
          icon: isCameraOff ? Icons.videocam_off : Icons.videocam,
          label: isCameraOff ? 'Camera' : 'Camera',
          onPressed: onToggleCamera,
        ),
        horizontalSpaceMedium,
        _ControlButton(
          icon: Icons.cameraswitch,
          label: 'Switch',
          onPressed: onSwitchCamera,
        ),
        horizontalSpaceMedium,
        _ControlButton(
          icon: Icons.call_end,
          label: 'End',
          color: kFF3B30,
          onPressed: onEndCall,
        ),
      ],
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? Colors.white;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 56.sp,
            height: 56.sp,
            decoration: BoxDecoration(
              color: buttonColor.withOpacity(0.95),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color == null ? k4D4D4D : Colors.white,
              size: 28.sp,
            ),
          ),
        ),
        verticalSpaceTiny,
        ResponsiveText.w400(label, fontSize: 11, color: Colors.white70),
      ],
    );
  }
}
