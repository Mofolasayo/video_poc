package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKLiveTranscriptionHelper;

public class FlutterZoomVideoSdkLiveTranscriptionStatus {

    private static final Map<ZoomVideoSDKLiveTranscriptionHelper.ZoomVideoSDKLiveTranscriptionStatus, String> liveTranscriptionStatus =
            new HashMap<ZoomVideoSDKLiveTranscriptionHelper.ZoomVideoSDKLiveTranscriptionStatus, String>() {{
                put(ZoomVideoSDKLiveTranscriptionHelper.ZoomVideoSDKLiveTranscriptionStatus.ZoomVideoSDKLiveTranscription_Status_Stop, "ZoomVideoSDKLiveTranscription_Status_Stop");
                put(ZoomVideoSDKLiveTranscriptionHelper.ZoomVideoSDKLiveTranscriptionStatus.ZoomVideoSDKLiveTranscription_Status_Start, "ZoomVideoSDKLiveTranscription_Status_Start");
            }};

    public static String valueOf(ZoomVideoSDKLiveTranscriptionHelper.ZoomVideoSDKLiveTranscriptionStatus name) {
        if (name == null) return "ZoomVideoSDKLiveTranscription_Status_Stop";

        String result;
        result = liveTranscriptionStatus.containsKey(name)? liveTranscriptionStatus.get(name) : "ZoomVideoSDKLiveTranscription_Status_Stop";
        return result;
    }

}
