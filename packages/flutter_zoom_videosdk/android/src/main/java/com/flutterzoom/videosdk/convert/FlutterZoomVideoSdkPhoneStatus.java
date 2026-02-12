package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKPhoneStatus;

public class FlutterZoomVideoSdkPhoneStatus {

    private static final Map<ZoomVideoSDKPhoneStatus, String> phoneStatus =
            new HashMap<ZoomVideoSDKPhoneStatus, String>() {{
                put(ZoomVideoSDKPhoneStatus.PhoneStatus_None, "ZoomVideoSDKPhoneStatus_None");
                put(ZoomVideoSDKPhoneStatus.PhoneStatus_Accepted, "ZoomVideoSDKPhoneStatus_Accepted");
                put(ZoomVideoSDKPhoneStatus.PhoneStatus_Calling, "ZoomVideoSDKPhoneStatus_Calling");
                put(ZoomVideoSDKPhoneStatus.PhoneStatus_Cancel_Failed, "ZoomVideoSDKPhoneStatus_Cancel_Failed");
                put(ZoomVideoSDKPhoneStatus.PhoneStatus_Canceled, "ZoomVideoSDKPhoneStatus_Canceled");
                put(ZoomVideoSDKPhoneStatus.PhoneStatus_Canceling, "ZoomVideoSDKPhoneStatus_Canceling");
                put(ZoomVideoSDKPhoneStatus.PhoneStatus_Ringing, "ZoomVideoSDKPhoneStatus_Ringing");
                put(ZoomVideoSDKPhoneStatus.PhoneStatus_Success, "ZoomVideoSDKPhoneStatus_Success");
                put(ZoomVideoSDKPhoneStatus.PhoneStatus_Timeout, "ZoomVideoSDKPhoneStatus_Timeout");
                put(ZoomVideoSDKPhoneStatus.PhoneStatus_Failed, "ZoomVideoSDKPhoneStatus_Failed");
            }};

    public static String valueOf(ZoomVideoSDKPhoneStatus name) {
        if (name == null) return "ZoomVideoSDKPhoneStatus_None";

        String result;
        result = phoneStatus.containsKey(name)? phoneStatus.get(name) : "ZoomVideoSDKPhoneStatus_None";
        return result;
    }

}
