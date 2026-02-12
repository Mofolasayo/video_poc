package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKVirtualBackgroundDataType;

public class FlutterZoomVideoSdkVirtualBackgroundDataType {

    private static final Map<ZoomVideoSDKVirtualBackgroundDataType, String> virtualBackgroundDataType =
            new HashMap<ZoomVideoSDKVirtualBackgroundDataType, String>() {{
                put(ZoomVideoSDKVirtualBackgroundDataType.ZoomVideoSDKVirtualBackgroundDataType_Blur, "ZoomVideoSDKVirtualBackgroundDataType_Blur");
                put(ZoomVideoSDKVirtualBackgroundDataType.ZoomVideoSDKVirtualBackgroundDataType_Image, "ZoomVideoSDKVirtualBackgroundDataType_Image");
                put(ZoomVideoSDKVirtualBackgroundDataType.ZoomVideoSDKVirtualBackgroundDataType_None, "ZoomVideoSDKVirtualBackgroundDataType_None");
            }};

    public static String valueOf(ZoomVideoSDKVirtualBackgroundDataType type) {
        String result;
        result = virtualBackgroundDataType.containsKey(type)? virtualBackgroundDataType.get(type) : "ZoomVideoSDKVirtualBackgroundDataType_None";
        return result;
    }

}
