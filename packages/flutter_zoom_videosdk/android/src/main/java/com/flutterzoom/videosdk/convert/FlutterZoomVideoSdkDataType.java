package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKDataType;

public class FlutterZoomVideoSdkDataType {
    private static final Map<ZoomVideoSDKDataType, String> dataTypeMap =
            new HashMap<ZoomVideoSDKDataType, String>() {{
                put(ZoomVideoSDKDataType.ZoomVideoSDKDataType_Video, "ZoomVideoSDKDataType_Video");
                put(ZoomVideoSDKDataType.ZoomVideoSDKDataType_Audio, "ZoomVideoSDKDataType_Audio");
                put(ZoomVideoSDKDataType.ZoomVideoSDKDataType_Share, "ZoomVideoSDKDataType_Share");
                put(ZoomVideoSDKDataType.ZoomVideoSDKDataType_Unknown, "ZoomVideoSDKDataType_Unknown");
            }};

    private static final Map<String, ZoomVideoSDKDataType> dataStringMap =
            new HashMap<String, ZoomVideoSDKDataType>() {{
                put("ZoomVideoSDKDataType_Video", ZoomVideoSDKDataType.ZoomVideoSDKDataType_Video);
                put("ZoomVideoSDKDataType_Audio", ZoomVideoSDKDataType.ZoomVideoSDKDataType_Audio);
                put("ZoomVideoSDKDataType_Share", ZoomVideoSDKDataType.ZoomVideoSDKDataType_Share);
                put("ZoomVideoSDKDataType_Unknown", ZoomVideoSDKDataType.ZoomVideoSDKDataType_Unknown);
            }};

    public static String valueOf(ZoomVideoSDKDataType name) {
        if (name == null) return "ZoomVideoSDKDataType_Unknown";

        String result;
        result = dataTypeMap.getOrDefault(name, "ZoomVideoSDKDataType_Unknown");
        return result;
    }

    public static ZoomVideoSDKDataType typeOf(String dataType) {
        if (dataType == null || dataType.equals("")) return ZoomVideoSDKDataType.ZoomVideoSDKDataType_Unknown;

        ZoomVideoSDKDataType type;
        type = dataStringMap.getOrDefault(dataType, ZoomVideoSDKDataType.ZoomVideoSDKDataType_Unknown);
        return type;
    }
}
