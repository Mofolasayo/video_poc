package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.UVCCameraStatus;

public class FlutterZoomVideoSdkUVCCameraStatus {

    private static final Map<UVCCameraStatus, String> cameraStatus =
            new HashMap<UVCCameraStatus, String>() {{
                put(UVCCameraStatus.ATTACHED, "ZoomVideoSDKUVCCameraStatus_Attached");
                put(UVCCameraStatus.DETACHED, "ZoomVideoSDKUVCCameraStatus_Detached");
                put(UVCCameraStatus.CONNECTED, "ZoomVideoSDKUVCCameraStatus_Connected");
                put(UVCCameraStatus.CANCELED, "ZoomVideoSDKUVCCameraStatus_Canceled");
            }};

    public static String valueOf(UVCCameraStatus name) {
        if (name == null) return "ZoomVideoSDKUVCCameraStatus_Canceled";

        String result;
        result = cameraStatus.getOrDefault(name, "ZoomVideoSDKUVCCameraStatus_Canceled");
        return result;

    }
}
