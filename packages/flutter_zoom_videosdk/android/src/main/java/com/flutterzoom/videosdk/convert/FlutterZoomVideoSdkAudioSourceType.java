package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKAudioHelper.ZoomVideoSDKAudioSourceType;

public class FlutterZoomVideoSdkAudioSourceType {
    private static final Map<ZoomVideoSDKAudioSourceType, String> audioSourceTypeStringMap =
            new HashMap<ZoomVideoSDKAudioSourceType, String>() {{
                put(ZoomVideoSDKAudioSourceType.AUDIO_SOURCE_NONE, "AUDIO_SOURCE_NONE");
                put(ZoomVideoSDKAudioSourceType.AUDIO_SOURCE_BLUETOOTH, "AUDIO_SOURCE_BLUETOOTH");
                put(ZoomVideoSDKAudioSourceType.AUDIO_SOURCE_WIRED, "AUDIO_SOURCE_WIRED");
                put(ZoomVideoSDKAudioSourceType.AUDIO_SOURCE_EAR_PHONE, "AUDIO_SOURCE_EAR_PHONE");
                put(ZoomVideoSDKAudioSourceType.AUDIO_SOURCE_SPEAKER_PHONE, "AUDIO_SOURCE_SPEAKER_PHONE");
            }};

    public static String valueOf(ZoomVideoSDKAudioSourceType audioSourceType) {
        if (audioSourceType == null) return "AUDIO_SOURCE_NONE";

        String result;
        result = audioSourceTypeStringMap.getOrDefault(audioSourceType, "AUDIO_SOURCE_NONE");
        return result;
    }
}
