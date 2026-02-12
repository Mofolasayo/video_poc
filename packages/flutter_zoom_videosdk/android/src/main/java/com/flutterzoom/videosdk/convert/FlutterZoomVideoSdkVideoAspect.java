package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKVideoAspect;

public class FlutterZoomVideoSdkVideoAspect {

    private static final Map<String, ZoomVideoSDKVideoAspect> videoAspect =
            new HashMap<String, ZoomVideoSDKVideoAspect>() {{
                put("ZoomVideoSDKVideoAspect_Original", ZoomVideoSDKVideoAspect.ZoomVideoSDKVideoAspect_Original);
                put("ZoomVideoSDKVideoAspect_Full_Filled", ZoomVideoSDKVideoAspect.ZoomVideoSDKVideoAspect_Full_Filled);
                put("ZoomVideoSDKVideoAspect_LetterBox", ZoomVideoSDKVideoAspect.ZoomVideoSDKVideoAspect_LetterBox);
                put("ZoomVideoSDKVideoAspect_PanAndScan", ZoomVideoSDKVideoAspect.ZoomVideoSDKVideoAspect_PanAndScan);
            }};

    public static ZoomVideoSDKVideoAspect valueOf(String name) {
        if (name == null) return ZoomVideoSDKVideoAspect.ZoomVideoSDKVideoAspect_Original;

        ZoomVideoSDKVideoAspect aspect;
        aspect = videoAspect.containsKey(name)? videoAspect.get(name) : ZoomVideoSDKVideoAspect.ZoomVideoSDKVideoAspect_Original;

        return aspect;
    }
}
