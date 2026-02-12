package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKLiveTranscriptionHelper;

public class FlutterZoomVideoSdkLiveTranscriptionOperationType {

    private static final Map<ZoomVideoSDKLiveTranscriptionHelper.ZoomVideoSDKLiveTranscriptionOperationType, String> liveTranscriptionOperationType =
            new HashMap<ZoomVideoSDKLiveTranscriptionHelper.ZoomVideoSDKLiveTranscriptionOperationType, String>() {{
                put(ZoomVideoSDKLiveTranscriptionHelper.ZoomVideoSDKLiveTranscriptionOperationType.ZoomVideoSDKLiveTranscription_OperationType_None, "ZoomVideoSDKLiveTranscription_OperationType_None");
                put(ZoomVideoSDKLiveTranscriptionHelper.ZoomVideoSDKLiveTranscriptionOperationType.ZoomVideoSDKLiveTranscription_OperationType_Update, "ZoomVideoSDKLiveTranscription_OperationType_Update");
                put(ZoomVideoSDKLiveTranscriptionHelper.ZoomVideoSDKLiveTranscriptionOperationType.ZoomVideoSDKLiveTranscription_OperationType_Delete, "ZoomVideoSDKLiveTranscription_OperationType_Delete");
                put(ZoomVideoSDKLiveTranscriptionHelper.ZoomVideoSDKLiveTranscriptionOperationType.ZoomVideoSDKLiveTranscription_OperationType_Complete, "ZoomVideoSDKLiveTranscription_OperationType_Complete");
                put(ZoomVideoSDKLiveTranscriptionHelper.ZoomVideoSDKLiveTranscriptionOperationType.ZoomVideoSDKLiveTranscription_OperationType_Add, "ZoomVideoSDKLiveTranscription_OperationType_Add");
                put(ZoomVideoSDKLiveTranscriptionHelper.ZoomVideoSDKLiveTranscriptionOperationType.ZoomVideoSDKLiveTranscription_OperationType_NotSupported, "ZoomVideoSDKLiveTranscription_OperationType_NotSupported");
            }};

    public static String valueOf(ZoomVideoSDKLiveTranscriptionHelper.ZoomVideoSDKLiveTranscriptionOperationType name) {
        if (name == null) return "ZoomVideoSDKLiveTranscription_OperationType_None";

        String result;
        result = liveTranscriptionOperationType.containsKey(name)? liveTranscriptionOperationType.get(name) : "ZoomVideoSDKLiveTranscription_OperationType_None";
        return result;
    }

}
