package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKRecordingConsentHandler;

public class FlutterZoomVideoSdkRecordingConsentType {


    private static final Map<ZoomVideoSDKRecordingConsentHandler.ConsentType, String> consentTypeMap =
            new HashMap<ZoomVideoSDKRecordingConsentHandler.ConsentType, String>() {{
                put(ZoomVideoSDKRecordingConsentHandler.ConsentType.ConsentType_Invalid, "ConsentType_Invalid");
                put(ZoomVideoSDKRecordingConsentHandler.ConsentType.ConsentType_Traditional, "ConsentType_Traditional");
                put(ZoomVideoSDKRecordingConsentHandler.ConsentType.ConsentType_Individual, "ConsentType_Individual");
            }};

    public static String valueOf(ZoomVideoSDKRecordingConsentHandler.ConsentType type) {
        if (type == null) return "ConsentType_Invalid";
        String consentType;
        consentType = consentTypeMap.containsKey(type)? consentTypeMap.get(type) : "ConsentType_Invalid";
        return consentType;
    }
}