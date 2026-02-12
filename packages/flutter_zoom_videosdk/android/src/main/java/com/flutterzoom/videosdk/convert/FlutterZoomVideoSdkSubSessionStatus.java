package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKSubSessionStatus;

public class FlutterZoomVideoSdkSubSessionStatus {
    private static final Map<ZoomVideoSDKSubSessionStatus, String> subSessionStatus =
            new HashMap<ZoomVideoSDKSubSessionStatus, String>() {{
                put(ZoomVideoSDKSubSessionStatus.ZoomVideoSDKSubSessionStatus_StartFailed, "ZoomVideoSDKSubSessionStatus_StartFailed");
                put(ZoomVideoSDKSubSessionStatus.ZoomVideoSDKSubSessionStatus_StopFailed, "ZoomVideoSDKSubSessionStatus_StopFailed");
                put(ZoomVideoSDKSubSessionStatus.ZoomVideoSDKSubSessionStatus_Stopping, "ZoomVideoSDKSubSessionStatus_Stopping");
                put(ZoomVideoSDKSubSessionStatus.ZoomVideoSDKSubSessionStatus_Stopped, "ZoomVideoSDKSubSessionStatus_Stopped");
                put(ZoomVideoSDKSubSessionStatus.ZoomVideoSDKSubSessionStatus_Started, "ZoomVideoSDKSubSessionStatus_Started");
                put(ZoomVideoSDKSubSessionStatus.ZoomVideoSDKSubSessionStatus_Withdrawn, "ZoomVideoSDKSubSessionStatus_Withdrawn");
                put(ZoomVideoSDKSubSessionStatus.ZoomVideoSDKSubSessionStatus_WithdrawFailed, "ZoomVideoSDKSubSessionStatus_WithdrawFailed");
                put(ZoomVideoSDKSubSessionStatus.ZoomVideoSDKSubSessionStatus_Committed, "ZoomVideoSDKSubSessionStatus_Committed");
                put(ZoomVideoSDKSubSessionStatus.ZoomVideoSDKSubSessionStatus_CommitFailed, "ZoomVideoSDKSubSessionStatus_CommitFailed");
                put(ZoomVideoSDKSubSessionStatus.ZoomVideoSDKSubSessionStatus_None, "ZoomVideoSDKSubSessionStatus_None");
            }};

    public static String valueOf(ZoomVideoSDKSubSessionStatus name) {
        if (name == null) return "ZoomVideoSDKSubSessionStatus_None";

        String result;
        result = subSessionStatus.getOrDefault(name, "ZoomVideoSDKSubSessionStatus_None");
        return result;
    }
}
