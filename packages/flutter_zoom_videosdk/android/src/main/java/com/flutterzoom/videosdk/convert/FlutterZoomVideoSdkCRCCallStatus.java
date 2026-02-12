package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKCRCCallStatus;

public class FlutterZoomVideoSdkCRCCallStatus {

    private static final Map<ZoomVideoSDKCRCCallStatus, String> statusMap =
            new HashMap<ZoomVideoSDKCRCCallStatus, String>() {{
                put(ZoomVideoSDKCRCCallStatus.ZoomVideoSDKCRCCallOutStatus_Success, "ZoomVideoSDKCRCCallOutStatus_Success");
                put(ZoomVideoSDKCRCCallStatus.ZoomVideoSDKCRCCallOutStatus_Ring, "ZoomVideoSDKCRCCallOutStatus_Ring");
                put(ZoomVideoSDKCRCCallStatus.ZoomVideoSDKCRCCallOutStatus_Timeout, "ZoomVideoSDKCRCCallOutStatus_Timeout");
                put(ZoomVideoSDKCRCCallStatus.ZoomVideoSDKCRCCallOutStatus_Busy, "ZoomVideoSDKCRCCallOutStatus_Busy");
                put(ZoomVideoSDKCRCCallStatus.ZoomVideoSDKCRCCallOutStatus_Decline, "ZoomVideoSDKCRCCallOutStatus_Decline");
                put(ZoomVideoSDKCRCCallStatus.ZoomVideoSDKCRCCallOutStatus_Failed, "ZoomVideoSDKCRCCallOutStatus_Failed");
            }};

    public static String valueOf(ZoomVideoSDKCRCCallStatus name) {
        if (name == null) return "ZoomVideoSDKCRCCallOutStatus_Failed";

        return statusMap.containsKey(name) ? statusMap.get(name) : "ZoomVideoSDKCRCCallOutStatus_Failed";
    }
}
