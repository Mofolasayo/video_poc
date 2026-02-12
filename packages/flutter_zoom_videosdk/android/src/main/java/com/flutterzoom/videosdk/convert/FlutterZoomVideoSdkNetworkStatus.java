package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKNetworkStatus;

public class FlutterZoomVideoSdkNetworkStatus {
    private static final Map<ZoomVideoSDKNetworkStatus, String> networkStatus =
            new HashMap<ZoomVideoSDKNetworkStatus, String>() {{
                put(ZoomVideoSDKNetworkStatus.ZoomVideoSDKNetwork_Normal, "ZoomVideoSDKNetwork_Normal");
                put(ZoomVideoSDKNetworkStatus.ZoomVideoSDKNetwork_Good, "ZoomVideoSDKNetwork_Good");
                put(ZoomVideoSDKNetworkStatus.ZoomVideoSDKNetwork_Bad, "ZoomVideoSDKNetwork_Bad");
                put(ZoomVideoSDKNetworkStatus.ZoomVideoSDKNetwork_None, "ZoomVideoSDKNetwork_None");
            }};

    public static String valueOf(ZoomVideoSDKNetworkStatus name) {
        if (name == null) return "ZoomVideoSDKNetwork_None";

        String result;
        result = networkStatus.getOrDefault(name, "ZoomVideoSDKNetwork_None");
        return result;
    }
}
