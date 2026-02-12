package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKRecordingStatus;

public class FlutterZoomVideoSdkRecordingStatus {

    private static final Map<ZoomVideoSDKRecordingStatus, String> recordingStatus =
            new HashMap<ZoomVideoSDKRecordingStatus, String>() {{
                put(ZoomVideoSDKRecordingStatus.Recording_Start, "ZoomVideoSDKRecordingStatus_Start");
                put(ZoomVideoSDKRecordingStatus.Recording_Stop, "ZoomVideoSDKRecordingStatus_Stop");
                put(ZoomVideoSDKRecordingStatus.Recording_DiskFull, "ZoomVideoSDKRecordingStatus_DiskFull");
                put(ZoomVideoSDKRecordingStatus.Recording_Pause, "ZoomVideoSDKRecordingStatus_Pause");
            }};

    public static String valueOf(ZoomVideoSDKRecordingStatus status) {
        if (status == null) return "ZoomVideoSDKRecordingStatus_Stop";

        String result;
        result = recordingStatus.containsKey(status)? recordingStatus.get(status) : "ZoomVideoSDKRecordingStatus_Stop";
        return result;
    }

}
