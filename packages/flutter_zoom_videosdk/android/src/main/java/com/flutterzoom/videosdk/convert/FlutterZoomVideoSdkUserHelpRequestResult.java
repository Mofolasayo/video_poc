package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKUserHelpRequestResult;

public class FlutterZoomVideoSdkUserHelpRequestResult {

    private static final Map<ZoomVideoSDKUserHelpRequestResult, String> userHelpRequestResult =
            new HashMap<ZoomVideoSDKUserHelpRequestResult, String>() {{
                put(ZoomVideoSDKUserHelpRequestResult.ZoomVideoSDKUserHelpRequestResult_Idle, "ZoomVideoSDKUserHelpRequestResult_Idle");
                put(ZoomVideoSDKUserHelpRequestResult.ZoomVideoSDKUserHelpRequestResult_Ignore, "ZoomVideoSDKUserHelpRequestResult_Ignore");
                put(ZoomVideoSDKUserHelpRequestResult.ZoomVideoSDKUserHelpRequestResult_Busy, "ZoomVideoSDKUserHelpRequestResult_Busy");
                put(ZoomVideoSDKUserHelpRequestResult.ZoomVideoSDKUserHelpRequestResult_HostAlreadyInSubSession, "ZoomVideoSDKUserHelpRequestResult_HostAlreadyInSubSession");
            }};

    public static String valueOf(ZoomVideoSDKUserHelpRequestResult name) {
        if (name == null) return "ZoomVideoSDKUserHelpRequestResult_Idle";

        String result;
        result = userHelpRequestResult.getOrDefault(name, "ZoomVideoSDKUserHelpRequestResult_Idle");
        return result;

    }
}
