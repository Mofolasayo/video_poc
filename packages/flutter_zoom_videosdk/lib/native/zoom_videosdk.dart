import 'package:flutter/services.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_CRC_helper.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_annotation_helper.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_audio_helper.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_audio_setting_helper.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_chat_helper.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_cmd_channel.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_live_stream_helper.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_live_transcription_helper.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_phone_helper.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_recording_helper.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_remote_camera_control_helper.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_session.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_share_helper.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_subsession_helper.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_test_audio_helper.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_user_helper.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_video_helper.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_virtual_background_helper.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk_whiteboard_helper.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class RawDataMemoryMode {
  static const Stack = 'ZoomVideoSDKRawDataMemoryModeStack';
  static const Heap = 'ZoomVideoSDKRawDataMemoryModeHeap';
}

class SubscribeFailReason {
  static const NotSupport1080P = 'ZoomVideoSDKSubscribeFailReason_NotSupport1080P';
  static const HasSubscribeShare = 'ZoomVideoSDKSubscribeFailReason_HasSubscribeShare';
  static const HasSubscribeOneShare = 'ZoomVideoSDKSubscribeFailReason_HasSubscribeOneShare';
  static const HasSubscribeExceededLimit = 'ZoomVideoSDKSubscribeFailReason_HasSubscribeExceededLimit';
  static const None = 'ZoomVideoSDKSubscribeFailReason_None';
}

class UVCCameraStatus {
  static const Attached = 'ZoomVideoSDKUVCCameraStatus_Attached';
  static const Detached = 'ZoomVideoSDKUVCCameraStatus_Detached';
  static const Connected = 'ZoomVideoSDKUVCCameraStatus_Connected';
  static const Canceled = 'ZoomVideoSDKUVCCameraStatus_Canceled';
}

/// You can get share status in the user object [ZoomVideoSDKUser]
class ShareStatus {
  static const None = 'ZoomVideoSDKShareStatus_None';
  static const Stop = 'ZoomVideoSDKShareStatus_Stop';
  static const Pause = 'ZoomVideoSDKShareStatus_Pause';
  static const Start = 'ZoomVideoSDKShareStatus_Start';
  static const Resume = 'ZoomVideoSDKShareStatus_Resume';
}

/// An enumeration of live stream status.
class LiveStreamStatus {
  static const None = 'ZoomVideoSDKLiveStreamStatus_None';
  static const InProgress = 'ZoomVideoSDKLiveStreamStatus_InProgress';
  static const Connecting = 'ZoomVideoSDKLiveStreamStatus_Connecting';
  static const FailedTimeout = 'ZoomVideoSDKLiveStreamStatus_FailedTimeout';
  static const StartFailed = 'ZoomVideoSDKLiveStreamStatus_StartFailed';
  static const Ended = 'ZoomVideoSDKLiveStreamStatus_Ended';
}

/// An enum representing the status of the recording status.
class RecordingStatus {
  static const None = 'ZoomVideoSDKRecordingStatus_None';
  static const Start = 'ZoomVideoSDKRecordingStatus_Start';
  static const Stop = 'ZoomVideoSDKRecordingStatus_Stop';
  static const DiskFull = 'ZoomVideoSDKRecordingStatus_DiskFull';
  static const Pause = 'ZoomVideoSDKRecordingStatus_Pause';
}

/// An enumeration of audio type.
class AudioType {
  static const None = 'ZoomVideoSDKAudioType_None';
  static const VOIP = 'ZoomVideoSDKAudioType_VOIP';
  static const Telephony = 'ZoomVideoSDKAudioType_Telephony';
  static const Unknown = 'ZoomVideoSDKAudioType_Unknown';
}

/// An enumeration of video aspect.
class VideoAspect {
  static const Original = 'ZoomVideoSDKVideoAspect_Original';
  static const FullFilled = 'ZoomVideoSDKVideoAspect_Full_Filled';
  static const LetterBox = 'ZoomVideoSDKVideoAspect_LetterBox';
  static const PanAndScan = 'ZoomVideoSDKVideoAspect_PanAndScan';
}

/// An enumeration of video resolution.
class VideoResolution {
  static const Resolution90 = 'ZoomVideoSDKVideoResolution_90';
  static const Resolution180 = 'ZoomVideoSDKVideoResolution_180';
  static const Resolution360 = 'ZoomVideoSDKVideoResolution_360';
  static const Resolution720 = 'ZoomVideoSDKVideoResolution_720';
  static const Resolution1080 = 'ZoomVideoSDKVideoResoluton_1080';
}

/// Status of telephone.
class PhoneStatus {
  static const None = 'ZoomVideoSDKPhoneStatus_None';
  static const Calling = 'ZoomVideoSDKPhoneStatus_Calling';
  static const Ringing = 'ZoomVideoSDKPhoneStatus_Ringing';
  static const Accepted = 'ZoomVideoSDKPhoneStatus_Accepted';
  static const Success = 'ZoomVideoSDKPhoneStatus_Success';
  static const Failed = 'ZoomVideoSDKPhoneStatus_Failed';
  static const Canceling = 'ZoomVideoSDKPhoneStatus_Canceling';
  static const Canceled = 'ZoomVideoSDKPhoneStatus_Canceled';
  static const CancelFailed = 'ZoomVideoSDKPhoneStatus_Cancel_Failed';
  static const Timeout = 'ZoomVideoSDKPhoneStatus_Timeout';
}

/// The reason for the failure of the telephone call.
class PhoneFailedReason {
  static const None = 'ZoomVideoSDKPhoneFailedReason_None'; /// For initialization.
  static const Busy = 'ZoomVideoSDKPhoneFailedReason_Busy'; /// The telephone number is busy.
  static const NotAvailable = 'ZoomVideoSDKPhoneFailedReason_Not_Available'; /// The telephone number is out of service.
  static const UserHangup = 'ZoomVideoSDKPhoneFailedReason_User_Hangup'; /// The user hangs up.
  static const OtherFail = 'ZoomVideoSDKPhoneFailedReason_Other_Fail'; /// Other reasons.
  static const NoAnswer = 'ZoomVideoSDKPhoneFailedReason_No_Answer'; /// The user did not answer the call.
  static const BlockNoHost = 'ZoomVideoSDKPhoneFailedReason_Block_No_Host'; /// The invitation by phone is blocked by the system due to an absent host.
  static const BlockHighRate = 'ZoomVideoSDKPhoneFailedReason_Block_High_Rate'; /// The invite by phone is blocked by the system due to the high cost.
  static const BlockTooFrequent =
      'ZoomVideoSDKPhoneFailedReason_Block_Too_Frequent'; /// To join the session, the invitee would press one on the phone. An invitee who fails to respond will encounter a timeout. If there are too many invitee timeouts, the call invitation feature for this session will be blocked.
}

/// The chat message delete type are sent in the onChatMsgDeleteNotification:messageID:deleteBy: callback.
class ChatMessageDeleteType {
  static const None = 'ZoomVideoSDKChatMsgDeleteBy_NONE';
  static const Self = 'ZoomVideoSDKChatMsgDeleteBy_SELF';
  static const Host = 'ZoomVideoSDKChatMsgDeleteBy_HOST';
  static const Dlp = 'ZoomVideoSDKChatMsgDeleteBy_DLP';
}

class MultiCameraStreamStatus {
  static const Joined = 'ZoomVideoSDKMultiCameraStreamStatus_Joined';
  static const Left = 'ZoomVideoSDKMultiCameraStreamStatus_Left';
}

/// The live transcription statuses are sent in the ZoomVideoSDKDelegate#onLiveTranscriptionStatus callback.
class LiveTranscriptionStatus {
  static const Stop = 'ZoomVideoSDKLiveTranscription_Status_Stop';
  static const Start = 'ZoomVideoSDKLiveTranscription_Status_Start';
}

class SystemPermissionType {
  static const Camera = 'ZoomVideoSDKSystemPermissionType_Camera';
  static const Microphone = 'ZoomVideoSDKSystemPermissionType_Microphone';
}

class LiveTranscriptionOperationType {
  static const None = 'ZoomVideoSDKLiveTranscription_OperationType_None';
  static const Update = 'ZoomVideoSDKLiveTranscription_OperationType_Update';
  static const Delete = 'ZoomVideoSDKLiveTranscription_OperationType_Delete';
  static const Complete =
      'ZoomVideoSDKLiveTranscription_OperationType_Complete';
  static const Add = 'ZoomVideoSDKLiveTranscription_OperationType_Add';
  static const NotSupport =
      'ZoomVideoSDKLiveTranscription_OperationType_NotSupported';
}

class DialInNumberType {
  static const None = 'ZoomVideoSDKDialInNumType_None';
  static const Toll = 'ZoomVideoSDKDialInNumType_Toll';
  static const TollFree = 'ZoomVideoSDKDialInNumType_TollFree';
}

/// Cloud recording consent type.
class ConsentType {
  static const ConsentType_Invalid = 'ConsentType_Invalid';
  static const ConsentType_Traditional = 'ConsentType_Traditional'; //In this case, 'accept' means agree to be recorded to gallery and speaker mode, 'decline' means leave session.
  static const ConsentType_Individual = 'ConsentType_Individual'; //In this case, 'accept' means agree to be recorded to a separate file, 'decline' means stay in session and can't be recorded.
}

/// Type of video network status.
class NetworkStatus {
  static const None = 'ZoomVideoSDKNetwork_None';
  static const Good = 'ZoomVideoSDKNetwork_Good';
  static const Normal = 'ZoomVideoSDKNetwork_Normal';
  static const Bad = 'ZoomVideoSDKNetwork_Bad';
}

/// Enumerations of the type for virtual background.
class ZoomVideoSDKVirtualBackgroundDataType {
  static const None = 'ZoomVideoSDKLiveTranscription_OperationType_None';
  static const Blur = 'ZoomVideoSDKLiveTranscription_OperationType_Update';
  static const Image = 'ZoomVideoSDKLiveTranscription_OperationType_Delete';
}

/// Enumerations of the type for crc protocol.
class ZoomVideoSdkCRCProtocolType {
  static const H323 = 'ZoomVideoSDKCRCProtocol_H323';
  static const SIP = 'ZoomVideoSDKCRCProtocol_SIP';
}

/// Enumerations of the type for CRC call out status
class ZoomVideoSDKCRCCallStatus {
  static const Success = 'ZoomVideoSDKCRCCallOutStatus_Success';
  static const Ring = 'ZoomVideoSDKCRCCallOutStatus_Ring';
  static const Timeout = 'ZoomVideoSDKCRCCallOutStatus_Timeout';
  static const Busy = 'ZoomVideoSDKCRCCallOutStatus_Busy';
  static const Decline = 'ZoomVideoSDKCRCCallOutStatus_Decline';
  static const Failed = 'ZoomVideoSDKCRCCallOutStatus_Failed';
}

/// Enumerations of the type for chat privilege.
class ChatPrivilegeType {
  static const Unknown = 'ZoomVideoSDKChatPrivilege_Unknown';
  static const PubliclyAndPrivately = 'ZoomVideoSDKChatPrivilege_Publicly_And_Privately';
  static const NoOne = 'ZoomVideoSDKChatPrivilege_No_One';
  static const Publicly = 'ZoomVideoSDKChatPrivilege_Publicly';
}

class AnnotationClearType {
  static const All = 'ZoomVideoSDKAnnotationClearType_All';
  static const Others = 'ZoomVideoSDKAnnotationClearType_Others';
  static const My = 'ZoomVideoSDKAnnotationClearType_My';
}

class TestMicStatus {
  static const CanTest = 'ZoomVideoSDKMic_CanTest';
  static const Recording = 'ZoomVideoSDKMic_Recording';
  static const CanPlay = 'ZoomVideoSDKMic_CanPlay';
}

class AnnotationToolType {
  static const None = 'ZoomVideoSDKAnnotationToolType_None';
  static const Pen = 'ZoomVideoSDKAnnotationToolType_Pen';
  static const HighLighter = 'ZoomVideoSDKAnnotationToolType_HighLighter';
  static const AutoLine = 'ZoomVideoSDKAnnotationToolType_AutoLine';
  static const AutoRectangle = 'ZoomVideoSDKAnnotationToolType_AutoRectangle';
  static const AutoEllipse = 'ZoomVideoSDKAnnotationToolType_AutoEllipse';
  static const AutoArrow = 'ZoomVideoSDKAnnotationToolType_AutoArrow';
  static const AutoRectangleFill = 'ZoomVideoSDKAnnotationToolType_AutoRectangleFill';
  static const AutoEllipseFill = 'ZoomVideoSDKAnnotationToolType_AutoEllipseFill';
  static const SpotLight = 'ZoomVideoSDKAnnotationToolType_SpotLight';
  static const Arrow = 'ZoomVideoSDKAnnotationToolType_Arrow';
  static const Eraser = 'ZoomVideoSDKAnnotationToolType_Eraser';
  static const Picker = 'ZoomVideoSDKAnnotationToolType_Picker';
  static const AutoRectangleSemiFill = 'ZoomVideoSDKAnnotationToolType_AutoRectangleSemiFill';
  static const AutoEllipseSemiFill = 'ZoomVideoSDKAnnotationToolType_AutoEllipseSemiFill';
  static const AutoDoubleArrow = 'ZoomVideoSDKAnnotationToolType_AutoDoubleArrow';
  static const AutoDiamond = 'ZoomVideoSDKAnnotationToolType_AutoDiamond';
  static const AutoStampArrow = 'ZoomVideoSDKAnnotationToolType_AutoStampArrow';
  static const AutoStampCheck = 'ZoomVideoSDKAnnotationToolType_AutoStampCheck';
  static const AutoStampX = 'ZoomVideoSDKAnnotationToolType_AutoStampX';
  static const AutoStampStar = 'ZoomVideoSDKAnnotationToolType_AutoStampStar';
  static const AutoStampHeart = 'ZoomVideoSDKAnnotationToolType_AutoStampHeart';
  static const AutoStampQm = 'ZoomVideoSDKAnnotationToolType_AutoStampQm';
  static const VanishingPen = 'ZoomVideoSDKAnnotationToolType_VanishingPen';
  static const VanishingArrow = 'ZoomVideoSDKAnnotationToolType_VanishingArrow';
  static const VanishingDoubleArrow = 'ZoomVideoSDKAnnotationToolType_VanishingDoubleArrow';
  static const VanishingEllipse = 'ZoomVideoSDKAnnotationToolType_VanishingEllipse';
  static const VanishingRectangle = 'ZoomVideoSDKAnnotationToolType_VanishingRectangle';
  static const VanishingDiamond = 'ZoomVideoSDKAnnotationToolType_VanishingDiamond';
}

class AudioSourceType {
  static const None = 'AUDIO_SOURCE_NONE';
  static const Bluetooth = 'AUDIO_SOURCE_BLUETOOTH';
  static const Wired = 'AUDIO_SOURCE_WIRED';
  static const EarPhone = 'AUDIO_SOURCE_EAR_PHONE';
  static const SpeakerPhone = 'AUDIO_SOURCE_SPEAKER_PHONE';
  static const BuiltInMic = 'AUDIO_SOURCE_BUILTIN_MIC';
  static const Airplay = 'AUDIO_SOURCE_AIRPLAY';
}

class SessionLeaveReason {
  static const Unknown = 'ZoomVideoSDKSessionLeaveReason_Unknown';
  static const BySelf = 'ZoomVideoSDKSessionLeaveReason_BySelf';
  static const KickByHost = 'ZoomVideoSDKSessionLeaveReason_KickByHost';
  static const EndByHost = 'ZoomVideoSDKSessionLeaveReason_EndByHost';
  static const NetworkError = 'ZoomVideoSDKSessionLeaveReason_NetworkError';
}

class ShareType {
  static const None = 'ZoomVideoSDKShareType_None';
  static const Normal = 'ZoomVideoSDKShareType_Normal';
  static const Camera = 'ZoomVideoSDKShareType_Camera';
  static const PureAudio = 'ZoomVideoSDKShareType_PureAudio';
}

class PreferVideoResolution {
  static const PreferVideoResolution_None = 'ZoomVideoSDKPreferVideoResolution_None';
  static const PreferVideoResolution_360P = 'ZoomVideoSDKPreferVideoResolution_360P';
  static const PreferVideoResolution_720P = 'ZoomVideoSDKPreferVideoResolution_720P';
}

class DataType {
  static const Video = 'ZoomVideoSDKDataType_Video';
  static const Audio = 'ZoomVideoSDKDataType_Audio';
  static const Share = 'ZoomVideoSDKDataType_Share';
  static const Unknown = 'ZoomVideoSDKDataType_Unknown';
}

class ExportFormat {
  static const PDF = 'ZoomVideoSDKWhiteboardExport_Format_PDF';
}

class WhiteboardStatus {
  static const Started = 'WhiteboardStatus_Started';
  static const Stopped = 'WhiteboardStatus_Stopped';
}

class SubSessionStatus {
  static const None = 'ZoomVideoSDKSubSessionStatus_None';
  static const Started = 'ZoomVideoSDKSubSessionStatus_Started';
  static const Stopped = 'ZoomVideoSDKSubSessionStatus_Stopped';
  static const Stopping = 'ZoomVideoSDKSubSessionStatus_Stopping';
  static const StartFailed = 'ZoomVideoSDKSubSessionStatus_StartFailed';
  static const StopFailed = 'ZoomVideoSDKSubSessionStatus_StopFailed';
  static const Withdrawn = 'ZoomVideoSDKSubSessionStatus_Withdrawn';
  static const WithdrawFailed = 'ZoomVideoSDKSubSessionStatus_WithdrawFailed';
  static const Committed = 'ZoomVideoSDKSubSessionStatus_Committed';
  static const CommitFailed = 'ZoomVideoSDKSubSessionStatus_CommitFailed';
}

class UserHelpRequestResult {
  static const Idle = 'ZoomVideoSDKUserHelpRequestResult_Idle';
  static const Busy = 'ZoomVideoSDKUserHelpRequestResult_Busy';
  static const Ignore = 'ZoomVideoSDKUserHelpRequestResult_Ignore';
  static const HostAlreadyInSubSession = 'ZoomVideoSDKUserHelpRequestResult_HostAlreadyInSubSession';
}

/// An enumeration of error.
class Errors {
  static const Success = 'ZoomVideoSDKError_Success';
  static const WrongUsage = 'ZoomVideoSDKError_Wrong_Usage';
  static const InternalError = 'ZoomVideoSDKError_Internal_Error';
  static const Uninitialize = 'ZoomVideoSDKError_Uninitialize';
  static const MemoryError = 'ZoomVideoSDKError_Memory_Error';
  static const LoadModuleError = 'ZoomVideoSDKError_Load_Module_Error';
  static const UnLoadModuleError = 'ZoomVideoSDKError_UnLoad_Module_Error';
  static const InvalidParameter = 'ZoomVideoSDKError_Invalid_Parameter';
  static const CallTooFrequntly = 'ZoomVideoSDKError_Call_Too_Frequently';
  static const NoImpl = 'ZoomVideoSDKError_No_Impl';
  static const DontSupportFeature = 'ZoomVideoSDKError_Dont_Support_Feature';
  static const Unknown = 'ZoomVideoSDKError_Unknown';
  static const AuthBase = 'ZoomVideoSDKError_Auth_Base';
  static const AuthError = 'ZoomVideoSDKError_Auth_Error';
  static const AuthEmptyKeyorSecret =
      'ZoomVideoSDKError_Auth_Empty_Key_or_Secret';
  static const AuthWrongKeyorSecret =
      'ZoomVideoSDKError_Auth_Wrong_Key_or_Secret';
  static const AuthDoesNotSupportSDK =
      'ZoomVideoSDKError_Auth_DoesNot_Support_SDK';
  static const AuthDisableSDK = 'ZoomVideoSDKError_Auth_Disable_SDK';
  static const JoinSessionNoSessioName =
      'ZoomVideoSDKError_JoinSession_NoSessionName';
  static const JoinSessioNoSessionToken =
      'ZoomVideoSDKError_JoinSession_NoSessionToken';
  static const JoinSessionNoUserName =
      'ZoomVideoSDKError_JoinSession_NoUserName';
  static const JoinSessionInvalidSessionName =
      'ZoomVideoSDKError_JoinSession_Invalid_SessionName';
  static const JoinSessionInvalidPassword =
      'ZoomVideoSDKError_JoinSession_InvalidPassword';
  static const JoinSessionInvalidSessionToken =
      'ZoomVideoSDKError_JoinSession_Invalid_SessionToken';
  static const JoinSessionSessionNameTooLong =
      'ZoomVideoSDKError_JoinSession_SessionName_TooLong';
  static const JoinSessionTokenMismatchedSessionName =
      'ZoomVideoSDKError_JoinSession_Token_MismatchedSessionName';
  static const JoinSessionTokenNoSessionName =
      'ZoomVideoSDKError_JoinSession_Token_NoSessionName';
  static const JoinSessionTokenRoleTypeEmptyOrWrong =
      'ZoomVideoSDKError_JoinSession_Token_RoleType_EmptyOrWrong';
  static const JoinSessionTokenUserIdentityTooLong =
      'ZoomVideoSDKError_JoinSession_Token_UserIdentity_TooLong';
  static const SessionBase = 'ZoomVideoSDKError_Session_Base';
  static const SessionModuleNotFound =
      'ZoomVideoSDKError_Session_Module_Not_Found';
  static const SessionServiceInvaild =
      'ZoomVideoSDKError_Session_Service_Invaild';
  static const SessionJoinFailed = 'ZoomVideoSDKError_Session_Join_Failed';
  static const SessionNoRights = 'ZoomVideoSDKError_Session_No_Rights';
  static const SessionAlreadyInProgress =
      'ZoomVideoSDKError_Session_Already_In_Progress';
  static const SessionDontSupportSessionType =
      'ZoomVideoSDKError_Session_Dont_Support_SessionType';
  static const SessionReconnecting = 'ZoomVideoSDKError_Session_Reconnecting';
  static const SessionDisconnecting = 'ZoomVideoSDKError_Session_Disconnecting';
  static const SessionNotStarted = 'ZoomVideoSDKError_Session_Not_Started';
  static const SessionNeedPassword = 'ZoomVideoSDKError_Session_Need_Password';
  static const SessionPasswordWrong =
      'ZoomVideoSDKError_Session_Password_Wrong';
  static const SessionRemoteDBError =
      'ZoomVideoSDKError_Session_Remote_DB_Error';
  static const SessionInvalidParam = 'ZoomVideoSDKError_Session_Invalid_Param';
  static const SessionAudioError = 'ZoomVideoSDKError_Session_Audio_Error';
  static const SessionAudioNoMicrophone =
      'ZoomVideoSDKError_Session_Audio_No_Microphone';
  static const SessionVideoError = 'ZoomVideoSDKError_Session_Video_Error';
  static const SessionVideoDeviceError =
      'ZoomVideoSDKError_Session_Video_Device_Error';
  static const SessionLiveStreamError =
      'ZoomVideoSDKError_Session_Live_Stream_Error';
  static const SessionPhoneError = 'ZoomVideoSDKError_Session_Phone_Error';
  static const DontSupportMultiStreamVideoUser =
      'ZoomVideoSDKError_Dont_Support_Multi_Stream_Video_User';
  static const FailAssignUserPrivilege =
      'ZoomVideoSDKError_Fail_Assign_User_Privilege';
  static const NoRecordingInProcess =
      'ZoomVideoSDKError_No_Recording_In_Process';
  static const MallocFailed = 'ZoomVideoSDKError_Malloc_Failed';
  static const NotInSession = 'ZoomVideoSDKError_Not_In_Session';
  static const NoLicense = 'ZoomVideoSDKError_No_License';
  static const VideoModuleNotReady = 'ZoomVideoSDKError_Video_Module_Not_Ready';
  static const VideoModuleError = 'ZoomVideoSDKError_Video_Module_Error';
  static const VideoDeviceError = 'ZoomVideoSDKError_Video_device_error';
  static const NoVideoData = 'ZoomVideoSDKError_No_Video_Data';
  static const ShareModuleNotReady = 'ZoomVideoSDKError_Share_Module_Not_Ready';
  static const ShareModuleError = 'ZoomVideoSDKError_Share_Module_Error';
  static const NoShareData = 'ZoomVideoSDKError_No_Share_Data';
  static const AudioModuleNotReady = 'ZoomVideoSDKError_Audio_Module_Not_Ready';
  static const AudioModuleError = 'ZoomVideoSDKError_Audio_Module_Error';
  static const NoAudioData = 'ZoomVideoSDKError_No_Audio_Data';
  static const PreprocessRawdataError =
      'ZoomVideoSDKError_Preprocess_Rawdata_Error';
  static const RawdataNoDeviceRunning =
      'ZoomVideoSDKError_Rawdata_No_Device_Running';
  static const RawdataInitDevice = 'ZoomVideoSDKError_Rawdata_Init_Device';
  static const RawdataVirtualDevice =
      'ZoomVideoSDKError_Rawdata_Virtual_Device';
  static const RawdataCannotChangeVirtualDeviceInPreview =
      'ZoomVideoSDKError_Rawdata_Cannot_Change_Virtual_Device_In_Preview';
  static const RawdataInternalError =
      'ZoomVideoSDKError_Rawdata_Internal_Error';
  static const RawdataSendTooMuchDataInSingleTime =
      'ZoomVideoSDKError_Rawdata_Send_Too_Much_Data_In_Single_Time';
  static const RawdataSendTooFrequently =
      'ZoomVideoSDKError_Rawdata_Send_Too_Frequently';
  static const RawdataVirtualMicIsTerminate =
      'ZoomVideoSDKError_Rawdata_Virtual_Mic_Is_Terminate';
  static const SessionShareError = 'ZoomVideoSDKError_Session_Share_Error';
  static const SessionShareModuleNotReady =
      'ZoomVideoSDKError_Session_Share_Module_Not_Ready';
  static const SessionShareYouAreNotSharing =
      'ZoomVideoSDKError_Session_Share_You_Are_Not_Sharing';
  static const SessionShareTypeIsNotSupport =
      'ZoomVideoSDKError_Session_Share_Type_Is_Not_Support';
  static const SessionShareInternalError =
      'ZoomVideoSDKError_Session_Share_Internal_Error';
  static const Permission_RECORD_AUDIO =
      'ZoomVideoSDKError_Permission_RECORD_AUDIO';
  static const Permission_READ_PHONE_STATE =
      'ZoomVideoSDKError_Permission_READ_PHONE_STATE';
  static const BLUETOOTH_CONNECT =
      'ZoomVideoSDKError_Permission_BLUETOOTH_CONNECT';
}

class InitConfig {
  String? domain;
  bool? enableLog;
  String? logFilePrefix;
  String? appGroupId;
  String? screeShareBundleId;
  bool? enableFullHD; // Availble for certain Android hardware only.
  bool? enableCallKit;
  RawDataMemoryMode? videoRawDataMemoryMode;
  RawDataMemoryMode? audioRawDataMemoryMode;
  RawDataMemoryMode? shareRawDataMemoryMode;
  String? speakerFilePath;
  String? preferVideoResolution;

  //Constructor
  InitConfig(
      {required this.domain,
      required this.enableLog,
      this.logFilePrefix,
      this.appGroupId,
      this.screeShareBundleId,
      this.enableFullHD,
      this.enableCallKit,
      this.videoRawDataMemoryMode,
      this.audioRawDataMemoryMode,
      this.shareRawDataMemoryMode,
      this.speakerFilePath,
      this.preferVideoResolution});
}

class JoinSessionConfig {
  String? sessionName;
  String? sessionPassword;
  String? token;
  String? userName;
  Map<String, bool>? audioOptions;
  Map<String, bool>? videoOptions;
  num? sessionIdleTimeoutMins;

  //Constructor
  JoinSessionConfig(
      {required this.sessionName,
      this.sessionPassword,
      required this.token,
      required this.userName,
      this.audioOptions,
      this.videoOptions,
      this.sessionIdleTimeoutMins});
}

abstract class ZoomVideoSdkPlatform extends PlatformInterface {
  ZoomVideoSdkPlatform() : super(token: _token);

  static final Object _token = Object();
  static ZoomVideoSdkPlatform _instance = ZoomVideoSdk();
  static ZoomVideoSdkPlatform get instance => _instance;
  static set instance(ZoomVideoSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> initSdk(InitConfig configs) async {
    throw UnimplementedError('initZoom() has not been implemented.');
  }

  Future<String> joinSession(JoinSessionConfig configs) async {
    throw UnimplementedError('initZoom() has not been implemented.');
  }

  Future<String> leaveSession(bool endSession) async {
    throw UnimplementedError('initZoom() has not been implemented.');
  }

  Future<String> getSdkVersion() async {
    throw UnimplementedError('initZoom() has not been implemented.');
  }

  Future<void> openBrowser(String url) async {
    throw UnimplementedError('openBrowser() has not been implemented.');
  }

  Future<void> cleanup() async {
    throw UnimplementedError('cleanup() has not been implemented.');
  }

  Future<bool> acceptRecordingConsent() async {
    throw UnimplementedError('acceptRecordingConsent() has not been implemented.');
  }

  Future<bool> declineRecordingConsent() async {
    throw UnimplementedError('declineRecordingConsent() has not been implemented.');
  }

  Future<String> getRecordingConsentType() async {
    throw UnimplementedError('getRecordingConsentType() has not been implemented.');
  }

  Future<String> exportLog() async {
    throw UnimplementedError('exportLog() has not been implemented.');
  }

  Future<String> cleanAllExportedLogs() async {
    throw UnimplementedError('cleanAllExportedLogs() has not been implemented.');
  }
}

class ZoomVideoSdk extends ZoomVideoSdkPlatform {
  var session = ZoomVideoSdkSession();
  var audioHelper = ZoomVideoSdkAudioHelper();
  var audioSettingHelper = ZoomVideoSdkAudioSettingHelper();
  var chatHelper = ZoomVideoSdkChatHelper();
  var cmdChannel = ZoomVideoSdkCmdChannel();
  var liveStreamHelper = ZoomVideoSdkLiveStreamHelper();
  var liveTranscriptionHelper = ZoomVideoSdkLiveTranscriptionHelper();
  var phoneHelper = ZoomVideoSdkPhoneHelper();
  var recordingHelper = ZoomVideoSdkRecordingHelper();
  var userHelper = ZoomVideoSdkUserHelper();
  var testAudioHelper = ZoomVideoSdkTestAudioHelper();
  var videoHelper = ZoomVideoSdkVideoHelper();
  var shareHelper = ZoomVideoSdkShareHelper();
  var remoteCameraControlHelper = ZoomVideoSdkRemoteCameraControlHelper();
  var virtualBackgroundHelper = ZoomVideoSdkVirtualBackgroundHelper();
  var CRCHelper = ZoomVideoSdkCRCHelper();
  var annotationHelper = ZoomVideoSdkAnnotationHelper();
  var whiteboardHelper = ZoomVideoSdkWhiteboardHelper();
  var subSessionHelper = ZoomVideoSdkSubSessionHelper();

  final methodChannel = const MethodChannel('flutter_zoom_videosdk');

  @override
  Future<String> initSdk(InitConfig configs) async {
    var configMap = <String, dynamic>{};
    configMap.putIfAbsent("domain", () => configs.domain);
    configMap.putIfAbsent("enableLog", () => configs.enableLog);
    configMap.putIfAbsent("logFilePrefix", () => configs.logFilePrefix);
    configMap.putIfAbsent("appGroupId", () => configs.appGroupId);
    configMap.putIfAbsent("screeShareBundleId", () => configs.screeShareBundleId);
    configMap.putIfAbsent("enableFullHD", () => configs.enableFullHD);
    configMap.putIfAbsent("enableCallKit", () => configs.enableCallKit);
    configMap.putIfAbsent(
        "videoRawDataMemoryMode", () => configs.videoRawDataMemoryMode);
    configMap.putIfAbsent(
        "audioRawDataMemoryMode", () => configs.audioRawDataMemoryMode);
    configMap.putIfAbsent(
        "shareRawDataMemoryMode", () => configs.shareRawDataMemoryMode);
    configMap.putIfAbsent("speakerFilePath", () => configs.speakerFilePath);
    configMap.putIfAbsent("preferVideoResolution", () => configs.preferVideoResolution);

    return await methodChannel
        .invokeMethod<String>('initSdk', configMap)
        .then<String>((String? value) => value ?? "");
  }

  @override
  Future<String> joinSession(JoinSessionConfig configs) async {
    var configMap = <String, dynamic>{};
    configMap.putIfAbsent("sessionName", () => configs.sessionName);
    configMap.putIfAbsent("sessionPassword", () => configs.sessionPassword);
    configMap.putIfAbsent("token", () => configs.token);
    configMap.putIfAbsent("userName", () => configs.userName);
    configMap.putIfAbsent("audioOptions", () => configs.audioOptions);
    configMap.putIfAbsent("videoOptions", () => configs.videoOptions);
    configMap.putIfAbsent(
        "sessionIdleTimeoutMins", () => configs.sessionIdleTimeoutMins);

    return await methodChannel
        .invokeMethod<String>('joinSession', configMap)
        .then<String>((String? value) => value ?? "");
  }

  @override
  Future<String> leaveSession(bool endSession) async {
    var configMap = <String, dynamic>{};
    configMap.putIfAbsent('endSession', () => endSession);
    return await methodChannel
        .invokeMethod<String>('leaveSession', configMap)
        .then<String>((String? value) => value ?? "");
  }

  @override
  Future<String> getSdkVersion() async {
    return await methodChannel
        .invokeMethod<String>('getSdkVersion')
        .then<String>((String? value) => value ?? "");
  }

  @override
  Future<void> openBrowser(String url) async {
    var params = <String, dynamic>{};
    params.putIfAbsent('url', () => url);

    await methodChannel.invokeMethod<void>('openBrowser', params);
  }

  @override
  Future<String> cleanup() async {
    return await methodChannel
        .invokeMethod<String>('cleanup')
        .then<String>((String? value) => value ?? "");
  }

  @override
  Future<String> getRecordingConsentType() async {
    return await methodChannel
        .invokeMethod<String>('getRecordingConsentType')
        .then<String>((String? value) => value ?? "");
  }

  @override
  Future<bool> acceptRecordingConsent() async {
    return await methodChannel
        .invokeMethod<bool>('acceptRecordingConsent')
        .then<bool>((bool? value) => value ?? false);
  }

  @override
  Future<bool> declineRecordingConsent() async {
    return await methodChannel
        .invokeMethod<bool>('declineRecordingConsent')
        .then<bool>((bool? value) => value ?? false);
  }

  @override
  Future<String> exportLog() async {
    return await methodChannel
        .invokeMethod<String>('exportLog')
        .then<String>((String? value) => value ?? "");
  }

  @override
  Future<String> cleanAllExportedLogs() async {
    return await methodChannel
        .invokeMethod<String>('cleanAllExportedLogs')
        .then<String>((String? value) => value ?? "");
  }
}
