package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKPreferVideoResolution;

public class FlutterZoomVideoSdkPreferVideoResolution {

    private static final Map<String, ZoomVideoSDKPreferVideoResolution> resolutionMap =
            new HashMap<String, ZoomVideoSDKPreferVideoResolution>() {{
                put("ZoomVideoSDKPreferVideoResolution_None", ZoomVideoSDKPreferVideoResolution.ZoomVideoSDKPreferVideoResolution_None);
                put("ZoomVideoSDKPreferVideoResolution_360P", ZoomVideoSDKPreferVideoResolution.ZoomVideoSDKPreferVideoResolution_360P);
                put("ZoomVideoSDKPreferVideoResolution_720P", ZoomVideoSDKPreferVideoResolution.ZoomVideoSDKPreferVideoResolution_720P);
            }};

    public static ZoomVideoSDKPreferVideoResolution valueOf(String name) {
        ZoomVideoSDKPreferVideoResolution resolution;
        resolution = resolutionMap.getOrDefault(name, ZoomVideoSDKPreferVideoResolution.ZoomVideoSDKPreferVideoResolution_None);
        return resolution;
    }
}
