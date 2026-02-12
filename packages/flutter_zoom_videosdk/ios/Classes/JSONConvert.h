#import <ZoomVideoSdk/ZoomVideoSDK.h>
#import <AVFoundation/AVFoundation.h>

@interface JSONConvert: NSObject

// NOTE: These methods get defined by the call to RCT_ENUM_CONVERTER so we just need to provide the headers for them so other things can call into them correctly.

+(NSString* ) NSDictionaryToNSString:(NSDictionary*) dictionary;

+ (NSDictionary* ) NSStringToNSDictionary:(NSString*) jsonString;

+(NSString* ) NSMutableArrayToNSString:(NSMutableArray*) array;

+ (ZoomVideoSDKRawDataMemoryMode)ZoomVideoSDKRawDataMemoryMode:(id)json;
+ (NSDictionary *)ZoomVideoSDKRawDataMemoryModeValuesReversed;

+ (ZoomVideoSDKReceiveSharingStatus)ZoomVideoSDKReceiveSharingStatus:(id)json;
+ (NSDictionary *)ZoomVideoSDKReceiveSharingStatusValuesReversed;

+ (ZoomVideoSDKError)ZoomVideoSDKError:(id)json;
+ (NSDictionary *)ZoomVideoSDKErrorValuesReversed;

+ (ZoomVideoSDKAudioType)ZoomVideoSDKAudioType:(id)json;
+ (NSDictionary *)ZoomVideoSDKAudioTypeValuesReversed;

+ (ZoomVideoSDKVideoAspect)ZoomVideoSDKVideoAspect:(id)json;
+ (NSDictionary *)ZoomVideoSDKVideoAspectValuesReversed;

+ (ZoomVideoSDKVideoResolution)ZoomVideoSDKVideoResolution:(id)json;
+ (NSDictionary *)ZoomVideoSDKVideoResolutionValuesReversed;

+ (ZoomVideoSDKLiveStreamStatus)ZoomVideoSDKLiveStreamStatus:(id)json;
+ (NSDictionary *)ZoomVideoSDKLiveStreamStatusValuesReversed;

+ (ZoomVideoSDKRecordingStatus)ZoomVideoSDKRecordingStatus:(id)json;
+ (NSDictionary *)ZoomVideoSDKRecordingStatusValuesReversed;

+ (ZoomVideoSDKPhoneStatus)ZoomVideoSDKPhoneStatus:(id)json;
+ (NSDictionary *)ZoomVideoSDKPhoneStatusValuesReversed;

+ (ZoomVideoSDKPhoneFailedReason)ZoomVideoSDKPhoneFailedReason:(id)json;
+ (NSDictionary *)ZoomVideoSDKPhoneFailedReasonValuesReversed;

+ (ZoomVideoSDKVideoPreferenceMode)ZoomVideoSDKVideoPreferenceMode:(id)json;
+ (NSDictionary *)ZoomVideoSDKVideoPreferenceModeValuesReversed;

+ (ZoomVideoSDKChatMsgDeleteBy)ZoomVideoSDKChatMsgDeleteBy:(id)json;
+ (NSDictionary *)ZoomVideoSDKChatMsgDeleteByValuesReversed;

+ (ZoomVideoSDKLiveTranscriptionStatus)ZoomVideoSDKLiveTranscriptionStatus:(id)json;
+ (NSDictionary *)ZoomVideoSDKLiveTranscriptionStatusValuesReversed;

+ (ZoomVideoSDKLiveTranscriptionOperationType)ZoomVideoSDKLiveTranscriptionOperationType:(id)json;
+ (NSDictionary *)ZoomVideoSDKLiveTranscriptionOperationTypeValuesReversed;

+ (ZoomVideoSDKMultiCameraStreamStatus)ZoomVideoSDKMultiCameraStreamStatus:(id)json;
+ (NSDictionary *)ZoomVideoSDKMultiCameraStreamStatusValuesReversed;

+ (ZoomVideoSDKSystemPermissionType)ZoomVideoSDKSystemPermissionType:(id)json;
+ (NSDictionary *)ZoomVideoSDKSystemPermissionTypeValuesReversed;

+ (ZoomVideoSDKDialInNumType)ZoomVideoSDKDialInNumType:(id)json;
+ (NSDictionary *)ZoomVideoSDKDialInNumTypeValuesReversed;

+ (ZoomVideoSDKRecordAgreementType)ZoomVideoSDKRecordAgreementType:(id)json;
+ (NSDictionary *)ZoomVideoSDKRecordAgreementTypeValuesReversed;

+ (ZoomVideoSDKNetworkStatus)ZoomVideoSDKNetworkStatus:(id)json;
+ (NSDictionary *)ZoomVideoSDKNetworkStatusValuesReversed;

+ (ZoomVideoSDKVirtualBackgroundDataType)ZoomVideoSDKVirtualBackgroundDataType:(id)json;
+ (NSDictionary *)ZoomVideoSDKVirtualBackgroundDataTypeValuesReversed;

+ (ZoomVideoSDKCRCProtocol)ZoomVideoSDKCRCProtocol:(id)json;
+ (NSDictionary *)ZoomVideoSDKCRCProtocolValuesReversed;

+ (ZoomVideoSDKCRCCallStatus)ZoomVideoSDKCRCCallStatus:(id)json;
+ (NSDictionary *)ZoomVideoSDKCRCCallStatusValuesReversed;

+ (ZoomVideoSDKChatPrivilegeType)ZoomVideoSDKChatPrivilegeType:(id)json;
+ (NSDictionary *)ZoomVideoSDKChatPrivilegeTypeValuesReversed;

+ (ZoomVideoSDKAnnotationToolType)ZoomVideoSDKAnnotationToolType:(id)json;
+ (NSDictionary *)ZoomVideoSDKAnnotationToolTypeValuesReversed;

+ (ZoomVideoSDKAnnotationClearType)ZoomVideoSDKAnnotationClearType:(id)json;
+ (NSDictionary *)ZoomVideoSDKAnnotationClearTypeValuesReversed;

+ (ZoomVideoSDKSubscribeFailReason)ZoomVideoSDKSubscribeFailReason:(id)json;
+ (NSDictionary *)ZoomVideoSDKSubscribeFailReasonValuesReversed;

+ (ZoomVideoSDKTestMicStatus)ZoomVideoSDKTestMicStatus:(id)json;
+ (NSDictionary *)ZoomVideoSDKTestMicStatusValuesReversed;

+ (ZoomVideoSDKSessionLeaveReason)ZoomVideoSDKSessionLeaveReason:(id)json;
+ (NSDictionary *)ZoomVideoSDKSessionLeaveReasonValuesReversed;

+ (AVCaptureDevicePosition)AVCaptureDevicePosition:(id)json;
+ (NSDictionary *)AVCaptureDevicePositionValuesReversed;

+ (ZoomVideoSDKUVCCameraStatus)ZoomVideoSDKUVCCameraStatus:(id)json;
+ (NSDictionary *)ZoomVideoSDKUVCCameraStatusValuesReversed;

+ (ZoomVideoSDKShareType)ZoomVideoSDKShareType:(id)json;
+ (NSDictionary *)ZoomVideoSDKShareTypeValuesReversed;

+ (ZoomVideoSDKPreferVideoResolution)ZoomVideoSDKPreferVideoResolution:(id)json;
+ (NSDictionary *)ZoomVideoSDKPreferVideoResolutionValuesReversed;

+ (ZoomVideoSDKDataType)ZoomVideoSDKDataType:(id)json;
+ (NSDictionary *)ZoomVideoSDKDataTypeValuesReversed;

+ (ZoomVideoSDKWhiteboardExportFormatType)ZoomVideoSDKWhiteboardExportFormatType:(id)json;
+ (NSDictionary *)ZoomVideoSDKWhiteboardExportFormatTypeValuesReversed;

+ (ZoomVideoSDKWhiteboardStatus)ZoomVideoSDKWhiteboardStatus:(id)json;
+ (NSDictionary *)ZoomVideoSDKWhiteboardStatusValuesReversed;

+ (ZoomVideoSDKSubSessionStatus)ZoomVideoSDKSubSessionStatus:(id)json;
+ (NSDictionary *)ZoomVideoSDKSubSessionStatusValuesReversed;

+ (ZoomVideoSDKUserHelpRequestResult)ZoomVideoSDKUserHelpRequestResult:(id)json;
+ (NSDictionary *)ZoomVideoSDKUserHelpRequestResultValuesReversed;

@end
