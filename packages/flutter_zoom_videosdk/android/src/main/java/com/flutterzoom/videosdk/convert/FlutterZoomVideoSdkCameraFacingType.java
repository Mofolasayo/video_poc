package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKCameraFacingType;

public class FlutterZoomVideoSdkCameraFacingType {

    private static final Map<ZoomVideoSDKCameraFacingType, String> cameraFacingTypeMap =
            new HashMap<ZoomVideoSDKCameraFacingType, String>() {{
                put(ZoomVideoSDKCameraFacingType.ZoomVideoSDKCameraFacingType_Unknown, "ZoomVideoSDKCameraFacingType_Unknown");
                put(ZoomVideoSDKCameraFacingType.ZoomVideoSDKCameraFacingType_Front, "ZoomVideoSDKCameraFacingType_Front");
                put(ZoomVideoSDKCameraFacingType.ZoomVideoSDKCameraFacingType_Back, "ZoomVideoSDKCameraFacingType_Back");
                put(ZoomVideoSDKCameraFacingType.ZoomVideoSDKCameraFacingType_External, "ZoomVideoSDKCameraFacingType_External");
            }};

    public static String valueOf(ZoomVideoSDKCameraFacingType cameraFacingType) {
        if (cameraFacingType == null) return "ZoomVideoSDKCameraFacingType_Unknown";

        String result;
        result = cameraFacingTypeMap.getOrDefault(cameraFacingType, "ZoomVideoSDKDialInNumType_None");
        return result;
    }
}