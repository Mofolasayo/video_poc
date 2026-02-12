package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKVideoSubscribeFailReason;

public class FlutterZoomVideoSdkVideoSubscribeFailReason {

    private static final Map<ZoomVideoSDKVideoSubscribeFailReason, String> failedReason =
            new HashMap<ZoomVideoSDKVideoSubscribeFailReason, String>() {{
                put(ZoomVideoSDKVideoSubscribeFailReason.ZoomVideoSDKSubscribeFailReason_NotSupport1080P, "ZoomVideoSDKSubscribeFailReason_NotSupport1080P");
                put(ZoomVideoSDKVideoSubscribeFailReason.ZoomVideoSDKSubscribeFailReason_HasSubscribe1080POr720P, "ZoomVideoSDKSubscribeFailReason_HasSubscribe1080POr720P");
                put(ZoomVideoSDKVideoSubscribeFailReason.ZoomVideoSDKSubscribeFailReason_HasSubscribeShare, "ZoomVideoSDKSubscribeFailReason_HasSubscribeShare");
                put(ZoomVideoSDKVideoSubscribeFailReason.ZoomVideoSDKSubscribeFailReason_HasSubscribeOneShare, "ZoomVideoSDKSubscribeFailReason_HasSubscribeOneShare");
                put(ZoomVideoSDKVideoSubscribeFailReason.ZoomVideoSDKSubscribeFailReason_HasSubscribeExceededLimit, "ZoomVideoSDKSubscribeFailReason_HasSubscribeExceededLimit");
                put(ZoomVideoSDKVideoSubscribeFailReason.ZoomVideoSDKSubscribeFailReason_None, "ZoomVideoSDKSubscribeFailReason_None");
            }};

    public static String valueOf(ZoomVideoSDKVideoSubscribeFailReason name) {
        if (name == null) return "ZoomVideoSDKSubscribeFailReason_None";

        String result;
        result = failedReason.containsKey(name)? failedReason.get(name) : "ZoomVideoSDKSubscribeFailReason_None";
        return result;

    }
}
