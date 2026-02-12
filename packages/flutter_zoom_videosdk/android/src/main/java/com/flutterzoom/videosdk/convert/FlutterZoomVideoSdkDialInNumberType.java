package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKDialInNumberType;

public class FlutterZoomVideoSdkDialInNumberType {

    private static final Map<ZoomVideoSDKDialInNumberType, String> dialInNumberTypeMap =
            new HashMap<ZoomVideoSDKDialInNumberType, String>() {{
                put(ZoomVideoSDKDialInNumberType.ZoomVideoSDKDialInNumType_None, "ZoomVideoSDKDialInNumType_None");
                put(ZoomVideoSDKDialInNumberType.ZoomVideoSDKDialInNumType_Toll, "ZoomVideoSDKDialInNumType_Toll");
                put(ZoomVideoSDKDialInNumberType.ZoomVideoSDKDialInNumType_TollFree, "ZoomVideoSDKDialInNumType_TollFree");
            }};

    public static String valueOf(ZoomVideoSDKDialInNumberType dialInNumberType) {
        if (dialInNumberType == null) return "ZoomVideoSDKDialInNumType_None";

        String result;
        result = dialInNumberTypeMap.containsKey(dialInNumberType)? dialInNumberTypeMap.get(dialInNumberType) : "ZoomVideoSDKDialInNumType_None";
        return result;
    }

}
