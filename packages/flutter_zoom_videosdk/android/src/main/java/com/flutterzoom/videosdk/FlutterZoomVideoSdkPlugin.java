package com.flutterzoom.videosdk;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.hardware.display.DisplayManager;
import android.net.Uri;
import android.util.Base64;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.Display;

import androidx.annotation.NonNull;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkCRCCallStatus;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkChatPrivilegeType;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkDataType;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkErrors;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkExportFormat;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkLiveStreamStatus;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkLiveTranscriptionStatus;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkMultiCameraStreamStatus;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkNetworkStatus;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkPhoneFailedReason;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkPhoneStatus;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkPreferVideoResolution;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkRawDataMemoryMode;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkRecordingConsentType;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkRecordingStatus;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkSessionLeaveReason;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkSubSessionStatus;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkTestMicStatus;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkUVCCameraStatus;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkUserHelpRequestResult;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkVideoSubscribeFailReason;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkWhiteboardStatus;
import com.flutterzoom.videosdk.convert.FlutterZoomVideosSdkChatMessageDeleteType;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import us.zoom.sdk.IncomingLiveStreamStatus;
import us.zoom.sdk.RealTimeMediaStreamsFailReason;
import us.zoom.sdk.RealTimeMediaStreamsStatus;
import us.zoom.sdk.UVCCameraStatus;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKAnnotationHelper;
import us.zoom.sdk.ZoomVideoSDKAudioHelper;
import us.zoom.sdk.ZoomVideoSDKAudioOption;
import us.zoom.sdk.ZoomVideoSDKAudioRawData;
import us.zoom.sdk.ZoomVideoSDKBroadcastControlStatus;
import us.zoom.sdk.ZoomVideoSDKCRCCallStatus;
import us.zoom.sdk.ZoomVideoSDKCameraControlRequestHandler;
import us.zoom.sdk.ZoomVideoSDKCameraControlRequestType;
import us.zoom.sdk.ZoomVideoSDKChatHelper;
import us.zoom.sdk.ZoomVideoSDKChatMessage;
import us.zoom.sdk.ZoomVideoSDKChatMessageDeleteType;
import us.zoom.sdk.ZoomVideoSDKChatPrivilegeType;
import us.zoom.sdk.ZoomVideoSDKDataType;
import us.zoom.sdk.ZoomVideoSDKDelegate;
import us.zoom.sdk.ZoomVideoSDKErrors;
import us.zoom.sdk.ZoomVideoSDKExportFormat;
import us.zoom.sdk.ZoomVideoSDKExtendParams;
import us.zoom.sdk.ZoomVideoSDKFileTransferStatus;
import us.zoom.sdk.ZoomVideoSDKInitParams;
import us.zoom.sdk.ZoomVideoSDKLiveStreamHelper;
import us.zoom.sdk.ZoomVideoSDKLiveStreamStatus;
import us.zoom.sdk.ZoomVideoSDKLiveTranscriptionHelper;
import us.zoom.sdk.ZoomVideoSDKMultiCameraStreamStatus;
import us.zoom.sdk.ZoomVideoSDKNetworkStatus;
import us.zoom.sdk.ZoomVideoSDKPasswordHandler;
import us.zoom.sdk.ZoomVideoSDKPhoneFailedReason;
import us.zoom.sdk.ZoomVideoSDKPhoneStatus;
import us.zoom.sdk.ZoomVideoSDKProxySettingHandler;
import us.zoom.sdk.ZoomVideoSDKRawDataPipe;
import us.zoom.sdk.ZoomVideoSDKReceiveFile;
import us.zoom.sdk.ZoomVideoSDKRecordingConsentHandler;
import us.zoom.sdk.ZoomVideoSDKRecordingConsentHandler.ConsentType;
import us.zoom.sdk.ZoomVideoSDKRecordingStatus;
import us.zoom.sdk.ZoomVideoSDKSSLCertificateInfo;
import us.zoom.sdk.ZoomVideoSDKSendFile;
import us.zoom.sdk.ZoomVideoSDKSession;
import us.zoom.sdk.ZoomVideoSDKSessionContext;
import us.zoom.sdk.ZoomVideoSDKSessionLeaveReason;
import us.zoom.sdk.ZoomVideoSDKShareAction;
import us.zoom.sdk.ZoomVideoSDKShareHelper;
import us.zoom.sdk.ZoomVideoSDKShareStatus;
import us.zoom.sdk.ZoomVideoSDKStreamingJoinStatus;
import us.zoom.sdk.ZoomVideoSDKTestMicStatus;
import us.zoom.sdk.ZoomVideoSDKUser;
import us.zoom.sdk.ZoomVideoSDKUserHelper;
import us.zoom.sdk.ZoomVideoSDKVideoCanvas;
import us.zoom.sdk.ZoomVideoSDKVideoHelper;
import us.zoom.sdk.ZoomVideoSDKVideoOption;
import us.zoom.sdk.ZoomVideoSDKVideoSubscribeFailReason;
import us.zoom.sdk.ZoomVideoSDKVideoView;
import us.zoom.sdk.ZoomVideoSDKUserHelpRequestResult;
import us.zoom.sdk.SubSessionUserHelpRequestHandler;
import us.zoom.sdk.SubSessionKit;
import us.zoom.sdk.ZoomVideoSDKSubSessionParticipant;
import us.zoom.sdk.ZoomVideoSDKSubSessionManager;
import us.zoom.sdk.ZoomVideoSDKSubSessionStatus;
import us.zoom.sdk.ZoomVideoSDKShareSetting;
import us.zoom.sdk.ZoomVideoSDKWhiteboardHelper;
import us.zoom.sdk.ZoomVideoSDKVideoView;
import us.zoom.sdk.ZoomVideoSDKAnnotationToolType;

/** FlutterZoomVideoSdkPlugin */
public class FlutterZoomVideoSdkPlugin implements FlutterPlugin, MethodCallHandler, ZoomVideoSDKDelegate, ActivityAware, EventChannel.StreamHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  Activity activity;
  protected final String DEBUG_TAG = "ZoomVideoSdkDebug";
  protected Display display;
  protected DisplayMetrics displayMetrics;
  private Result pendingResult;
  private EventChannel.EventSink eventSink;

  protected MethodChannel methodChannel;
  public Context context;
  private ZoomVideoSDKRecordingConsentHandler recordingConsentHandler;
  EventChannel eventListener;

  FlutterZoomVideoSdkAudioHelper audioHelper;
  FlutterZoomVideoSdkAudioSettingHelper audioSettingHelper;
  FlutterZoomVideoSdkAudioStatus audioStatus;
  FlutterZoomVideoSdkChatHelper chatHelper;
  FlutterZoomVideoSdkCmdChannel cmdChannel;
  FlutterZoomVideoSdkLiveStreamHelper liveStreamHelper;
  FlutterZoomVideoSdkLiveTranscriptionHelper liveTranscriptionHelper;
  FlutterZoomVideoSdkPhoneHelper phoneHelper;
  FlutterZoomVideoSdkRecordingHelper recordingHelper;
  FlutterZoomVideoSdkTestAudioDeviceHelper testAudioDeviceHelper;
  FlutterZoomVideoSdkShareHelper shareHelper;
  FlutterZoomVideoSdkWhiteboardHelper whiteboardHelper;
  FlutterZoomVideoSdkShareStatisticInfo shareStatisticInfo;
  FlutterZoomVideoSdkSession session;
  FlutterZoomVideoSdkSessionStatisticsInfo sessionStatisticsInfo;
  FlutterZoomVideoSdkUser user;
  FlutterZoomVideoSdkUserHelper userHelper;
  FlutterZoomVideoSdkVideoHelper videoHelper;
  FlutterZoomVideoSdkVideoStatisticInfo videoStatisticInfo;
  FlutterZoomVideoSdkVideoStatus videoStatus;
  FlutterZoomVideoSdkRemoteCameraControlHelper remoteCameraControlHelper;
  FlutterZoomVideoSdkVirtualBackgroundHelper virtualBackgroundHelper;
  FlutterZoomVideoSdkCRCHelper CRCHelper;
  FlutterZoomVideoSdkAnnotationHelper annotationHelper;
  FlutterZoomVideoSdkSubSessionHelper subSessionHelper;


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    context = binding.getApplicationContext();
    DisplayManager dm = (DisplayManager) context.getSystemService(Context.DISPLAY_SERVICE);
    display = dm.getDisplay(Display.DEFAULT_DISPLAY);
    methodChannel = new MethodChannel(binding.getBinaryMessenger(), "flutter_zoom_videosdk");
    methodChannel.setMethodCallHandler(this);
    binding.getPlatformViewRegistry().registerViewFactory("flutter_zoom_videosdk_view", new FlutterZoomVideoSdkViewFactory());
    binding.getPlatformViewRegistry().registerViewFactory("flutter_zoom_videosdk_camera_share_view", new FlutterZoomVideoSdkCameraShareViewFactory());
    eventListener = new EventChannel(binding.getBinaryMessenger(),"eventListener");
    eventListener.setStreamHandler(this);

  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "initSdk":
        initSdk(call, result);
        break;
      case "joinSession":
        joinSession(call, result);
        break;
      case "leaveSession":
        leaveSession(call, result);
        break;
      case "getSdkVersion":
        getSdkVersion(result);
        break;
      case "acceptRecordingConsent":
        acceptRecordingConsent(result);
        break;
      case "declineRecordingConsent":
        declineRecordingConsent(result);
        break;
      case "getRecordingConsentType":
        getRecordingConsentType(result);
        break;
      case "cleanup":
        cleanup(result);
        break;
      case "exportLog":
        exportLog(result);
        break;
      case "cleanAllExportedLogs":
        cleanAllExportedLogs(result);
        break;
      case "canSwitchSpeaker":
        audioHelper.canSwitchSpeaker(result);
        break;
      case "getSpeakerStatus":
        audioHelper.getSpeakerStatus(result);
        break;
      case "muteAudio":
        audioHelper.muteAudio(call,result);
        break;
      case "unMuteAudio":
        audioHelper.unmuteAudio(call,result);
        break;
      case "muteAllAudio":
        audioHelper.muteAllAudio(call,result);
        break;
      case "unmuteAllAudio":
        audioHelper.unmuteAllAudio(result);
        break;
      case "allowAudioUnmutedBySelf":
        audioHelper.allowAudioUnmutedBySelf(call, result);
        break;
      case "setSpeaker":
        audioHelper.setSpeaker(call,result);
        break;
      case "startAudio":
        audioHelper.startAudio(result);
        break;
      case "stopAudio":
        audioHelper.stopAudio(result);
        break;
      case "subscribe":
        audioHelper.subscribe(result);
        break;
      case "unSubscribe":
        audioHelper.unsubscribe(result);
        break;
      case "resetAudioSession":
        audioHelper.resetAudioSession(result);
        break;
      case "cleanAudioSession":
        audioHelper.cleanAudioSession(result);
        break;
      case "getAudioDeviceList":
        audioHelper.getAudioDeviceList(result);
        break;
      case "getUsingAudioDevice":
        audioHelper.getUsingAudioDevice(result);
        break;
      case "switchToAudioSourceType":
        audioHelper.switchToAudioSourceType(call, result);
        break;
      case "isMicOriginalInputEnable":
        audioSettingHelper.isMicOriginalInputEnable(result);
        break;
      case "enableAutoAdjustMicVolume":
        audioSettingHelper.enableAutoAdjustMicVolume(call, result);
        break;
      case "enableMicOriginalInput":
        audioSettingHelper.enableMicOriginalInput(call, result);
        break;
      case "isAutoAdjustMicVolumeEnabled":
        audioSettingHelper.isAutoAdjustMicVolumeEnabled(result);
        break;
      case "isMuted":
        audioStatus.isMuted(call, result);
        break;
      case "isTalking":
        audioStatus.isTalking(call, result);
        break;
      case "getAudioType":
        audioStatus.getAudioType(call, result);
        break;
      case "isChatDisabled":
        chatHelper.isChatDisabled(result);
        break;
      case "isPrivateChatDisabled":
        chatHelper.isPrivateChatDisabled(result);
        break;
      case "sendChatToUser":
        chatHelper.sendChatToUser(call, result);
        break;
      case "sendChatToAll":
        chatHelper.sendChatToAll(call, result);
        break;
      case "deleteChatMessage":
        chatHelper.deleteChatMessage(call, result);
        break;
      case "canChatMessageBeDeleted":
        chatHelper.canChatMessageBeDeleted(call, result);
        break;
      case "changeChatPrivilege":
        chatHelper.changeChatPrivilege(call, result);
        break;
      case "getChatPrivilege":
        chatHelper.getChatPrivilege(result);
        break;
      case "sendCommand":
        cmdChannel.sendCommand(call, result);
        break;
      case "canStartLiveStream":
        liveStreamHelper.canStartLiveStream(result);
        break;
      case "startLiveStream":
        liveStreamHelper.startLiveStream(call, result);
        break;
      case "stopLiveStream":
        liveStreamHelper.stopLiveStream(result);
        break;
      case "canStartLiveTranscription":
        liveTranscriptionHelper.canStartLiveTranscription(result);
        break;
      case "getLiveTranscriptionStatus":
        liveTranscriptionHelper.getLiveTranscriptionStatus(result);
        break;
      case "startLiveTranscription":
        liveTranscriptionHelper.startLiveTranscription(result);
        break;
      case "stopLiveTranscription":
        liveTranscriptionHelper.stopLiveTranscription(result);
        break;
      case "getAvailableSpokenLanguages":
        liveTranscriptionHelper.getAvailableSpokenLanguages(result);
        break;
      case "setSpokenLanguage":
        liveTranscriptionHelper.setSpokenLanguage(call, result);
        break;
      case "getSpokenLanguage":
        liveTranscriptionHelper.getSpokenLanguage(result);
        break;
      case "getAvailableTranslationLanguages":
        liveTranscriptionHelper.getAvailableTranslationLanguages(result);
        break;
      case "setTranslationLanguage":
        liveTranscriptionHelper.setTranslationLanguage(call, result);
        break;
      case "getTranslationLanguage":
        liveTranscriptionHelper.getTranslationLanguage(result);
        break;
      case "isReceiveSpokenLanguageContentEnabled":
        liveTranscriptionHelper.isReceiveSpokenLanguageContentEnabled(result);
        break;
      case "enableReceiveSpokenLanguageContent":
        liveTranscriptionHelper.enableReceiveSpokenLanguageContent(call, result);
        break;
      case "isAllowViewHistoryTranslationMessageEnabled":
        liveTranscriptionHelper.isAllowViewHistoryTranslationMessageEnabled(result);
        break;
      case "getHistoryTranslationMessageList":
        liveTranscriptionHelper.getHistoryTranslationMessageList(result);
        break;
      case "cancelInviteByPhone":
        phoneHelper.cancelInviteByPhone(result);
        break;
      case "getInviteByPhoneStatus":
        phoneHelper.getInviteByPhoneStatus(result);
        break;
      case "getSupportCountryInfo":
        phoneHelper.getSupportCountryInfo(result);
        break;
      case "inviteByPhone":
        phoneHelper.inviteByPhone(call, result);
        break;
      case "isSupportPhoneFeature":
        phoneHelper.isSupportPhoneFeature(result);
        break;
      case "getSessionDialInNumbers":
        phoneHelper.getSessionDialInNumbers(result);
        break;
      case "canStartRecording":
        recordingHelper.canStartRecording(result);
        break;
      case "startCloudRecording":
        recordingHelper.startCloudRecording(result);
        break;
      case "stopCloudRecording":
        recordingHelper.stopCloudRecording(result);
        break;
      case "pauseCloudRecording":
        recordingHelper.pauseCloudRecording(result);
        break;
      case "resumeCloudRecording":
        recordingHelper.resumeCloudRecording(result);
        break;
      case "getCloudRecordingStatus":
        recordingHelper.getCloudRecordingStatus(result);
        break;
      case "getMySelf":
        session.getMySelf(result);
        break;
      case "getRemoteUsers":
        session.getRemoteUsers(result);
        break;
      case "getSessionHost":
        session.getSessionHost(result);
        break;
      case "getSessionHostName":
        session.getSessionHostName(result);
        break;
      case "getSessionName":
        session.getSessionName(result);
        break;
      case "getSessionID":
        session.getSessionID(result);
        break;
      case "getSessionPassword":
        session.getSessionPassword(result);
        break;
      case "getSessionNumber":
        session.getSessionNumber(result);
        break;
      case "getSessionPhonePasscode":
        session.getSessionPhonePasscode(result);
        break;
      case "getAudioStatisticsInfo":
        sessionStatisticsInfo.getAudioStatisticsInfo(result);
        break;
      case "getVideoStatisticsInfo":
        sessionStatisticsInfo.getVideoStatisticsInfo(result);
        break;
      case "getShareStatisticsInfo":
        sessionStatisticsInfo.getShareStatisticsInfo(result);
        break;
      case "shareScreen":
        try {
          shareHelper.shareScreen();
        } catch (Exception e) {
          e.printStackTrace();
        }
        break;
      case "shareView":
        break;
      case "lockShare":
        shareHelper.lockShare(call, result);
        break;
      case "stopShare":
        shareHelper.stopShare(result);
        break;
      case "isOtherSharing":
        shareHelper.isOtherSharing(result);
        break;
      case "isScreenSharingOut":
        shareHelper.isScreenSharingOut(result);
        break;
      case "isShareLocked":
        shareHelper.isShareLocked(result);
        break;
      case "isSharingOut":
        shareHelper.isSharingOut(result);
        break;
      case "isAnnotationFeatureSupport":
        shareHelper.isAnnotationFeatureSupport(result);
        break;
      case "disableViewerAnnotation":
        shareHelper.disableViewerAnnotation(call, result);
        break;
      case "isViewerAnnotationDisabled":
        shareHelper.isViewerAnnotationDisabled(result);
        break;
      case "pauseShare":
        shareHelper.pauseShare(result);
        break;
      case "resumeShare":
        shareHelper.resumeShare(result);
        break;
      case "startShareCamera":
        shareHelper.startShareCamera(result);
        break;
      case "setAnnotationVanishingToolTime":
        shareHelper.setAnnotationVanishingToolTime(call, result);
        break;
      case "getAnnotationVanishingToolDisplayTime":
        shareHelper.getAnnotationVanishingToolDisplayTime(result);
        break;
      case "getAnnotationVanishingToolVanishingTime":
        shareHelper.getAnnotationVanishingToolVanishingTime(result);
        break;
      case "getUserShareBpf":
        shareStatisticInfo.getUserShareBpf(call, result);
        break;
      case "getUserShareFps":
        shareStatisticInfo.getUserShareFps(call, result);
        break;
      case "getUserShareHeight":
        shareStatisticInfo.getUserShareHeight(call, result);
        break;
      case "getUserShareWidth":
        shareStatisticInfo.getUserShareWidth(call, result);
        break;
      case "startMicTest":
        testAudioDeviceHelper.startMicTest(result);
        break;
      case "stopMicTest":
        testAudioDeviceHelper.stopMicTest(result);
        break;
      case "playMicTest":
        testAudioDeviceHelper.playMicTest(result);
        break;
      case "startSpeakerTest":
        testAudioDeviceHelper.startSpeakerTest(result);
        break;
      case "stopSpeakerTest":
        testAudioDeviceHelper.stopSpeakerTest(result);
        break;
      case "changeName":
        userHelper.changeName(call, result);
        break;
      case "makeHost":
        userHelper.makeHost(call, result);
        break;
      case "makeManager":
        userHelper.makeManager(call, result);
        break;
      case "revokeManager":
        userHelper.revokeManager(call, result);
        break;
      case "removeUser":
        userHelper.removeUser(call, result);
        break;
      case "getUserName":
        user.getUserName(call, result);
        break;
      case "getShareActionList":
        user.getShareActionList(call, result);
        break;
      case "isHost":
        user.isHost(call, result);
        break;
      case "isManager":
        user.isManager(call, result);
        break;
      case "isVideoSpotLighted":
        user.isVideoSpotLighted(call, result);
        break;
      case "getMultiCameraCanvasList":
        user.getMultiCameraCanvasList(call, result);
        break;
      case "hasIndividualRecordingConsent":
        user.hasIndividualRecordingConsent(call, result);
        break;
      case "setUserVolume":
        user.setUserVolume(call, result);
        break;
      case "getUserVolume":
        user.getUserVolume(call, result);
        break;
      case "canSetUserVolume":
        user.canSetUserVolume(call, result);
        break;
      case "getUserReference":
        user.getUserGUID(call, result);
        break;
      case "getNetworkLevel":
        user.getNetworkLevel(call, result);
        break;
      case "getOverallNetworkLevel":
        user.getOverallNetworkLevel(call, result);
        break;
      case "getNumberOfCameras":
        videoHelper.getNumberOfCameras(result);
        break;
      case "rotateMyVideo":
        videoHelper.rotateMyVideo(call, result);
        break;
      case "startVideo":
        videoHelper.startVideo(result);
        break;
      case "stopVideo":
        videoHelper.stopVideo(result);
        break;
      case "switchCamera":
        videoHelper.switchCamera(call, result);
        break;
      case "getCameraList":
        videoHelper.getCameraList(result);
        break;
      case "mirrorMyVideo":
        videoHelper.mirrorMyVideo(call, result);
        break;
      case "isMyVideoMirrored":
        videoHelper.isMyVideoMirrored(result);
        break;
      case "enableOriginalAspectRatio":
        videoHelper.enableOriginalAspectRatio(call, result);
        break;
      case "turnOnOrOffFlashlight":
        videoHelper.turnOnOrOffFlashlight(call, result);
        break;
      case "isSupportFlashlight":
        videoHelper.isSupportFlashlight(result);
        break;
      case "isFlashlightOn":
        videoHelper.isFlashlightOn(result);
        break;
      case "isOriginalAspectRatioEnabled":
        videoHelper.isOriginalAspectRatioEnabled(result);
        break;
      case "spotLightVideo":
        videoHelper.spotLightVideo(call, result);
        break;
      case "unSpotLightVideo":
        videoHelper.unSpotLightVideo(call, result);
        break;
      case "unSpotlightAllVideos":
        videoHelper.unSpotlightAllVideos(result);
        break;
      case "getSpotlightedVideoUserList":
        videoHelper.getSpotlightedVideoUserList(result);
        break;
      case "getUserVideoBpf":
        videoStatisticInfo.getUserVideoBpf(call, result);
        break;
      case "getUserVideoFps":
        videoStatisticInfo.getUserVideoFps(call, result);
        break;
      case "getUserVideoHeight":
        videoStatisticInfo.getUserVideoHeight(call, result);
        break;
      case "getUserVideoWidth":
        videoStatisticInfo.getUserVideoWidth(call, result);
        break;
      case "isOn":
        videoStatus.isOn(call, result);
        break;
      case "hasVideoDevice":
        videoStatus.hasVideoDevice(call, result);
        break;
      case "openBrowser":
        openBrowser(call, result);
        break;
      case "giveUpControlRemoteCamera":
        remoteCameraControlHelper.giveUpControlRemoteCamera(call, result);
        break;
      case "requestControlRemoteCamera":
        remoteCameraControlHelper.requestControlRemoteCamera(call, result);
        break;
      case "turnUp":
        remoteCameraControlHelper.turnUp(call, result);
        break;
      case "turnDown":
        remoteCameraControlHelper.turnDown(call, result);
        break;
      case "turnRight":
        remoteCameraControlHelper.turnRight(call, result);
        break;
      case "turnLeft":
        remoteCameraControlHelper.turnLeft(call, result);
        break;
      case "zoomIn":
        remoteCameraControlHelper.zoomIn(call, result);
        break;
      case "zoomOut":
        remoteCameraControlHelper.zoomOut(call, result);
      case "isSupportVirtualBackground":
        virtualBackgroundHelper.isSupportVirtualBackground(result);
        break;
      case "addVirtualBackgroundItem":
        virtualBackgroundHelper.addVirtualBackgroundItem(call, result);
        break;
      case "removeVirtualBackgroundItem":
        virtualBackgroundHelper.removeVirtualBackgroundItem(call, result);
        break;
      case "setVirtualBackgroundItem":
        virtualBackgroundHelper.setVirtualBackgroundItem(call, result);
        break;
      case "getSelectedVirtualBackgroundItem":
        virtualBackgroundHelper.getSelectedVirtualBackgroundItem(result);
        break;
      case "isCRCEnabled":
        CRCHelper.isCRCEnabled(result);
        break;
      case "callCRCDevice":
        CRCHelper.callCRCDevice(call, result);
        break;
      case "cancelCallCRCDevice":
        CRCHelper.cancelCallCRCDevice(result);
        break;
      case "getSessionSIPAddress":
        CRCHelper.getSessionSIPAddress(result);
        break;
      case "isSenderDisableAnnotation":
        annotationHelper.isSenderDisableAnnotation(result);
        break;
      case "canDoAnnotation":
        annotationHelper.canDoAnnotation(result);
        break;
      case "startAnnotation":
        annotationHelper.startAnnotation(result);
        break;
      case "stopAnnotation":
        annotationHelper.stopAnnotation(result);
        break;
      case "setToolColor":
        annotationHelper.setToolColor(call, result);
        break;
      case "getToolColor":
        annotationHelper.getToolColor(result);
        break;
      case "setToolType":
        annotationHelper.setToolType(call, result);
        break;
      case "getToolType":
        annotationHelper.getToolType(result);
        break;
      case "setToolWidth":
        annotationHelper.setToolWidth(call, result);
        break;
      case "getToolWidth":
        annotationHelper.getToolWidth(result);
        break;
      case "undo":
        annotationHelper.undo(result);
        break;
      case "redo":
        annotationHelper.redo(result);
        break;
      case "clear":
        annotationHelper.clear(call, result);
        break;
      case "canStartShareWhiteboard":
        whiteboardHelper.canStartShareWhiteboard(result);
        break;
      case "canStopShareWhiteboard":
        whiteboardHelper.canStopShareWhiteboard(result);
        break;
      case "startShareWhiteboard":
        whiteboardHelper.startShareWhiteboard(result);
        break;
      case "stopShareWhiteboard":
        whiteboardHelper.stopShareWhiteboard(result);
        break;
      case "isOtherSharingWhiteboard":
        whiteboardHelper.isOtherSharingWhiteboard(result);
        break;
      case "exportWhiteboard":
        whiteboardHelper.exportWhiteboard(call, result);
        break;
      case "subscribeWhiteboard":
        whiteboardHelper.subscribeWhiteboard(call, result);
        break;
      case "unSubscribeWhiteboard":
        whiteboardHelper.unSubscribeWhiteboard(result);
        break;
      case "joinSubSession":
        subSessionHelper.joinSubSession(call, result);
        break;
      case "startSubSession":
        subSessionHelper.startSubSession(result);
        break;
      case "isSubSessionStarted":
        subSessionHelper.isSubSessionStarted(result);
        break;
      case "stopSubSession":
        subSessionHelper.stopSubSession(result);
        break;
      case "broadcastMessage":
        subSessionHelper.broadcastMessage(call, result);
        break;
      case "returnToMainSession":
        subSessionHelper.returnToMainSession(result);
        break;
      case "requestForHelp":
        subSessionHelper.requestForHelp(result);
        break;
      case "getRequestUserName":
        subSessionHelper.getRequestUserName(result);
        break;
      case "getRequestSubSessionName":
        subSessionHelper.getRequestSubSessionName(result);
        break;
      case "ignoreUserHelpRequest":
        subSessionHelper.ignoreUserHelpRequest(result);
        break;
      case "joinSubSessionByUserRequest":
        subSessionHelper.joinSubSessionByUserRequest(result);
        break;
      case "commitSubSessionList":
        subSessionHelper.commitSubSessionList(call, result);
        break;
      case "getCommittedSubSessionList":
        subSessionHelper.getCommittedSubSessionList(result);
        break;
      case "withdrawSubSessionList":
        subSessionHelper.withdrawSubSessionList(result);
        break;
      default:
        result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    methodChannel.setMethodCallHandler(null);
    eventListener.setStreamHandler(null);
    ZoomVideoSDK.getInstance().removeListener(this);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    this.activity = binding.getActivity();
    audioHelper = new FlutterZoomVideoSdkAudioHelper(activity);
    audioSettingHelper = new FlutterZoomVideoSdkAudioSettingHelper(activity);
    audioStatus = new FlutterZoomVideoSdkAudioStatus();
    chatHelper = new FlutterZoomVideoSdkChatHelper(activity);
    cmdChannel = new FlutterZoomVideoSdkCmdChannel(activity);
    liveStreamHelper = new FlutterZoomVideoSdkLiveStreamHelper(activity);
    liveTranscriptionHelper = new FlutterZoomVideoSdkLiveTranscriptionHelper(activity);
    phoneHelper = new FlutterZoomVideoSdkPhoneHelper(activity);
    recordingHelper = new FlutterZoomVideoSdkRecordingHelper(activity);
    session = new FlutterZoomVideoSdkSession();
    sessionStatisticsInfo = new FlutterZoomVideoSdkSessionStatisticsInfo();
    shareHelper = new FlutterZoomVideoSdkShareHelper(activity, context);
    whiteboardHelper = new FlutterZoomVideoSdkWhiteboardHelper(activity);
    shareStatisticInfo = new FlutterZoomVideoSdkShareStatisticInfo();
    user = new FlutterZoomVideoSdkUser();
    userHelper = new FlutterZoomVideoSdkUserHelper(activity);
    testAudioDeviceHelper = new FlutterZoomVideoSdkTestAudioDeviceHelper(activity);
    videoHelper = new FlutterZoomVideoSdkVideoHelper(activity);
    videoStatisticInfo = new FlutterZoomVideoSdkVideoStatisticInfo();
    videoStatus = new FlutterZoomVideoSdkVideoStatus();
    remoteCameraControlHelper = new FlutterZoomVideoSdkRemoteCameraControlHelper(activity);
    virtualBackgroundHelper = new FlutterZoomVideoSdkVirtualBackgroundHelper(activity);
    CRCHelper = new FlutterZoomVideoSdkCRCHelper(activity);
    annotationHelper = FlutterZoomVideoSdkAnnotationHelper.createInstance(activity);
    subSessionHelper = new FlutterZoomVideoSdkSubSessionHelper(activity);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    this.activity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    this.activity = binding.getActivity();

  }

  @Override
  public void onDetachedFromActivity() {
    this.activity = null;
    ZoomVideoSDK.getInstance().removeListener(this);
  }

  void initSdk(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
    Map<String, Object> config = call.arguments();

    ZoomVideoSDKInitParams params = new ZoomVideoSDKInitParams();

    params.domain = (String) config.get("domain");
    params.enableLog = (Boolean) config.get("enableLog");

    if (config.get("logFilePrefix") != null) {
      params.logFilePrefix = (String) config.get("logFilePrefix");
    }

    if (config.get("enableFullHD") != null) {
      params.enableFullHD = (Boolean) config.get("enableFullHD");
    }

    params.videoRawDataMemoryMode = FlutterZoomVideoSdkRawDataMemoryMode.valueOf((String) config.get("videoRawDataMemoryMode"));
    params.audioRawDataMemoryMode = FlutterZoomVideoSdkRawDataMemoryMode.valueOf((String) config.get("audioRawDataMemoryMode"));
    params.shareRawDataMemoryMode = FlutterZoomVideoSdkRawDataMemoryMode.valueOf((String) config.get("shareRawDataMemoryMode"));
    ZoomVideoSDKExtendParams extendParams = new ZoomVideoSDKExtendParams();
    extendParams.wrapperType = 1;

    if (config.containsKey("speakerFilePath")) {
      String speakerFilePath = (String) config.get("speakerFilePath");
      extendParams.speakerTestFilePath = speakerFilePath;
    }
    if (config.containsKey("preferVideoResolution")) {
      String preferVideoResolution = (String) config.get("preferVideoResolution");
      extendParams.preferVideoResolution = FlutterZoomVideoSdkPreferVideoResolution.valueOf(preferVideoResolution);
    }
    params.extendParam = extendParams;

    ZoomVideoSDK sdk = ZoomVideoSDK.getInstance();
    int initResult = sdk.initialize(context, params);

    switch (initResult) {
      case ZoomVideoSDKErrors.Errors_Success:
        Log.d(DEBUG_TAG, "SDK initialized successfully");
        result.success("SDK initialized successfully");
        break;
      default:
        Log.d(DEBUG_TAG, String.format("SDK failed to initialize with error code: %d", initResult));
        result.error("sdkinit_failed", "Init SDK Failed", null);
        break;
    }

    refreshRotation();

  }

  void joinSession(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {

    Map<String, Object> config = call.arguments();

    if (config == null) {
      result.error("joinSession_failure", "Join Session failed", null);
    }
    ZoomVideoSDKVideoOption videoOption = new ZoomVideoSDKVideoOption();
    if (config.containsKey("videoOptions")) {
      Map<String, Boolean> videoOptionConfig = (Map) config.get("videoOptions");
      videoOption.localVideoOn = Boolean.TRUE.equals(videoOptionConfig.get("localVideoOn"));
    }
    ZoomVideoSDKAudioOption audioOption = new ZoomVideoSDKAudioOption();
    if (config.containsKey("audioOptions")) {
      Map<String, Boolean> audioOptionConfig = (Map) config.get("audioOptions");
      audioOption.connect = Boolean.TRUE.equals(audioOptionConfig.get("connect"));
      audioOption.mute = Boolean.TRUE.equals(audioOptionConfig.get("mute"));
      audioOption.autoAdjustSpeakerVolume = Boolean.TRUE.equals(audioOptionConfig.get("autoAdjustSpeakerVolume"));
    }

    ZoomVideoSDKSessionContext sessionContext = new ZoomVideoSDKSessionContext();
    sessionContext.sessionName = (String) config.get("sessionName");
    sessionContext.userName = ((config.get("userName") == null) ? "zoom_user" : (String) config.get("userName"));
    sessionContext.token = (String) config.get("token");
    sessionContext.sessionPassword = ((config.get("sessionPassword") == null) ? "" : (String) config.get("sessionPassword"));
    sessionContext.audioOption = audioOption;
    sessionContext.videoOption = videoOption;
    sessionContext.sessionIdleTimeoutMins = ((config.get("sessionIdleTimeoutMins") == null) ? 40 : (Integer) config.get("sessionIdleTimeoutMins"));

    ZoomVideoSDK.getInstance().addListener(this);

    try {
      ZoomVideoSDKSession session = ZoomVideoSDK.getInstance().joinSession(sessionContext);
      result.success("Join Session Success");
      Log.d(DEBUG_TAG, "Join Session successfully");
    } catch (Exception e) {
      result.error("joinSession_failure", "Join Session failed", null);
    }

  }

  void leaveSession(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
    Map<String, Object> params = call.arguments();
    boolean shouldEndSession = Boolean.TRUE.equals(params.get("endSession"));
    int error = ZoomVideoSDK.getInstance().leaveSession(shouldEndSession);
    result.success(FlutterZoomVideoSdkErrors.valueOf(error));
  }

  void getSdkVersion(@NonNull MethodChannel.Result result) {
    result.success(ZoomVideoSDK.getInstance().getSDKVersion());
  }

  void openBrowser(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
    Map<String, Object> params = call.arguments();
    String url = (String) params.get("url");
    Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
    browserIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    context.startActivity(browserIntent);
  }

  void cleanup(@NonNull MethodChannel.Result result) {
    int ret = ZoomVideoSDK.getInstance().cleanup();

    switch (ret) {
      case ZoomVideoSDKErrors.Errors_Success:
        Log.d(DEBUG_TAG, "SDK cleanup successfully");
        break;
      default:
        Log.d(DEBUG_TAG, String.format("SDK failed to cleanup with error code: %lu", ret));
        break;
    }
    result.success(FlutterZoomVideoSdkErrors.valueOf(ret));
  }

  void acceptRecordingConsent(@NonNull MethodChannel.Result result) {
    if (recordingConsentHandler != null) {
      result.success(recordingConsentHandler.accept());
    } else {
      result.success(false);
    }
  }

  void declineRecordingConsent(@NonNull MethodChannel.Result result) {
    if (recordingConsentHandler != null) {
      result.success(recordingConsentHandler.decline());
    } else {
      result.success(false);
    }
  }

  void getRecordingConsentType(@NonNull MethodChannel.Result result) {
    if (recordingConsentHandler != null) {
      result.success(FlutterZoomVideoSdkRecordingConsentType.valueOf(recordingConsentHandler.getConsentType()));
    } else {
      result.success(FlutterZoomVideoSdkRecordingConsentType.valueOf(ConsentType.ConsentType_Invalid));
    }
  }

  void exportLog(@NonNull MethodChannel.Result result) {
    activity.runOnUiThread(new Runnable() {
      @Override
      public void run() {
        result.success(ZoomVideoSDK.getInstance().exportLog());
      }
    });
  }

  void cleanAllExportedLogs(@NonNull MethodChannel.Result result) {
    activity.runOnUiThread(new Runnable() {
      @Override
      public void run() {
        result.success(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDK.getInstance().cleanAllExportedLogs()));
      }
    });
  }

  // -----------------------------------------------------------------------------------------------
  // region ZoomVideoSDKDelegate
  // -----------------------------------------------------------------------------------------------

  @Override
  public void onSessionJoin() {
    Log.d(DEBUG_TAG, "onSessionJoin");

    ZoomVideoSDKUser mySelf = ZoomVideoSDK.getInstance().getSession().getMySelf();

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onSessionJoin");
    Map<String, Object> message = new HashMap<>();
    message.put("sessionUser", FlutterZoomVideoSdkUser.jsonUser(mySelf));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onSessionLeave() {

  }

  @Override
  public void onSessionLeave(ZoomVideoSDKSessionLeaveReason reason) {
    Log.d(DEBUG_TAG, "onSessionLeave, reason: " + FlutterZoomVideoSdkSessionLeaveReason.valueOf(reason));

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onSessionLeave");

    Map<String, Object> message = new HashMap<>();
    message.put("reason", FlutterZoomVideoSdkSessionLeaveReason.valueOf(reason));
    params.put("message", message);

    eventSink.success(params);
  }

  @Override
  public void onError(int errorCode) {
    switch (errorCode) {
      case ZoomVideoSDKErrors.Errors_Success:
        // Your ZoomVideoSDK operation was successful.
        Log.d(DEBUG_TAG, "Success");
        break;
      default:
        // Your ZoomVideoSDK operation raised an error.
        // Refer to error code documentation.
        Log.d(DEBUG_TAG, "onError, error: " + FlutterZoomVideoSdkErrors.valueOf(errorCode));
        break;
    }

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onError");

    Map<String, Object> message = new HashMap<>();
    message.put("errorType", FlutterZoomVideoSdkErrors.valueOf(errorCode));
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onUserJoin(ZoomVideoSDKUserHelper userHelper, List<ZoomVideoSDKUser> userList) {
    Log.d(DEBUG_TAG, "onUserJoin, userList: " + FlutterZoomVideoSdkUser.jsonUserArray(userList));

    List<ZoomVideoSDKUser> remoteUsers = ZoomVideoSDK.getInstance().getSession().getRemoteUsers();
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onUserJoin");

    Map<String, Object> message = new HashMap<>();
    message.put("joinedUsers", FlutterZoomVideoSdkUser.jsonUserArray(userList));
    message.put("remoteUsers", FlutterZoomVideoSdkUser.jsonUserArray(remoteUsers));
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onUserLeave(ZoomVideoSDKUserHelper userHelper, List<ZoomVideoSDKUser> userList) {
    Log.d(DEBUG_TAG, "onUserLeave, userList: " + FlutterZoomVideoSdkUser.jsonUserArray(userList));

    List<ZoomVideoSDKUser> remoteUsers = ZoomVideoSDK.getInstance().getSession().getRemoteUsers();
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onUserLeave");

    Map<String, Object> message = new HashMap<>();
    message.put("leftUsers", FlutterZoomVideoSdkUser.jsonUserArray(userList));
    message.put("remoteUsers", FlutterZoomVideoSdkUser.jsonUserArray(remoteUsers));
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onUserVideoStatusChanged(ZoomVideoSDKVideoHelper videoHelper, List<ZoomVideoSDKUser> userList) {
    Log.d(DEBUG_TAG, "onUserVideoStatusChanged, userList: " + FlutterZoomVideoSdkUser.jsonUserArray(userList));

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onUserVideoStatusChanged");

    Map<String, Object> message = new HashMap<>();
    message.put("changedUsers", FlutterZoomVideoSdkUser.jsonUserArray(userList));
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onUserAudioStatusChanged(ZoomVideoSDKAudioHelper audioHelper, List<ZoomVideoSDKUser> userList) {
    Log.d(DEBUG_TAG, "onUserAudioStatusChanged, userList: " + FlutterZoomVideoSdkUser.jsonUserArray(userList));

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onUserAudioStatusChanged");

    Map<String, Object> message = new HashMap<>();
    message.put("changedUsers", FlutterZoomVideoSdkUser.jsonUserArray(userList));
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onUserShareStatusChanged(ZoomVideoSDKShareHelper shareHelper, ZoomVideoSDKUser userInfo, ZoomVideoSDKShareStatus status) {


  }

  @Override
  public void onUserShareStatusChanged(ZoomVideoSDKShareHelper shareHelper, ZoomVideoSDKUser userInfo, ZoomVideoSDKShareAction shareAction) {
    Log.d(DEBUG_TAG, "onUserShareStatusChanged, user: " + FlutterZoomVideoSdkUser.jsonUser(userInfo) + ", shareAction: " + FlutterZoomVideoSdkShareAction.jsonShareAction(shareAction));

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onUserShareStatusChanged");

    Map<String, Object> message = new HashMap<>();
    message.put("user", FlutterZoomVideoSdkUser.jsonUser(userInfo));
    message.put("shareAction", FlutterZoomVideoSdkShareAction.jsonShareAction(shareAction));
    params.put("message", message);

    eventSink.success(params);
  }

  @Override
  public void onShareContentChanged(ZoomVideoSDKShareHelper shareHelper, ZoomVideoSDKUser userInfo, ZoomVideoSDKShareAction shareAction) {
    Log.d(DEBUG_TAG, "onShareContentChanged, user: " + FlutterZoomVideoSdkUser.jsonUser(userInfo) + ", shareAction: " + FlutterZoomVideoSdkShareAction.jsonShareAction(shareAction));

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onShareContentChanged");

    Map<String, Object> message = new HashMap<>();
    message.put("user", FlutterZoomVideoSdkUser.jsonUser(userInfo));
    message.put("shareAction", FlutterZoomVideoSdkShareAction.jsonShareAction(shareAction));
    params.put("message", message);

    eventSink.success(params);
  }

  @Override
  public void onLiveStreamStatusChanged(ZoomVideoSDKLiveStreamHelper liveStreamHelper, ZoomVideoSDKLiveStreamStatus status) {
    Log.d(DEBUG_TAG, "onLiveStreamStatusChanged, status: " + FlutterZoomVideoSdkLiveStreamStatus.valueOf(status));

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onLiveStreamStatusChanged");

    Map<String, Object> message = new HashMap<>();
    message.put("status", FlutterZoomVideoSdkLiveStreamStatus.valueOf(status));
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onChatNewMessageNotify(ZoomVideoSDKChatHelper chatHelper, ZoomVideoSDKChatMessage messageItem) {
    Log.d(DEBUG_TAG, "onChatNewMessageNotify, messageItem: " + FlutterZoomVideoSdkChatMessage.jsonMessage(messageItem));

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onChatNewMessageNotify");
    Map<String, Object> message = new HashMap<>();
    message.put("message", FlutterZoomVideoSdkChatMessage.jsonMessage(messageItem));
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onChatDeleteMessageNotify(ZoomVideoSDKChatHelper chatHelper, String msgID, ZoomVideoSDKChatMessageDeleteType deleteBy) {
    Log.d(DEBUG_TAG, "onChatDeleteMessageNotify, msgID: " + msgID + ", deleteBy: " + FlutterZoomVideosSdkChatMessageDeleteType.valueOf(deleteBy));

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onChatDeleteMessageNotify");

    Map<String, Object> message = new HashMap<>();
    message.put("msgID", msgID);
    message.put("type", FlutterZoomVideosSdkChatMessageDeleteType.valueOf(deleteBy));
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onUserHostChanged(ZoomVideoSDKUserHelper userHelper, ZoomVideoSDKUser userInfo) {
    Log.d(DEBUG_TAG, "onUserHostChanged, changedUser: " + FlutterZoomVideoSdkUser.jsonUser(userInfo));

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onUserHostChanged");

    Map<String, Object> message = new HashMap<>();
    message.put("changedUser", FlutterZoomVideoSdkUser.jsonUser(userInfo));
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onUserManagerChanged(ZoomVideoSDKUser user) {
    Log.d(DEBUG_TAG, "onUserManagerChanged, changedUser: " + FlutterZoomVideoSdkUser.jsonUser(user));

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onUserManagerChanged");

    Map<String, Object> message = new HashMap<>();
    message.put("changedUser", FlutterZoomVideoSdkUser.jsonUser(user));
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onUserNameChanged(ZoomVideoSDKUser user) {
    Log.d(DEBUG_TAG, "onUserNameChanged, changedUser: " + FlutterZoomVideoSdkUser.jsonUser(user));

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onUserNameChanged");

    Map<String, Object> message = new HashMap<>();
    message.put("changedUser", FlutterZoomVideoSdkUser.jsonUser(user));
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onUserActiveAudioChanged(ZoomVideoSDKAudioHelper audioHelper, List<ZoomVideoSDKUser> list) {

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onUserActiveAudioChanged");

    Map<String, Object> message = new HashMap<>();
    message.put("changedUsers", FlutterZoomVideoSdkUser.jsonUserArray(list));
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onSessionNeedPassword(ZoomVideoSDKPasswordHandler handler) {
    Log.d(DEBUG_TAG, "onSessionNeedPassword");

    handler.leaveSessionIgnorePassword();

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onSessionNeedPassword");
    params.put("message","onSessionNeedPassword");

    eventSink.success(params);

  }

  @Override
  public void onSessionPasswordWrong(ZoomVideoSDKPasswordHandler handler) {
    Log.d(DEBUG_TAG, "onSessionPasswordWrong");

    handler.leaveSessionIgnorePassword();

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onSessionPasswordWrong");
    params.put("message","onSessionPasswordWrong");

    eventSink.success(params);

  }

  @Override
  public void onMixedAudioRawDataReceived(ZoomVideoSDKAudioRawData rawData) {
    Log.d(DEBUG_TAG, "onMixedAudioRawDataReceived");

  }

  @Override
  public void onOneWayAudioRawDataReceived(ZoomVideoSDKAudioRawData rawData, ZoomVideoSDKUser user) {
    Log.d(DEBUG_TAG, "onOneWayAudioRawDataReceived");

  }

  @Override
  public void onShareAudioRawDataReceived(ZoomVideoSDKAudioRawData rawData) {
    Log.d(DEBUG_TAG, "onShareAudioRawDataReceived");

  }

  @Override
  public void onCommandReceived(ZoomVideoSDKUser sender, String strCmd) {
    Log.d(DEBUG_TAG, "onCommandReceived, sender: " + FlutterZoomVideoSdkUser.jsonUser(sender) + ", command: " + strCmd);

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onCommandReceived");

    Map<String, Object> message = new HashMap<>();
    message.put("sender", FlutterZoomVideoSdkUser.jsonUser(sender));
    message.put("command", strCmd);
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onCommandChannelConnectResult(boolean isSuccess) {
    Log.d(DEBUG_TAG, "onCommandChannelConnectResult, success: " + isSuccess);

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onCommandChannelConnectResult");

    Map<String, Object> message = new HashMap<>();
    message.put("success", isSuccess);
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onCloudRecordingStatus(ZoomVideoSDKRecordingStatus status, ZoomVideoSDKRecordingConsentHandler handler) {
    Log.d(DEBUG_TAG, "onCloudRecordingStatus, status: " + FlutterZoomVideoSdkRecordingStatus.valueOf(status));
    if (handler != null) {
      Log.d(DEBUG_TAG, "onCloudRecordingStatus handler != null");
      recordingConsentHandler = handler;
    }
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onCloudRecordingStatus");

    Map<String, Object> message = new HashMap<>();
    message.put("status", FlutterZoomVideoSdkRecordingStatus.valueOf(status));
    params.put("message", message);

    eventSink.success(params);
  }

  @Override
  public void onHostAskUnmute() {
    Log.d(DEBUG_TAG, "onHostAskUnmute");

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onHostAskUnmute");
    params.put("message", "onHostAskUnmute");

    eventSink.success(params);

  }

  @Override
  public void onInviteByPhoneStatus(ZoomVideoSDKPhoneStatus status, ZoomVideoSDKPhoneFailedReason reason) {
    Log.d(DEBUG_TAG, "onInviteByPhoneStatus, status: " + FlutterZoomVideoSdkPhoneStatus.valueOf(status) + ", reason: " + FlutterZoomVideoSdkPhoneFailedReason.valueOf(reason));

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onInviteByPhoneStatus");

    Map<String, Object> message = new HashMap<>();
    message.put("status", FlutterZoomVideoSdkPhoneStatus.valueOf(status));
    message.put("reason", FlutterZoomVideoSdkPhoneFailedReason.valueOf(reason));
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onMultiCameraStreamStatusChanged(ZoomVideoSDKMultiCameraStreamStatus status, ZoomVideoSDKUser user, ZoomVideoSDKRawDataPipe videoPipe) {

  }

  @Override
  public void onMultiCameraStreamStatusChanged(ZoomVideoSDKMultiCameraStreamStatus status, ZoomVideoSDKUser user, ZoomVideoSDKVideoCanvas canvas) {
    Log.d(DEBUG_TAG, "onMultiCameraStreamStatusChanged, status: " + FlutterZoomVideoSdkMultiCameraStreamStatus.valueOf(status) + ", user: " + FlutterZoomVideoSdkUser.jsonUser(user));

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onMultiCameraStreamStatusChanged");

    Map<String, Object> message = new HashMap<>();
    message.put("status", FlutterZoomVideoSdkMultiCameraStreamStatus.valueOf(status));
    message.put("user", FlutterZoomVideoSdkUser.jsonUser(user));
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onLiveTranscriptionStatus(ZoomVideoSDKLiveTranscriptionHelper.ZoomVideoSDKLiveTranscriptionStatus status) {
    Log.d(DEBUG_TAG, "onLiveTranscriptionStatus, status: " + FlutterZoomVideoSdkLiveTranscriptionStatus.valueOf(status));

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onLiveTranscriptionStatus");

    Map<String, Object> message = new HashMap<>();
    message.put("status", FlutterZoomVideoSdkLiveTranscriptionStatus.valueOf(status));
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onLiveTranscriptionMsgError(ZoomVideoSDKLiveTranscriptionHelper.ILiveTranscriptionLanguage spokenLanguage, ZoomVideoSDKLiveTranscriptionHelper.ILiveTranscriptionLanguage transcriptLanguage) {
    Log.d(DEBUG_TAG, "onLiveTranscriptionMsgError, spokenLanguage: " + FlutterZoomVideoSdkILiveTranscriptionLanguage.jsonLanguage(spokenLanguage) +
            ", transcriptLanguage: " + FlutterZoomVideoSdkILiveTranscriptionLanguage.jsonLanguage(transcriptLanguage));

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onLiveTranscriptionMsgError");

    Map<String, Object> message = new HashMap<>();
    message.put("spokenLanguage", FlutterZoomVideoSdkILiveTranscriptionLanguage.jsonLanguage(spokenLanguage));
    message.put("transcriptLanguage",  FlutterZoomVideoSdkILiveTranscriptionLanguage.jsonLanguage(transcriptLanguage));
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onProxySettingNotification(ZoomVideoSDKProxySettingHandler handler) {
    Log.d(DEBUG_TAG, "onProxySettingNotification, proxyHost: " + handler.getProxyHost() +
            ", proxyPort: " + handler.getProxyPort() +
            ", proxyDescription: " + handler.getProxyDescription());

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onProxySettingNotification");

    Map<String, Object> message = new HashMap<>();
    message.put("proxyHost", handler.getProxyHost());
    message.put("proxyPort",  handler.getProxyPort());
    message.put("proxyDescription",  handler.getProxyDescription());
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onSSLCertVerifiedFailNotification(ZoomVideoSDKSSLCertificateInfo info) {
    Log.d(DEBUG_TAG, "onSSLCertVerifiedFailNotification, certIssuedTo: " + info.getCertIssuedTo() +
            ", certIssuedBy: " + info.getCertIssuedBy() +
            ", certSerialNum: " + info.getCertSerialNum() +
            ", certFingerprint: " + info.getCertFingerprint());

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onSSLCertVerifiedFailNotification");

    Map<String, Object> message = new HashMap<>();
    message.put("certIssuedTo", info.getCertIssuedTo());
    message.put("certIssuedBy",  info.getCertIssuedBy());
    message.put("certSerialNum",  info.getCertSerialNum());
    message.put("certFingerprint",  info.getCertFingerprint());
    params.put("message", message);

    eventSink.success(params);

  }

  @Override
  public void onUserRecordingConsent(ZoomVideoSDKUser user) {
    Log.d(DEBUG_TAG, "onUserRecordingConsent, user: " + user.getUserName());
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onUserRecordingConsent");
    Map<String, Object> message = new HashMap<>();
    message.put("user", FlutterZoomVideoSdkUser.jsonUser(user));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onLiveTranscriptionMsgInfoReceived(ZoomVideoSDKLiveTranscriptionHelper.ILiveTranscriptionMessageInfo messageInfo) {
    Log.d(DEBUG_TAG, "onLiveTranscriptionMsgInfoReceived, message: " + FlutterZoomVideoSdkILiveTranscriptionMessageInfo.jsonMessageInfo(messageInfo));
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onLiveTranscriptionMsgInfoReceived");
    Map<String, Object> message = new HashMap<>();
    message.put("messageInfo", FlutterZoomVideoSdkILiveTranscriptionMessageInfo.jsonMessageInfo(messageInfo));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onUserVideoNetworkStatusChanged(ZoomVideoSDKNetworkStatus status, ZoomVideoSDKUser user) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onUserVideoNetworkStatusChanged");
    Map<String, Object> message = new HashMap<>();
    message.put("status", FlutterZoomVideoSdkNetworkStatus.valueOf(status));
    message.put("user", FlutterZoomVideoSdkUser.jsonUser(user));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onCameraControlRequestResult(ZoomVideoSDKUser user, boolean isApproved) {
    Log.d(DEBUG_TAG, "onCameraControlRequestResult, approved: " + isApproved +
            ", user: " + user.getUserName());

    Map<String, Object> params = new HashMap<>();
    params.put("name", "onCameraControlRequestResult");
    Map<String, Object> message = new HashMap<>();
    message.put("approved", isApproved);
    message.put("user", FlutterZoomVideoSdkUser.jsonUser(user));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onCameraControlRequestReceived(ZoomVideoSDKUser user, ZoomVideoSDKCameraControlRequestType requestType, ZoomVideoSDKCameraControlRequestHandler requestHandler) {

  }

  @Override
  public void onCallCRCDeviceStatusChanged(ZoomVideoSDKCRCCallStatus status) {
    String statusStr = FlutterZoomVideoSdkCRCCallStatus.valueOf(status);
    Log.d(DEBUG_TAG, "onCallCRCDeviceStatusChanged, status: " + statusStr);
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onCallCRCDeviceStatusChanged");
    Map<String, Object> message = new HashMap<>();
    message.put("status", statusStr);
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onAnnotationHelperCleanUp(ZoomVideoSDKAnnotationHelper helper) {
    FlutterZoomVideoSdkAnnotationHelper.getInstance().setAnnotationHelper(null);
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onAnnotationHelperCleanUp");
    params.put("message","onAnnotationHelperCleanUp");
    eventSink.success(params);
  }

  @Override
  public void onAnnotationPrivilegeChange(ZoomVideoSDKUser shareOwner, ZoomVideoSDKShareAction shareAction) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onAnnotationPrivilegeChange");
    Map<String, Object> message = new HashMap<>();
    Log.d(DEBUG_TAG, "onAnnotationPrivilegeChange, shareAction: " + FlutterZoomVideoSdkShareAction.jsonShareAction(shareAction));
    message.put("shareAction", FlutterZoomVideoSdkShareAction.jsonShareAction(shareAction));
    message.put("shareOwner", FlutterZoomVideoSdkUser.jsonUser(shareOwner));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onAnnotationToolTypeChanged(ZoomVideoSDKAnnotationHelper helper, ZoomVideoSDKVideoView view, ZoomVideoSDKAnnotationToolType toolType) {

  }

  @Override
  public void onShareCanvasSubscribeFail(ZoomVideoSDKVideoSubscribeFailReason fail_reason, ZoomVideoSDKUser pUser, ZoomVideoSDKVideoView view) {
  }

  @Override
  public void onShareCanvasSubscribeFail(ZoomVideoSDKUser pUser, ZoomVideoSDKVideoView view, ZoomVideoSDKShareAction shareAction) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onShareCanvasSubscribeFail");
    Map<String, Object> message = new HashMap<>();
    Log.d(DEBUG_TAG, "onShareCanvasSubscribeFail, shareAction: " + FlutterZoomVideoSdkShareAction.jsonShareAction(shareAction));
    message.put("shareAction", FlutterZoomVideoSdkShareAction.jsonShareAction(shareAction));
    message.put("user", FlutterZoomVideoSdkUser.jsonUser(pUser));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onVideoCanvasSubscribeFail(ZoomVideoSDKVideoSubscribeFailReason fail_reason, ZoomVideoSDKUser pUser, ZoomVideoSDKVideoView view) {
    String reasonStr = FlutterZoomVideoSdkVideoSubscribeFailReason.valueOf(fail_reason);
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onVideoCanvasSubscribeFail");
    Map<String, Object> message = new HashMap<>();
    message.put("failReason", reasonStr);
    message.put("user", FlutterZoomVideoSdkUser.jsonUser(pUser));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onOriginalLanguageMsgReceived(ZoomVideoSDKLiveTranscriptionHelper.ILiveTranscriptionMessageInfo messageInfo) {
    Log.d(DEBUG_TAG, "onOriginalLanguageMsgReceived, message: " + FlutterZoomVideoSdkILiveTranscriptionMessageInfo.jsonMessageInfo(messageInfo));
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onOriginalLanguageMsgReceived");
    Map<String, Object> message = new HashMap<>();
    message.put("messageInfo", FlutterZoomVideoSdkILiveTranscriptionMessageInfo.jsonMessageInfo(messageInfo));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onChatPrivilegeChanged(ZoomVideoSDKChatHelper chatHelper, ZoomVideoSDKChatPrivilegeType currentPrivilege) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onChatPrivilegeChanged");
    Map<String, Object> message = new HashMap<>();
    message.put("privilege", FlutterZoomVideoSdkChatPrivilegeType.valueOf(currentPrivilege));
    params.put("message", message);
    eventSink.success(params);

  }

  @Override
  public void onMicSpeakerVolumeChanged(int micVolume, int speakerVolume) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onMicSpeakerVolumeChanged");
    Map<String, Object> message = new HashMap<>();
    message.put("micVolume", micVolume);
    message.put("speakerVolume", speakerVolume);
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onTestMicStatusChanged(ZoomVideoSDKTestMicStatus status) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onTestMicStatusChanged");
    Map<String, Object> message = new HashMap<>();
    message.put("status", FlutterZoomVideoSdkTestMicStatus.valueOf(status));
    params.put("message", message);
    eventSink.success(params);
  }
  @Override
  public void onCalloutJoinSuccess(ZoomVideoSDKUser user,String phoneNumber) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onCalloutJoinSuccess");
    Map<String, Object> message = new HashMap<>();
    message.put("phoneNumber", phoneNumber);
    message.put("user", FlutterZoomVideoSdkUser.jsonUser(user));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onSendFileStatus(ZoomVideoSDKSendFile file, ZoomVideoSDKFileTransferStatus status) {

  }

  @Override
  public void onReceiveFileStatus(ZoomVideoSDKReceiveFile file, ZoomVideoSDKFileTransferStatus status) {

  }

  @Override
  public void onUVCCameraStatusChange(String cameraId, UVCCameraStatus status) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onUVCCameraStatusChange");
    Map<String, Object> message = new HashMap<>();
    message.put("status", FlutterZoomVideoSdkUVCCameraStatus.valueOf(status));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onVideoAlphaChannelStatusChanged(boolean isAlphaModeOn) {

  }

  @Override
  public void onSpotlightVideoChanged(ZoomVideoSDKVideoHelper videoHelper, List<ZoomVideoSDKUser> userList) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onSpotlightVideoChanged");
    Map<String, Object> message = new HashMap<>();
    message.put("changedUsers", FlutterZoomVideoSdkUser.jsonUserArray(userList));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onFailedToStartShare(ZoomVideoSDKShareHelper shareHelper, ZoomVideoSDKUser user) {

  }

  @Override
  public void onBindIncomingLiveStreamResponse(boolean bSuccess, String streamKeyID) {

  }

  @Override
  public void onUnbindIncomingLiveStreamResponse(boolean bSuccess, String streamKeyID) {

  }

  @Override
  public void onIncomingLiveStreamStatusResponse(boolean bSuccess, List<IncomingLiveStreamStatus> streamsStatusList) {

  }

  @Override
  public void onStartIncomingLiveStreamResponse(boolean bSuccess, String streamKeyID) {

  }

  @Override
  public void onStopIncomingLiveStreamResponse(boolean bSuccess, String streamKeyID) {

  }

  @Override
  public void onBroadcastMessageFromMainSession(String name,String messages) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onBroadcastMessageFromMainSession");
    Map<String, Object> message = new HashMap<>();
    message.put("name", name);
    message.put("message", messages);
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onSubSessionUsersUpdate(SubSessionKit kit) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onSubSessionUsersUpdate");
    Map<String, Object> message = new HashMap<>();
    message.put("subSessionKit", FlutterZoomVideoSdkSubSessionKit.jsonSubSessionKit(kit));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onSubSessionStatusChanged(ZoomVideoSDKSubSessionStatus status, List<SubSessionKit> sessionList) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onSubSessionStatusChanged");
    Map<String, Object> message = new HashMap<>();
    message.put("status", FlutterZoomVideoSdkSubSessionStatus.valueOf(status));
    message.put("subSessionList", FlutterZoomVideoSdkSubSessionKit.jsonSubSessionKitArray(sessionList));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onShareContentSizeChanged(ZoomVideoSDKShareHelper shareHelper, ZoomVideoSDKUser userInfo, ZoomVideoSDKShareAction shareAction) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onShareContentSizeChanged");

    Map<String, Object> message = new HashMap<>();
    message.put("user", FlutterZoomVideoSdkUser.jsonUser(userInfo));
    message.put("shareAction", FlutterZoomVideoSdkShareAction.jsonShareAction(shareAction));
    params.put("message", message);

    eventSink.success(params);
  }

  @Override
  public void onSubSessionUserHelpRequestResult(ZoomVideoSDKUserHelpRequestResult result) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onSubSessionUserHelpRequestResult");
    Map<String, Object> message = new HashMap<>();
    message.put("result", FlutterZoomVideoSdkUserHelpRequestResult.valueOf(result));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onSubSessionUserHelpRequest(SubSessionUserHelpRequestHandler handler) {
    FlutterZoomVideoSdkSubSessionHelper.storeSubSessionUserHelpRequestHandler(handler);
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onSubSessionUserHelpRequestHandler");
    params.put("message","onSubSessionUserHelpRequestHandler");

    eventSink.success(params);
  }

  @Override
  public void onSubSessionParticipantHandle(ZoomVideoSDKSubSessionParticipant handler) {
    FlutterZoomVideoSdkSubSessionHelper.storeSubSessionParticipant(handler);
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onSubSessionParticipantHandle");
    params.put("message","onSubSessionParticipantHandle");

    eventSink.success(params);
  }

  @Override
  public void onSubSessionManagerHandle(ZoomVideoSDKSubSessionManager manager) {
    FlutterZoomVideoSdkSubSessionHelper.storeSubSessionManager(manager);
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onSubSessionManagerHandle");
    params.put("message","onSubSessionManagerHandle");

    eventSink.success(params);
  }

  @Override
  public void onShareSettingChanged(ZoomVideoSDKShareSetting shareSetting) {

  }

  @Override
  public void onStartBroadcastResponse(boolean bSuccess, String channelID) {

  }

  @Override
  public void onStopBroadcastResponse(boolean bSuccess) {

  }

  @Override
  public void onGetBroadcastControlStatus(boolean bSuccess, ZoomVideoSDKBroadcastControlStatus status) {

  }

  @Override
  public void onStreamingJoinStatusChanged(ZoomVideoSDKStreamingJoinStatus status) {

  }

  @Override
  public void onUserWhiteboardShareStatusChanged(ZoomVideoSDKUser user, ZoomVideoSDKWhiteboardHelper helper) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onUserWhiteboardShareStatusChanged");
    Map<String, Object> message = new HashMap<>();
    message.put("status", FlutterZoomVideoSdkWhiteboardStatus.valueOf(user.getWhiteboardStatus()));
    message.put("user", FlutterZoomVideoSdkUser.jsonUser(user));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onWhiteboardExported(ZoomVideoSDKExportFormat format, byte[] data) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onWhiteboardExported");
    Map<String, Object> message = new HashMap<>();
    message.put("format", FlutterZoomVideoSdkExportFormat.valueOf(format));
    message.put("data", Base64.encodeToString(data, Base64.NO_WRAP));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onMyAudioSourceTypeChanged(ZoomVideoSDKAudioHelper.ZoomVideoSDKAudioDevice device) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onMyAudioSourceTypeChanged");
    Map<String, Object> message = new HashMap<>();
    message.put("device", FlutterZoomVideoSdkAudioDevice.jsonAudioDevice(device));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onUserNetworkStatusChanged(ZoomVideoSDKDataType type, ZoomVideoSDKNetworkStatus level, ZoomVideoSDKUser user) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onUserNetworkStatusChanged");
    Map<String, Object> message = new HashMap<>();
    message.put("type", FlutterZoomVideoSdkDataType.valueOf(type));
    message.put("level", FlutterZoomVideoSdkNetworkStatus.valueOf(level));
    message.put("user", FlutterZoomVideoSdkUser.jsonUser(user));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onUserOverallNetworkStatusChanged(ZoomVideoSDKNetworkStatus level, ZoomVideoSDKUser user) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onUserOverallNetworkStatusChanged");
    Map<String, Object> message = new HashMap<>();
    message.put("level", FlutterZoomVideoSdkNetworkStatus.valueOf(level));
    message.put("user", FlutterZoomVideoSdkUser.jsonUser(user));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onAudioLevelChanged(int level, boolean audioSharing, ZoomVideoSDKUser user) {
    Map<String, Object> params = new HashMap<>();
    params.put("name", "onAudioLevelChanged");
    Map<String, Object> message = new HashMap<>();
    message.put("level", level);
    message.put("audioSharing", audioSharing);
    message.put("user", FlutterZoomVideoSdkUser.jsonUser(user));
    params.put("message", message);
    eventSink.success(params);
  }

  @Override
  public void onRealTimeMediaStreamsStatus(RealTimeMediaStreamsStatus status) {

  }

  @Override
  public void onRealTimeMediaStreamsFail(RealTimeMediaStreamsFailReason failReason) {

  }

  @Override
  public void onSpokenLanguageChanged(ZoomVideoSDKLiveTranscriptionHelper.ILiveTranscriptionLanguage spokenLanguage) {

  }

  @Override
  public void onShareNetworkStatusChanged(ZoomVideoSDKNetworkStatus status, boolean isSendingShare) {

  }

  @Override
  public void onCanvasSnapshotIncompatible(ZoomVideoSDKUser user) {

  }

  @Override
  public void onCanvasSnapshotTaken(ZoomVideoSDKUser user, boolean isShare) {

  }

  // -----------------------------------------------------------------------------------------------
  // endregion
  // -----------------------------------------------------------------------------------------------


  protected void refreshRotation() {
    int displayRotation = display.getRotation();
    if (ZoomVideoSDK.getInstance().getVideoHelper() != null) {
      ZoomVideoSDK.getInstance().getVideoHelper().rotateMyVideo(displayRotation);
    }
  }

  private void sendEvent(Map<String, Object> params) {
    eventSink.success(params);
  }

  @Override
  public void onListen(Object arguments, EventChannel.EventSink events) {
    this.eventSink = events;

  }

  @Override
  public void onCancel(Object arguments) {
    eventSink = null;

  }
}
