package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKShareStatus;

public class FlutterZoomVideoSdkShareStatus {

    private static final Map<ZoomVideoSDKShareStatus, String> shareStatus =
            new HashMap<ZoomVideoSDKShareStatus, String>() {{
                put(ZoomVideoSDKShareStatus.ZoomVideoSDKShareStatus_Start, "ZoomVideoSDKShareStatus_Start");
                put(ZoomVideoSDKShareStatus.ZoomVideoSDKShareStatus_Stop, "ZoomVideoSDKShareStatus_Stop");
                put(ZoomVideoSDKShareStatus.ZoomVideoSDKShareStatus_Resume, "ZoomVideoSDKShareStatus_Resume");
                put(ZoomVideoSDKShareStatus.ZoomVideoSDKShareStatus_Pause, "ZoomVideoSDKShareStatus_Pause");
                put(ZoomVideoSDKShareStatus.ZoomVideoSDKShareStatus_None, "ZoomVideoSDKShareStatus_None");
            }};

    public static String valueOf(ZoomVideoSDKShareStatus name) {
        if (name == null) return "ZoomVideoSDKShareStatus_None";

        String result;
        result = shareStatus.containsKey(name)? shareStatus.get(name) : "ZoomVideoSDKShareStatus_None";
        return result;

    }
}
