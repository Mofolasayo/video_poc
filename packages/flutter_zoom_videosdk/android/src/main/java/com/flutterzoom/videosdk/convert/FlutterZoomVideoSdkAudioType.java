package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKAudioStatus;

public class FlutterZoomVideoSdkAudioType {

    private static final Map<ZoomVideoSDKAudioStatus.ZoomVideoSDKAudioType, String> audioTypeStringMap =
            new HashMap<ZoomVideoSDKAudioStatus.ZoomVideoSDKAudioType, String>() {{
                put(ZoomVideoSDKAudioStatus.ZoomVideoSDKAudioType.ZoomVideoSDKAudioType_None, "ZoomVideoSDKAudioType_None");
                put(ZoomVideoSDKAudioStatus.ZoomVideoSDKAudioType.ZoomVideoSDKAudioType_VOIP, "ZoomVideoSDKAudioType_VOIP");
                put(ZoomVideoSDKAudioStatus.ZoomVideoSDKAudioType.ZoomVideoSDKAudioType_TELEPHONY, "ZoomVideoSDKAudioType_Telephony");
            }};

    public static String valueOf(ZoomVideoSDKAudioStatus.ZoomVideoSDKAudioType audioType) {
        if (audioType == null) return "ZoomVideoSDKAudioType_None";

        String result;
        result = audioTypeStringMap.containsKey(audioType)? audioTypeStringMap.get(audioType) : "ZoomVideoSDKAudioType_None";
        return result;
    }

}
