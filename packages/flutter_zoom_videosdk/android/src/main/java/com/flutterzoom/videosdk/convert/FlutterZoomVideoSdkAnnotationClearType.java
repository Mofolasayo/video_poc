package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKAnnotationClearType;

public class FlutterZoomVideoSdkAnnotationClearType {

    private static final Map<String, ZoomVideoSDKAnnotationClearType> clearType =
            new HashMap<String, ZoomVideoSDKAnnotationClearType>() {{
                put("ZoomVideoSDKAnnotationClearType_All", ZoomVideoSDKAnnotationClearType.ZoomVideoSDKAnnotationClearType_All);
                put("ZoomVideoSDKAnnotationClearType_Others", ZoomVideoSDKAnnotationClearType.ZoomVideoSDKAnnotationClearType_Others);
                put("ZoomVideoSDKAnnotationClearType_My", ZoomVideoSDKAnnotationClearType.ZoomVideoSDKAnnotationClearType_My);
            }};

    public static ZoomVideoSDKAnnotationClearType valueOf(String name) {
        ZoomVideoSDKAnnotationClearType type;
        type = clearType.containsKey(name)? clearType.get(name) : ZoomVideoSDKAnnotationClearType.ZoomVideoSDKAnnotationClearType_All;
        return type;
    }

}
