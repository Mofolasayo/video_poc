package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKTestMicStatus;

public class FlutterZoomVideoSdkTestMicStatus {

    private static final Map<ZoomVideoSDKTestMicStatus, String> testStatus =
            new HashMap<ZoomVideoSDKTestMicStatus, String>() {{
                put(ZoomVideoSDKTestMicStatus.ZoomVideoSDKMic_CanPlay, "ZoomVideoSDKMic_CanPlay");
                put(ZoomVideoSDKTestMicStatus.ZoomVideoSDKMic_Recording, "ZoomVideoSDKMic_Recording");
                put(ZoomVideoSDKTestMicStatus.ZoomVideoSDKMic_CanTest, "ZoomVideoSDKMic_CanTest");
            }};

    public static String valueOf(ZoomVideoSDKTestMicStatus name) {
        if (name == null) return "ZoomVideoSDKTestMicStatus_None";

        String result;
        result = testStatus.containsKey(name)? testStatus.get(name) : "ZoomVideoSDKTestMicStatus_None";
        return result;

    }
}