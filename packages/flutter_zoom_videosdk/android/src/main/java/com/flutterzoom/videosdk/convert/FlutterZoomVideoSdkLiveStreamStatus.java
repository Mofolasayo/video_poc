package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKLiveStreamStatus;

public class FlutterZoomVideoSdkLiveStreamStatus {

    private static final Map<ZoomVideoSDKLiveStreamStatus, String> liveStreamStatus =
            new HashMap<ZoomVideoSDKLiveStreamStatus, String>() {{
                put(ZoomVideoSDKLiveStreamStatus.ZoomVideoSDKLiveStreamStatus_None, "ZoomVideoSDKLiveStreamStatus_None");
                put(ZoomVideoSDKLiveStreamStatus.ZoomVideoSDKLiveStreamStatus_InProgress, "ZoomVideoSDKLiveStreamStatus_InProgress");
                put(ZoomVideoSDKLiveStreamStatus.ZoomVideoSDKLiveStreamStatus_Connecting, "ZoomVideoSDKLiveStreamStatus_Connecting");
                put(ZoomVideoSDKLiveStreamStatus.ZoomVideoSDKLiveStreamStatus_FailedTimeout, "ZoomVideoSDKLiveStreamStatus_FailedTimeout");
                put(ZoomVideoSDKLiveStreamStatus.ZoomVideoSDKLiveStreamStatus_StartFailed, "ZoomVideoSDKLiveStreamStatus_StartFailed");
                put(ZoomVideoSDKLiveStreamStatus.ZoomVideoSDKLiveStreamStatus_Ended, "ZoomVideoSDKLiveStreamStatus_Ended");
            }};

    public static String valueOf(ZoomVideoSDKLiveStreamStatus name) {
        if (name == null) return "ZoomVideoSDKLiveStreamStatus_None";

        String result;
        result = liveStreamStatus.containsKey(name)? liveStreamStatus.get(name) : "ZoomVideoSDKLiveStreamStatus_None";
        return result;
    }

}
