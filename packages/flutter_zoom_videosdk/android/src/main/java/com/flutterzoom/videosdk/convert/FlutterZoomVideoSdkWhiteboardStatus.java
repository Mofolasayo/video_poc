package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKWhiteboardStatus;

public class FlutterZoomVideoSdkWhiteboardStatus {

    private static final Map<ZoomVideoSDKWhiteboardStatus, String> whiteboardStatus =
            new HashMap<ZoomVideoSDKWhiteboardStatus, String>() {{
                put(ZoomVideoSDKWhiteboardStatus.WhiteboardStatus_Started, "WhiteboardStatus_Started");
                put(ZoomVideoSDKWhiteboardStatus.WhiteboardStatus_Stopped, "WhiteboardStatus_Stopped");
            }};

    public static String valueOf(ZoomVideoSDKWhiteboardStatus name) {
        if (name == null) return "WhiteboardStatus_Stopped";

        String result;
        result = whiteboardStatus.getOrDefault(name, "WhiteboardStatus_Stopped");
        return result;
    }
}
