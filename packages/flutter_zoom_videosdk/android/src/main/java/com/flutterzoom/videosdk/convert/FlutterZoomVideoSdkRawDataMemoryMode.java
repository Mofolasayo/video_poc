package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKRawDataMemoryMode;

public class FlutterZoomVideoSdkRawDataMemoryMode {

    private static final Map<String, ZoomVideoSDKRawDataMemoryMode> rawDataMemoryMode =
            new HashMap<String, ZoomVideoSDKRawDataMemoryMode>() {{
                put("ZoomVideoSDKRawDataMemoryModeHeap", ZoomVideoSDKRawDataMemoryMode.ZoomVideoSDKRawDataMemoryModeHeap);
                put("ZoomVideoSDKRawDataMemoryModeStack", ZoomVideoSDKRawDataMemoryMode.ZoomVideoSDKRawDataMemoryModeStack);
            }};

    public static ZoomVideoSDKRawDataMemoryMode valueOf(String name) {
        if (name == null) return ZoomVideoSDKRawDataMemoryMode.ZoomVideoSDKRawDataMemoryModeHeap;

        ZoomVideoSDKRawDataMemoryMode mode;
        mode = rawDataMemoryMode.containsKey(name)? rawDataMemoryMode.get(name) : ZoomVideoSDKRawDataMemoryMode.ZoomVideoSDKRawDataMemoryModeHeap;

        return mode;
    }
}
