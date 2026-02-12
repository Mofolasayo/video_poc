package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKChatMessageDeleteType;

public class FlutterZoomVideosSdkChatMessageDeleteType {

    private static final Map<ZoomVideoSDKChatMessageDeleteType, String> chatMessageDeleteType =
            new HashMap<ZoomVideoSDKChatMessageDeleteType, String>() {{
                put(ZoomVideoSDKChatMessageDeleteType.SDK_CHAT_DELETE_BY_DLP, "ZoomVideoSDKChatMsgDeleteBy_DLP");
                put(ZoomVideoSDKChatMessageDeleteType.SDK_CHAT_DELETE_BY_HOST, "ZoomVideoSDKChatMsgDeleteBy_HOST");
                put(ZoomVideoSDKChatMessageDeleteType.SDK_CHAT_DELETE_BY_NONE, "ZoomVideoSDKChatMsgDeleteBy_NONE");
                put(ZoomVideoSDKChatMessageDeleteType.SDK_CHAT_DELETE_BY_SELF, "ZoomVideoSDKChatMsgDeleteBy_SELF");
            }};

    public static String valueOf(ZoomVideoSDKChatMessageDeleteType name) {
        if (name == null) return "ZoomVideoSDKChatMsgDeleteBy_NONE";

        String result;
        result = chatMessageDeleteType.containsKey(name)? chatMessageDeleteType.get(name) : "ZoomVideoSDKChatMsgDeleteBy_NONE";
        return result;
    }
}
