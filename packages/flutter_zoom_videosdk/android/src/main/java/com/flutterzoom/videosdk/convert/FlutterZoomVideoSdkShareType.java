package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKLiveStreamStatus;
import us.zoom.sdk.ZoomVideoSDKShareType;

public class FlutterZoomVideoSdkShareType {
    private static final Map<ZoomVideoSDKShareType, String> shareType =
            new HashMap<ZoomVideoSDKShareType, String>() {{
                put(ZoomVideoSDKShareType.ZoomVideoSDKShareType_None, "ZoomVideoSDKShareType_None");
                put(ZoomVideoSDKShareType.ZoomVideoSDKShareType_Normal, "ZoomVideoSDKShareType_Normal");
                put(ZoomVideoSDKShareType.ZoomVideoSDKShareType_PureAudio, "ZoomVideoSDKShareType_PureAudio");
                put(ZoomVideoSDKShareType.ZoomVideoSDKShareType_Camera, "ZoomVideoSDKShareType_Camera");
            }};

    public static String valueOf(ZoomVideoSDKShareType name) {
        if (name == null) return "ZoomVideoSDKShareType_None";

        String result;
        result = shareType.containsKey(name)? shareType.get(name) : "ZoomVideoSDKShareType_None";
        return result;
    }
}
