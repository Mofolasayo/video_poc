#import "JSONConvert.h"

@implementation JSONConvert

+ (NSDictionary* ) NSStringToNSDictionary:(NSString*) jsonString {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:jsonData
                                                       options:NSJSONReadingAllowFragments
                                                         error:&error];
    if (error) {
        NSLog(@"Got an error: %@", error);
        return nil;
    } else {
        NSLog(@"%@", data);
        return data;
    }
}

+(NSString* ) NSDictionaryToNSString:(NSDictionary*) dictionary {
    if (dictionary) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:0];
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return @"";
}

+(NSString* ) NSMutableArrayToNSString:(NSMutableArray* ) array {
    if (array) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:array options:0 error:nil];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return @"";
}

NSNumber *ConvertEnumValue(const char *typeName, NSDictionary *mapping, NSNumber *defaultValue, id json) {
  if (!json) {
    return defaultValue;
  }
  if ([json isKindOfClass:[NSNumber class]]) {
    NSArray *allValues = mapping.allValues;
    if ([allValues containsObject:json] || [json isEqual:defaultValue]) {
      return json;
    }
    NSLog(@"Invalid %s '%@'. should be one of: %@", typeName, json, allValues);
    return defaultValue;
  }
  if (![json isKindOfClass:[NSString class]]) {
    NSLog(@"Expected NSNumber or NSString for %s, received %@: %@", typeName, [json classForCoder], json);
  }
  id value = mapping[json];
  if (!value && [json description].length > 0) {
    NSLog(
        @"Invalid %s '%@'. should be one of: %@",
        typeName,
        json,
        [[mapping allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]);
  }
  return value ?: defaultValue;
}

//We want to be able to reverse the enum. From ENUM => String.
//So we extend the built in RCT_ENUM_CONVERTER-macro
#define RCT_ENUM_CONVERTER_WITH_REVERSED(type, values, default, getter) \
+ (type)type:(id)json                                     \
{                                                         \
static NSDictionary *mapping;                           \
static dispatch_once_t onceToken;                       \
dispatch_once(&onceToken, ^{                            \
mapping = values;                                     \
});                                                     \
return [ConvertEnumValue(#type, mapping, @(default), json) getter]; \
}                                                        \
+ (NSDictionary *)type##ValuesReversed                        \
{                                                         \
    static NSDictionary *mapping;                           \
    static dispatch_once_t onceToken;                       \
    dispatch_once(&onceToken, ^{                            \
        NSArray *keys = values.allKeys;                     \
        NSArray *valuesArray = [values objectsForKeys:keys notFoundMarker:[NSNull null]];    \
        mapping = [NSDictionary dictionaryWithObjects:keys forKeys:valuesArray];\
    });                                                     \
    return mapping;                                         \
}

RCT_ENUM_CONVERTER_WITH_REVERSED(
   ZoomVideoSDKRawDataMemoryMode,
   (@{
        @"ZoomVideoSDKRawDataMemoryModeStack" : @(ZoomVideoSDKRawDataMemoryModeStack),
        @"ZoomVideoSDKRawDataMemoryModeHeap" : @(ZoomVideoSDKRawDataMemoryModeHeap)
    }),
    ZoomVideoSDKRawDataMemoryModeStack,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(
    ZoomVideoSDKVideoPreferenceMode,
    (@{
        @"ZoomVideoSDKVideoPreferenceMode_Balance" : @(ZoomVideoSDKVideoPreferenceMode_Balance),
        @"ZoomVideoSDKVideoPreferenceMode_Sharpness" : @(ZoomVideoSDKVideoPreferenceMode_Sharpness),
        @"ZoomVideoSDKVideoPreferenceMode_Smoothness" : @(ZoomVideoSDKVideoPreferenceMode_Smoothness),
        @"ZoomVideoSDKVideoPreferenceMode_Custom" : @(ZoomVideoSDKVideoPreferenceMode_Custom)
    }),
    ZoomVideoSDKVideoPreferenceMode_Balance,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(
   ZoomVideoSDKReceiveSharingStatus,
   (@{
        @"ZoomVideoSDKShareStatus_None" : @(ZoomVideoSDKReceiveSharingStatus_None),
        @"ZoomVideoSDKShareStatus_Stop" : @(ZoomVideoSDKReceiveSharingStatus_Stop),
        @"ZoomVideoSDKShareStatus_Pause" : @(ZoomVideoSDKReceiveSharingStatus_Pause),
        @"ZoomVideoSDKShareStatus_Start" : @(ZoomVideoSDKReceiveSharingStatus_Start),
        @"ZoomVideoSDKShareStatus_Resume" : @(ZoomVideoSDKReceiveSharingStatus_Resume)
    }),
    ZoomVideoSDKReceiveSharingStatus_None,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(
    ZoomVideoSDKRecordingStatus,
    (@{
        @"ZoomVideoSDKRecordingStatus_None" : @(ZoomVideoSDKRecordingStatus_None),
        @"ZoomVideoSDKRecordingStatus_Start" : @(ZoomVideoSDKRecordingStatus_Start),
        @"ZoomVideoSDKRecordingStatus_Stop" : @(ZoomVideoSDKRecordingStatus_Stop),
        @"ZoomVideoSDKRecordingStatus_DiskFull" : @(ZoomVideoSDKRecordingStatus_DiskFull),
        @"ZoomVideoSDKRecordingStatus_Pause" : @(ZoomVideoSDKRecordingStatus_Pause)
    }),
    ZoomVideoSDKRecordingStatus_None,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(
   ZoomVideoSDKError,
   (@{
       @"ZoomVideoSDKError_Success": @(Errors_Success),
       @"ZoomVideoSDKError_Wrong_Usage": @(Errors_Wrong_Usage),
       @"ZoomVideoSDKError_Internal_Error": @(Errors_Internal_Error),
       @"ZoomVideoSDKError_Uninitialize": @(Errors_Uninitialize),
       @"ZoomVideoSDKError_Memory_Error": @(Errors_Memory_Error),
       @"ZoomVideoSDKError_Load_Module_Error": @(Errors_Load_Module_Error),
       @"ZoomVideoSDKError_UnLoad_Module_Error": @(Errors_UnLoad_Module_Error),
       @"ZoomVideoSDKError_Invalid_Parameter": @(Errors_Invalid_Parameter),
       @"ZoomVideoSDKError_Call_Too_Frequently": @(Errors_Call_Too_Frequently),
       @"ZoomVideoSDKError_No_Impl": @(Errors_No_Impl),
       @"ZoomVideoSDKError_Dont_Support_Feature": @(Errors_Dont_Support_Feature),
       @"ZoomVideoSDKError_Unknown": @(Errors_Unknown),
       @"ZoomVideoSDKError_Auth_Base": @(Errors_Auth_Base),
       @"ZoomVideoSDKError_Auth_Error": @(Errors_Auth_Error),
       @"ZoomVideoSDKError_Auth_Empty_Key_or_Secret": @(Errors_Auth_Empty_Key_or_Secret),
       @"ZoomVideoSDKError_Auth_Wrong_Key_or_Secret": @(Errors_Auth_Wrong_Key_or_Secret),
       @"ZoomVideoSDKError_Auth_DoesNot_Support_SDK": @(Errors_Auth_DoesNot_Support_SDK),
       @"ZoomVideoSDKError_Auth_Disable_SDK": @(Errors_Auth_Disable_SDK),
       @"ZoomVideoSDKError_JoinSession_NoSessionName": @(Errors_JoinSession_NoSessionName),
       @"ZoomVideoSDKError_JoinSession_NoSessionToken": @(Errors_JoinSession_NoSessionToken),
       @"ZoomVideoSDKError_JoinSession_NoUserName": @(Errors_JoinSession_NoUserName),
       @"ZoomVideoSDKError_JoinSession_Invalid_SessionName": @(Errors_JoinSession_Invalid_SessionName),
       @"ZoomVideoSDKError_JoinSession_Invalid_Password": @(Errors_JoinSession_Invalid_Password),
       @"ZoomVideoSDKError_JoinSession_Invalid_SessionToken": @(Errors_JoinSession_Invalid_SessionToken),
       @"ZoomVideoSDKError_JoinSession_SessionName_TooLong": @(Errors_JoinSession_SessionName_TooLong),
       @"ZoomVideoSDKError_JoinSession_Token_MismatchedSessionName": @(Errors_JoinSession_Token_MismatchedSessionName),
       @"ZoomVideoSDKError_JoinSession_Token_NoSessionName": @(Errors_JoinSession_Token_NoSessionName),
       @"ZoomVideoSDKError_JoinSession_Token_RoleType_EmptyOrWrong": @(Errors_JoinSession_Token_RoleType_EmptyOrWrong),
       @"ZoomVideoSDKError_JoinSession_Token_UserIdentity_TooLong": @(Errors_JoinSession_Token_UserIdentity_TooLong),
       @"ZoomVideoSDKError_Session_Base": @(Errors_Session_Base),
       @"ZoomVideoSDKError_Session_Module_Not_Found": @(Errors_Session_Module_Not_Found),
       @"ZoomVideoSDKError_Session_Service_Invaild": @(Errors_Session_Service_Invalid),
       @"ZoomVideoSDKError_Session_Join_Failed": @(Errors_Session_Join_Failed),
       @"ZoomVideoSDKError_Session_No_Rights": @(Errors_Session_No_Rights),
       @"ZoomVideoSDKError_Session_Already_In_Progress": @(Errors_Session_Already_In_Progress),
       @"ZoomVideoSDKError_Session_Dont_Support_SessionType": @(Errors_Session_Dont_Support_SessionType),
       @"ZoomVideoSDKError_Session_Reconnecting": @(Errors_Session_Reconnecting),
       @"ZoomVideoSDKError_Session_Disconnecting": @(Errors_Session_Disconnecting),
       @"ZoomVideoSDKError_Session_Not_Started": @(Errors_Session_Not_Started),
       @"ZoomVideoSDKError_Session_Need_Password": @(Errors_Session_Need_Password),
       @"ZoomVideoSDKError_Session_Password_Wrong": @(Errors_Session_Password_Wrong),
       @"ZoomVideoSDKError_Session_Remote_DB_Error": @(Errors_Session_Remote_DB_Error),
       @"ZoomVideoSDKError_Session_Invalid_Param": @(Errors_Session_Invalid_Param),
       @"ZoomVideoSDKError_Session_Audio_Error": @(Errors_Session_Audio_Error),
       @"ZoomVideoSDKError_Session_Audio_No_Microphone": @(Errors_Session_Audio_No_Microphone),
       @"ZoomVideoSDKError_Session_Video_Error": @(Errors_Session_Video_Error),
       @"ZoomVideoSDKError_Session_Video_Device_Error": @(Errors_Session_Video_Device_Error),
       @"ZoomVideoSDKError_Session_Live_Stream_Error": @(Errors_Session_Live_Stream_Error),
       @"ZoomVideoSDKError_Session_Phone_Error": @(Errors_Session_Phone_Error),
       @"ZoomVideoSDKError_Dont_Support_Multi_Stream_Video_User": @(Errors_Dont_Support_Multi_Stream_Video_User),
       @"ZoomVideoSDKError_Fail_Assign_User_Privilege": @(Errors_Fail_Assign_User_Privilege),
       @"ZoomVideoSDKError_No_Recording_In_Process": @(Errors_No_Recording_In_Process),
       @"ZoomVideoSDKError_Malloc_Failed": @(Errors_Malloc_Failed),
       @"ZoomVideoSDKError_Not_In_Session": @(Errors_Not_In_Session),
       @"ZoomVideoSDKError_No_License": @(Errors_No_License),
       @"ZoomVideoSDKError_Video_Module_Not_Ready": @(Errors_Video_Module_Not_Ready),
       @"ZoomVideoSDKError_Video_Module_Error": @(Errors_Video_Module_Error),
       @"ZoomVideoSDKError_Video_device_error": @(Errors_Video_device_error),
       @"ZoomVideoSDKError_No_Video_Data": @(Errors_No_Video_Data),
       @"ZoomVideoSDKError_Share_Module_Not_Ready": @(Errors_Share_Module_Not_Ready),
       @"ZoomVideoSDKError_Share_Module_Error": @(Errors_Share_Module_Error),
       @"ZoomVideoSDKError_No_Share_Data": @(Errors_No_Share_Data),
       @"ZoomVideoSDKError_Audio_Module_Not_Ready": @(Errors_Audio_Module_Not_Ready),
       @"ZoomVideoSDKError_Audio_Module_Error": @(Errors_Audio_Module_Error),
       @"ZoomVideoSDKError_No_Audio_Data": @(Errors_No_Audio_Data),
       @"ZoomVideoSDKError_Preprocess_Rawdata_Error": @(Errors_Preprocess_Rawdata_Error),
       @"ZoomVideoSDKError_Rawdata_No_Device_Running": @(Errors_Rawdata_No_Device_Running),
       @"ZoomVideoSDKError_Rawdata_Init_Device": @(Errors_Rawdata_Init_Device),
       @"ZoomVideoSDKError_Rawdata_Virtual_Device": @(Errors_Rawdata_Virtual_Device),
       @"ZoomVideoSDKError_Rawdata_Cannot_Change_Virtual_Device_In_Preview": @(Errors_Rawdata_Cannot_Change_Virtual_Device_In_Preview),
       @"ZoomVideoSDKError_Rawdata_Internal_Error": @(Errors_Rawdata_Internal_Error),
       @"ZoomVideoSDKError_Rawdata_Send_Too_Much_Data_In_Single_Time": @(Errors_Rawdata_Send_Too_Much_Data_In_Single_Time),
       @"ZoomVideoSDKError_Rawdata_Send_Too_Frequently": @(Errors_Rawdata_Send_Too_Frequently),
       @"ZoomVideoSDKError_Rawdata_Virtual_Mic_Is_Terminate": @(Errors_Rawdata_Virtual_Mic_Is_Terminate),
       @"ZoomVideoSDKError_Session_Share_Error": @(Errors_Session_Share_Error),
       @"ZoomVideoSDKError_Session_Share_Module_Not_Ready": @(Errors_Session_Share_Module_Not_Ready),
       @"ZoomVideoSDKError_Session_Share_You_Are_Not_Sharing": @(Errors_Session_Share_You_Are_Not_Sharing),
       @"ZoomVideoSDKError_Session_Share_Type_Is_Not_Support": @(Errors_Session_Share_Type_Is_Not_Support),
       @"ZoomVideoSDKError_Session_Share_Internal_Error": @(Errors_Session_Share_Internal_Error),
       @"ZoomVideoSDKError_Session_Client_Incompatible": @(Errors_Session_Client_Incompatible),
    }),
    Errors_Unknown,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(
   ZoomVideoSDKAudioType,
   (@{
        @"ZoomVideoSDKAudioType_None" : @(ZoomVideoSDKAudioType_None),
        @"ZoomVideoSDKAudioType_VOIP" : @(ZoomVideoSDKAudioType_VOIP),
        @"ZoomVideoSDKAudioType_TELEPHONY" : @(ZoomVideoSDKAudioType_TELEPHONY),
        @"ZoomVideoSDKAudioType_Unknown" : @(ZoomVideoSDKAudioType_Unknown),
    }),
    ZoomVideoSDKAudioType_None,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(
   ZoomVideoSDKVideoAspect,
   (@{
        @"ZoomVideoSDKVideoAspect_Original" : @(ZoomVideoSDKVideoAspect_Original),
        @"ZoomVideoSDKVideoAspect_Full_Filled" : @(ZoomVideoSDKVideoAspect_Full_Filled),
        @"ZoomVideoSDKVideoAspect_LetterBox" : @(ZoomVideoSDKVideoAspect_LetterBox),
        @"ZoomVideoSDKVideoAspect_PanAndScan" : @(ZoomVideoSDKVideoAspect_PanAndScan),
    }),
    ZoomVideoSDKVideoAspect_Original,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(
   ZoomVideoSDKVideoResolution,
   (@{
        @"ZoomVideoSDKVideoResolution_90" : @(ZoomVideoSDKVideoResolution_90),
        @"ZoomVideoSDKVideoResolution_180" : @(ZoomVideoSDKVideoResolution_180),
        @"ZoomVideoSDKVideoResolution_360" : @(ZoomVideoSDKVideoResolution_360),
        @"ZoomVideoSDKVideoResolution_720" : @(ZoomVideoSDKVideoResolution_720),
    }),
    ZoomVideoSDKVideoResolution_90,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(
   ZoomVideoSDKLiveStreamStatus,
   (@{
        @"ZoomVideoSDKLiveStreamStatus_None" : @(ZoomVideoSDKLiveStreamStatus_None),
        @"ZoomVideoSDKLiveStreamStatus_InProgress" : @(ZoomVideoSDKLiveStreamStatus_InProgress),
        @"ZoomVideoSDKLiveStreamStatus_Connecting" : @(ZoomVideoSDKLiveStreamStatus_Connecting),
        @"ZoomVideoSDKLiveStreamStatus_FailedTimeout" : @(ZoomVideoSDKLiveStreamStatus_FailedTimeout),
        @"ZoomVideoSDKLiveStreamStatus_StartFailed" : @(ZoomVideoSDKLiveStreamStatus_StartFailed),
        @"ZoomVideoSDKLiveStreamStatus_Ended" : @(ZoomVideoSDKLiveStreamStatus_Ended),
    }),
    ZoomVideoSDKLiveStreamStatus_None,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(
    ZoomVideoSDKPhoneStatus,
    (@{
        @"ZoomVideoSDKPhoneStatus_None" : @(ZoomVideoSDKPhoneStatus_None),
        @"ZoomVideoSDKPhoneStatus_Calling" : @(ZoomVideoSDKPhoneStatus_Calling),
        @"ZoomVideoSDKPhoneStatus_Ringing" : @(ZoomVideoSDKPhoneStatus_Ringing),
        @"ZoomVideoSDKPhoneStatus_Accepted" : @(ZoomVideoSDKPhoneStatus_Accepted),
        @"ZoomVideoSDKPhoneStatus_Success" : @(ZoomVideoSDKPhoneStatus_Success),
        @"ZoomVideoSDKPhoneStatus_Failed" : @(ZoomVideoSDKPhoneStatus_Failed),
        @"ZoomVideoSDKPhoneStatus_Canceling" : @(ZoomVideoSDKPhoneStatus_Canceling),
        @"ZoomVideoSDKPhoneStatus_Canceled" : @(ZoomVideoSDKPhoneStatus_Canceled),
        @"ZoomVideoSDKPhoneStatus_Cancel_Failed" : @(ZoomVideoSDKPhoneStatus_Cancel_Failed),
        @"ZoomVideoSDKPhoneStatus_Timeout" : @(ZoomVideoSDKPhoneStatus_Timeout),
    }),
    ZoomVideoSDKPhoneStatus_None,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(
    ZoomVideoSDKPhoneFailedReason,
    (@{
        @"ZoomVideoSDKPhoneFailedReason_None" : @(ZoomVideoSDKPhoneFailedReason_None),
        @"ZoomVideoSDKPhoneFailedReason_Busy" : @(ZoomVideoSDKPhoneFailedReason_Busy),
        @"ZoomVideoSDKPhoneFailedReason_Not_Available" : @(ZoomVideoSDKPhoneFailedReason_Not_Available),
        @"ZoomVideoSDKPhoneFailedReason_User_Hangup" : @(ZoomVideoSDKPhoneFailedReason_User_Hangup),
        @"ZoomVideoSDKPhoneFailedReason_Other_Fail" : @(ZoomVideoSDKPhoneFailedReason_Other_Fail),
        @"ZoomVideoSDKPhoneFailedReason_No_Answer" : @(ZoomVideoSDKPhoneFailedReason_No_Answer),
        @"ZoomVideoSDKPhoneFailedReason_Block_No_Host" : @(ZoomVideoSDKPhoneFailedReason_Block_No_Host),
        @"ZoomVideoSDKPhoneFailedReason_Block_High_Rate" : @(ZoomVideoSDKPhoneFailedReason_Block_High_Rate),
        @"ZoomVideoSDKPhoneFailedReason_Block_Too_Frequent" : @(ZoomVideoSDKPhoneFailedReason_Block_Too_Frequent),
    }),
    ZoomVideoSDKPhoneStatus_None,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(
    ZoomVideoSDKMultiCameraStreamStatus,
    (@{
        @"ZoomVideoSDKMultiCameraStreamStatus_Joined": @(ZoomVideoSDKMultiCameraStreamStatus_Joined),
        @"ZoomVideoSDKMultiCameraStreamStatus_Left": @(ZoomVideoSDKMultiCameraStreamStatus_Left),
    }),
    ZoomVideoSDKMultiCameraStreamStatus_Joined,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(
    ZoomVideoSDKChatMsgDeleteBy,
    (@{
        @"ZoomVideoSDKChatMsgDeleteBy_NONE" : @(ZoomVideoSDKChatMsgDeleteBy_NONE),
        @"ZoomVideoSDKChatMsgDeleteBy_SELF" : @(ZoomVideoSDKChatMsgDeleteBy_SELF),
        @"ZoomVideoSDKChatMsgDeleteBy_HOST" : @(ZoomVideoSDKChatMsgDeleteBy_HOST),
        @"ZoomVideoSDKChatMsgDeleteBy_DLP" : @(ZoomVideoSDKChatMsgDeleteBy_DLP)
    }),
    ZoomVideoSDKChatMsgDeleteBy_NONE,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(
    ZoomVideoSDKLiveTranscriptionStatus,
    (@{
        @"ZoomVideoSDKLiveTranscription_Status_Stop" : @(ZoomVideoSDKLiveTranscriptionStatus_Stop),
        @"ZoomVideoSDKLiveTranscription_Status_Start" : @(ZoomVideoSDKLiveTranscriptionStatus_Start),
    }),
    ZoomVideoSDKLiveTranscriptionStatus_Stop,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(
    ZoomVideoSDKLiveTranscriptionOperationType,
    (@{
        @"ZoomVideoSDKLiveTranscription_OperationType_None" : @(ZoomVideoSDKLiveTranscriptionOperationType_None),
        @"ZoomVideoSDKLiveTranscription_OperationType_Add" : @(ZoomVideoSDKLiveTranscriptionOperationType_Add),
        @"ZoomVideoSDKLiveTranscription_OperationType_Update" : @(ZoomVideoSDKLiveTranscriptionOperationType_Update),
        @"ZoomVideoSDKLiveTranscription_OperationType_Delete" : @(ZoomVideoSDKLiveTranscriptionOperationType_Delete),
        @"ZoomVideoSDKLiveTranscription_OperationType_Complete" : @(ZoomVideoSDKLiveTranscriptionOperationType_Complete),
        @"ZoomVideoSDKLiveTranscription_OperationType_NotSupported" : @(ZoomVideoSDKLiveTranscriptionOperationType_NotSupported),
    }),
    ZoomVideoSDKLiveTranscriptionOperationType_None,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(
        ZoomVideoSDKSystemPermissionType,
    (@{
            @"ZoomVideoSDKSystemPermissionType_Camera" : @(ZoomVideoSDKSystemPermissionType_Camera),
            @"ZoomVideoSDKSystemPermissionType_Microphone" : @(ZoomVideoSDKSystemPermissionType_Microphone),
    }),
    ZoomVideoSDKSystemPermissionType_Camera,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(
    ZoomVideoSDKDialInNumType,
    (@{
            @"ZoomVideoSDKDialInNumType_None" : @(ZoomVideoSDKDialInNumType_None),
            @"ZoomVideoSDKDialInNumType_Toll" : @(ZoomVideoSDKDialInNumType_Toll),
            @"ZoomVideoSDKDialInNumType_TollFree" : @(ZoomVideoSDKDialInNumType_TollFree),
    }),
    ZoomVideoSDKDialInNumType_None,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(
    ZoomVideoSDKRecordAgreementType,
    (@{
            @"ConsentType_Invalid" : @(ZoomVideoSDKRecordAgreementType_Invalid),
            @"ConsentType_Traditional" : @(ZoomVideoSDKRecordAgreementType_Traditional),
            @"ConsentType_Individual" : @(ZoomVideoSDKRecordAgreementType_Individual_Only),
    }),
    ZoomVideoSDKRecordAgreementType_Traditional,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(
    ZoomVideoSDKNetworkStatus,
    (@{
            @"ZoomVideoSDKNetwork_None" : @(ZoomVideoSDKNetworkStatus_None),
            @"ZoomVideoSDKNetwork_Good" : @(ZoomVideoSDKNetworkStatus_Good),
            @"ZoomVideoSDKNetwork_Normal" : @(ZoomVideoSDKNetworkStatus_Normal),
            @"ZoomVideoSDKNetwork_Bad" : @(ZoomVideoSDKNetworkStatus_Bad),
    }),
    ZoomVideoSDKNetworkStatus_None,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(

     ZoomVideoSDKVirtualBackgroundDataType,
     (@{
             @"ZoomVideoSDKVirtualBackgroundDataType_Blur" : @(ZoomVideoSDKVirtualBackgroundDataType_Blur),
             @"ZoomVideoSDKVirtualBackgroundDataType_Image" : @(ZoomVideoSDKVirtualBackgroundDataType_Image),
             @"ZoomVideoSDKVirtualBackgroundDataType_None" : @(ZoomVideoSDKVirtualBackgroundDataType_None),
     }),
     ZoomVideoSDKVirtualBackgroundDataType_None,
     integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(

    ZoomVideoSDKCRCCallStatus,
    (@{
            @"ZoomVideoSDKCRCCallOutStatus_Success" : @(ZoomVideoSDKCRCCallStatus_Success),
            @"ZoomVideoSDKCRCCallOutStatus_Ring" : @(ZoomVideoSDKCRCCallStatus_Ring),
            @"ZoomVideoSDKCRCCallOutStatus_Timeout" : @(ZoomVideoSDKCRCCallStatus_Timeout),
            @"ZoomVideoSDKCRCCallOutStatus_Busy" : @(ZoomVideoSDKCRCCallStatus_Busy),
            @"ZoomVideoSDKCRCCallOutStatus_Decline" : @(ZoomVideoSDKCRCCallStatus_Decline),
            @"ZoomVideoSDKCRCCallOutStatus_Failed" : @(ZoomVideoSDKCRCCallStatus_Failed),
    }),
    ZoomVideoSDKCRCCallStatus_Failed,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(

    ZoomVideoSDKCRCProtocol,
    (@{
            @"ZoomVideoSDKCRCProtocol_H323" : @(ZoomVideoSDKCRCProtocol_H323),
            @"ZoomVideoSDKCRCProtocol_SIP" : @(ZoomVideoSDKCRCProtocol_SIP),
    }),
    ZoomVideoSDKCRCProtocol_H323,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(

     ZoomVideoSDKChatPrivilegeType,
     (@{
             @"ZoomVideoSDKChatPrivilege_No_One" : @(ZoomVideoSDKChatPrivilege_No_One),
             @"ZoomVideoSDKChatPrivilege_Publicly" : @(ZoomVideoSDKChatPrivilege_Everyone_Publicly),
             @"ZoomVideoSDKChatPrivilege_Publicly_And_Privately" : @(ZoomVideoSDKChatPrivilege_Everyone_Publicly_And_Privately),
             @"ZoomVideoSDKChatPrivilege_Unknown" : @(ZoomVideoSDKChatPrivilege_Unknown),
     }),
     ZoomVideoSDKChatPrivilege_Unknown,
     integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(

    ZoomVideoSDKAnnotationToolType,
    (@{
            @"ZoomVideoSDKAnnotationToolType_None" : @(ZoomVideoSDKAnnotationToolType_None),
            @"ZoomVideoSDKAnnotationToolType_Pen" : @(ZoomVideoSDKAnnotationToolType_Pen),
            @"ZoomVideoSDKAnnotationToolType_HighLighter" : @(ZoomVideoSDKAnnotationToolType_HighLighter),
            @"ZoomVideoSDKAnnotationToolType_AutoLine" : @(ZoomVideoSDKAnnotationToolType_AutoLine),
            @"ZoomVideoSDKAnnotationToolType_AutoRectangle" : @(ZoomVideoSDKAnnotationToolType_AutoRectangle),
            @"ZoomVideoSDKAnnotationToolType_AutoEllipse" : @(ZoomVideoSDKAnnotationToolType_AutoEllipse),
            @"ZoomVideoSDKAnnotationToolType_AutoArrow" : @(ZoomVideoSDKAnnotationToolType_AutoArrow),
            @"ZoomVideoSDKAnnotationToolType_AutoRectangleFill" : @(ZoomVideoSDKAnnotationToolType_AutoRectangleFill),
            @"ZoomVideoSDKAnnotationToolType_AutoEllipseFill": @(ZoomVideoSDKAnnotationToolType_AutoEllipseFill),
            @"ZoomVideoSDKAnnotationToolType_SpotLight": @(ZoomVideoSDKAnnotationToolType_SpotLight),
            @"ZoomVideoSDKAnnotationToolType_Arrow": @(ZoomVideoSDKAnnotationToolType_Arrow),
            @"ZoomVideoSDKAnnotationToolType_Eraser": @(ZoomVideoSDKAnnotationToolType_ERASER),
            @"ZoomVideoSDKAnnotationToolType_Picker": @(ZoomVideoSDKAnnotationToolType_Picker),
            @"ZoomVideoSDKAnnotationToolType_AutoRectangleSemiFill": @(ZoomVideoSDKAnnotationToolType_AutoRectangleSemiFill),
            @"ZoomVideoSDKAnnotationToolType_AutoEllipseSemiFill": @(ZoomVideoSDKAnnotationToolType_AutoEllipseSemiFill),
            @"ZoomVideoSDKAnnotationToolType_AutoDoubleArrow": @(ZoomVideoSDKAnnotationToolType_AutoDoubleArrow),
            @"ZoomVideoSDKAnnotationToolType_AutoDiamond": @(ZoomVideoSDKAnnotationToolType_AutoDiamond),
            @"ZoomVideoSDKAnnotationToolType_AutoStampArrow": @(ZoomVideoSDKAnnotationToolType_AutoStampArrow),
            @"ZoomVideoSDKAnnotationToolType_AutoStampCheck": @(ZoomVideoSDKAnnotationToolType_AutoStampCheck),
            @"ZoomVideoSDKAnnotationToolType_AutoStampX": @(ZoomVideoSDKAnnotationToolType_AutoStampX),
            @"ZoomVideoSDKAnnotationToolType_AutoStampStar": @(ZoomVideoSDKAnnotationToolType_AutoStampStar),
            @"ZoomVideoSDKAnnotationToolType_AutoStampHeart": @(ZoomVideoSDKAnnotationToolType_AutoStampHeart),
            @"ZoomVideoSDKAnnotationToolType_AutoStampQm" : @(ZoomVideoSDKAnnotationToolType_AutoStampQm),
            @"ZoomVideoSDKAnnotationToolType_VanishingPen" : @(ZoomVideoSDKAnnotationToolType_VanishingPen),
            @"ZoomVideoSDKAnnotationToolType_VanishingArrow" : @(ZoomVideoSDKAnnotationToolType_VanishingArrow),
            @"ZoomVideoSDKAnnotationToolType_VanishingDoubleArrow" : @(ZoomVideoSDKAnnotationToolType_VanishingDoubleArrow),
            @"ZoomVideoSDKAnnotationToolType_VanishingEllipse" : @(ZoomVideoSDKAnnotationToolType_VanishingEllipse),
            @"ZoomVideoSDKAnnotationToolType_VanishingRectangle" : @(ZoomVideoSDKAnnotationToolType_VanishingRectangle),
            @"ZoomVideoSDKAnnotationToolType_VanishingDiamond" : @(ZoomVideoSDKAnnotationToolType_VanishingDiamond),
    }),
    ZoomVideoSDKAnnotationToolType_None,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(

    ZoomVideoSDKAnnotationClearType,
    (@{
            @"ZoomVideoSDKAnnotationClearType_All" : @(ZoomVideoSDKAnnotationClearType_All),
            @"ZoomVideoSDKAnnotationClearType_Others" : @(ZoomVideoSDKAnnotationClearType_Others),
            @"ZoomVideoSDKAnnotationClearType_My" : @(ZoomVideoSDKAnnotationClearType_My),
    }),
    ZoomVideoSDKAnnotationClearType_Others,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(

    ZoomVideoSDKSubscribeFailReason,
    (@{
            @"ZoomVideoSDKSubscribeFailReason_HasSubscribe1080POr720P" : @(ZoomVideoSDKSubscribeFailReason_HasSubscribe1080POr720P),
            @"ZoomVideoSDKSubscribeFailReason_HasSubscribeShare" : @(ZoomVideoSDKSubscribeFailReason_HasSubscribeShare),
            @"ZoomVideoSDKSubscribeFailReason_HasSubscribeOneShare" : @(ZoomVideoSDKSubscribeFailReason_HasSubscribeOneShare),
            @"ZoomVideoSDKSubscribeFailReason_HasSubscribeExceededLimit" : @(ZoomVideoSDKSubscribeFailReason_HasSubscribeExceededLimit),
            @"ZoomVideoSDKSubscribeFailReason_None" : @(ZoomVideoSDKSubscribeFailReason_None),
    }),
    ZoomVideoSDKSubscribeFailReason_None,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(

    ZoomVideoSDKTestMicStatus,
    (@{
            @"ZoomVideoSDKMic_CanTest" : @(ZoomVideoSDKMic_CanTest),
            @"ZoomVideoSDKMic_Recording" : @(ZoomVideoSDKMic_Recording),
            @"ZoomVideoSDKMic_CanPlay" : @(ZoomVideoSDKMic_CanPlay),
    }),
    ZoomVideoSDKMic_CanTest,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(

    ZoomVideoSDKSessionLeaveReason,
    (@{
            @"ZoomVideoSDKSessionLeaveReason_Unknown" : @(ZoomVideoSDKSessionLeaveReason_Unknown),
            @"ZoomVideoSDKSessionLeaveReason_BySelf" : @(ZoomVideoSDKSessionLeaveReason_BySelf),
            @"ZoomVideoSDKSessionLeaveReason_KickByHost" : @(ZoomVideoSDKSessionLeaveReason_KickByHost),
            @"ZoomVideoSDKSessionLeaveReason_EndByHost" : @(ZoomVideoSDKSessionLeaveReason_EndByHost),
            @"ZoomVideoSDKSessionLeaveReason_NetworkError" : @(ZoomVideoSDKSessionLeaveReason_NetworkError),
    }),
    ZoomVideoSDKSessionLeaveReason_Unknown,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(

    AVCaptureDevicePosition,
    (@{
            @"AVCaptureDevicePositionUnspecified" : @(AVCaptureDevicePositionUnspecified),
            @"AVCaptureDevicePositionBack" : @(AVCaptureDevicePositionBack),
            @"AVCaptureDevicePositionFront" : @(AVCaptureDevicePositionFront),
    }),
    AVCaptureDevicePositionUnspecified,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(

    ZoomVideoSDKUVCCameraStatus,
    (@{
            @"ZoomVideoSDKUVCCameraStatus_Attached" : @(ZoomVideoSDKUVCCameraStatus_Attached),
            @"ZoomVideoSDKUVCCameraStatus_Detached" : @(ZoomVideoSDKUVCCameraStatus_Detached),
    }),
    AVCaptureDevicePositionUnspecified,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(

    ZoomVideoSDKShareType,
    (@{
            @"ZoomVideoSDKShareType_None" : @(ZoomVideoSDKShareType_None),
            @"ZoomVideoSDKShareType_Normal" : @(ZoomVideoSDKShareType_Normal),
            @"ZoomVideoSDKShareType_Camera" : @(ZoomVideoSDKShareType_Camera),
            @"ZoomVideoSDKShareType_PureAudio" : @(ZoomVideoSDKShareType_PureAudio),
    }),
    AVCaptureDevicePositionUnspecified,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(

    ZoomVideoSDKPreferVideoResolution,
    (@{
            @"ZoomVideoSDKPreferVideoResolution_None" : @(ZoomVideoSDKPreferVideoResolution_None),
            @"ZoomVideoSDKPreferVideoResolution_360P" : @(ZoomVideoSDKPreferVideoResolution_360P),
            @"ZoomVideoSDKPreferVideoResolution_720P" : @(ZoomVideoSDKPreferVideoResolution_720P),
    }),
    AVCaptureDevicePositionUnspecified,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(

    ZoomVideoSDKDataType,
    (@{
            @"ZoomVideoSDKDataType_Audio" : @(ZoomVideoSDKDataType_Audio),
            @"ZoomVideoSDKDataType_Share" : @(ZoomVideoSDKDataType_Share),
            @"ZoomVideoSDKDataType_Video" : @(ZoomVideoSDKDataType_Video),
            @"ZoomVideoSDKDataType_Unknown" : @(ZoomVideoSDKDataType_Unknown),
    }),
    AVCaptureDevicePositionUnspecified,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(

    ZoomVideoSDKWhiteboardExportFormatType,
    (@{
            @"ZoomVideoSDKWhiteboardExport_Format_PDF" : @(ZoomVideoSDKWhiteboardExport_Format_PDF),
    }),
    AVCaptureDevicePositionUnspecified,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(

    
    ZoomVideoSDKWhiteboardStatus,
    (@{
            @"WhiteboardStatus_Started" : @(ZoomVideoSDKWhiteboardStatus_Started),
            @"WhiteboardStatus_Stopped" : @(ZoomVideoSDKWhiteboardStatus_Stopped),
    }),
    AVCaptureDevicePositionUnspecified,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(

    
    ZoomVideoSDKSubSessionStatus,
    (@{
            @"ZoomVideoSDKSubSessionStatus_None" : @(ZoomVideoSDKSubSessionStatus_None),
            @"ZoomVideoSDKSubSessionStatus_Started" : @(ZoomVideoSDKSubSessionStatus_Started),
            @"ZoomVideoSDKSubSessionStatus_Stopped" : @(ZoomVideoSDKSubSessionStatus_Stopped),
            @"ZoomVideoSDKSubSessionStatus_Stopping" : @(ZoomVideoSDKSubSessionStatus_Stopping),
            @"ZoomVideoSDKSubSessionStatus_StartFailed" : @(ZoomVideoSDKSubSessionStatus_StartFailed),
            @"ZoomVideoSDKSubSessionStatus_StopFailed" : @(ZoomVideoSDKSubSessionStatus_StopFailed),
            @"ZoomVideoSDKSubSessionStatus_Withdrawn" : @(ZoomVideoSDKSubSessionStatus_Withdrawn),
            @"ZoomVideoSDKSubSessionStatus_WithdrawFailed" : @(ZoomVideoSDKSubSessionStatus_WithdrawFailed),
            @"ZoomVideoSDKSubSessionStatus_Committed" : @(ZoomVideoSDKSubSessionStatus_Committed),
            @"ZoomVideoSDKSubSessionStatus_CommitFailed" : @(ZoomVideoSDKSubSessionStatus_CommitFailed),
    }),
    AVCaptureDevicePositionUnspecified,
    integerValue
)

RCT_ENUM_CONVERTER_WITH_REVERSED(

    
    ZoomVideoSDKUserHelpRequestResult,
    (@{
            @"ZoomVideoSDKUserHelpRequestResult_Idle" : @(ZoomVideoSDKUserHelpRequestResult_Idle),
            @"ZoomVideoSDKUserHelpRequestResult_Busy" : @(ZoomVideoSDKUserHelpRequestResult_Busy),
            @"ZoomVideoSDKUserHelpRequestResult_Ignore" : @(ZoomVideoSDKUserHelpRequestResult_Ignore),
            @"ZoomVideoSDKUserHelpRequestResult_HostAlreadyInSubSession" : @(ZoomVideoSDKUserHelpRequestResult_HostAlreadyInSubSession),
    }),
    AVCaptureDevicePositionUnspecified,
    integerValue
)

@end
