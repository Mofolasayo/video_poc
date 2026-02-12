package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKVideoPreferenceMode;

public class FlutterZoomVideoSdkVideoPreferenceMode {

    private static final Map<String, ZoomVideoSDKVideoPreferenceMode> videoPreference =
            new HashMap<String, ZoomVideoSDKVideoPreferenceMode>() {{
                put("ZoomVideoSDKVideoPreferenceMode_Balance", ZoomVideoSDKVideoPreferenceMode.ZoomVideoSDKVideoPreferenceMode_Balance);
                put("ZoomVideoSDKVideoPreferenceMode_Smoothness", ZoomVideoSDKVideoPreferenceMode.ZoomVideoSDKVideoPreferenceMode_Smoothness);
                put("ZoomVideoSDKVideoPreferenceMode_Sharpness", ZoomVideoSDKVideoPreferenceMode.ZoomVideoSDKVideoPreferenceMode_Sharpness);
                put("ZoomVideoSDKVideoPreferenceMode_Custom", ZoomVideoSDKVideoPreferenceMode.ZoomVideoSDKVideoPreferenceMode_Custom);
            }};

    public static ZoomVideoSDKVideoPreferenceMode valueOf(String name) {
        if (name == null) return ZoomVideoSDKVideoPreferenceMode.ZoomVideoSDKVideoPreferenceMode_Balance;

        ZoomVideoSDKVideoPreferenceMode preference;
        preference = videoPreference.containsKey(name)? videoPreference.get(name) : ZoomVideoSDKVideoPreferenceMode.ZoomVideoSDKVideoPreferenceMode_Balance;

        return preference;
    }

}
