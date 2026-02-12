package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKVideoResolution;

public class FlutterZoomVideoSdkVideoResolution {

    private static final Map<String, ZoomVideoSDKVideoResolution> videoResolution =
            new HashMap<String, ZoomVideoSDKVideoResolution>() {{
                put("ZoomVideoSDKVideoResolution_90", ZoomVideoSDKVideoResolution.VideoResolution_90P);
                put("ZoomVideoSDKVideoResolution_180", ZoomVideoSDKVideoResolution.VideoResolution_180P);
                put("ZoomVideoSDKVideoResolution_360", ZoomVideoSDKVideoResolution.VideoResolution_360P);
                put("ZoomVideoSDKVideoResolution_720", ZoomVideoSDKVideoResolution.VideoResolution_720P);
                put("ZoomVideoSDKVideoResolution_1080", ZoomVideoSDKVideoResolution.VideoResolution_1080P);
            }};

    public static ZoomVideoSDKVideoResolution valueOf(String name) {
        if (name == null) return ZoomVideoSDKVideoResolution.VideoResolution_90P;

        ZoomVideoSDKVideoResolution resolution;
        resolution = videoResolution.containsKey(name)? videoResolution.get(name) : ZoomVideoSDKVideoResolution.VideoResolution_90P;

        return resolution;
    }

}
