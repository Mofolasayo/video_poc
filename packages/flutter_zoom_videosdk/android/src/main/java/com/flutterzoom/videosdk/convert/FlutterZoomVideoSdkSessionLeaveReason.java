package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKSessionLeaveReason;

public class FlutterZoomVideoSdkSessionLeaveReason {

    private static final Map<ZoomVideoSDKSessionLeaveReason, String> sessionLeaveReasons =
            new HashMap<ZoomVideoSDKSessionLeaveReason, String>() {{
                put(ZoomVideoSDKSessionLeaveReason.ZoomVideoSDKSessionLeaveReason_Unknown, "ZoomVideoSDKSessionLeaveReason_Unknown");
                put(ZoomVideoSDKSessionLeaveReason.ZoomVideoSDKSessionLeaveReason_BySelf, "ZoomVideoSDKSessionLeaveReason_BySelf");
                put(ZoomVideoSDKSessionLeaveReason.ZoomVideoSDKSessionLeaveReason_KickByHost, "ZoomVideoSDKSessionLeaveReason_KickByHost");
                put(ZoomVideoSDKSessionLeaveReason.ZoomVideoSDKSessionLeaveReason_EndByHost, "ZoomVideoSDKSessionLeaveReason_EndByHost");
                put(ZoomVideoSDKSessionLeaveReason.ZoomVideoSDKSessionLeaveReason_NetworkError, "ZoomVideoSDKSessionLeaveReason_NetworkError");
            }};

    public static String valueOf(ZoomVideoSDKSessionLeaveReason name) {
        if (name == null) return "ZoomVideoSDKSessionLeaveReason_None";

        String result;
        result = sessionLeaveReasons.containsKey(name)? sessionLeaveReasons.get(name) : "ZoomVideoSDKSessionLeaveReason_None";
        return result;
    }

}
