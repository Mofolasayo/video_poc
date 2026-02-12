package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKCRCHelper.ZoomVideoSDKCRCProtocol;

public class FlutterZoomVideoSdkCRCProtocol {

    private static final Map<String, ZoomVideoSDKCRCProtocol> protocols =
            new HashMap<String, ZoomVideoSDKCRCProtocol>() {{
                put("ZoomVideoSDKCRCProtocol_H323", ZoomVideoSDKCRCProtocol.ZoomVideoSDKCRCProtocol_H323);
                put("ZoomVideoSDKCRCProtocol_SIP", ZoomVideoSDKCRCProtocol.ZoomVideoSDKCRCProtocol_SIP);
            }};

    public static ZoomVideoSDKCRCProtocol valueOf(String protocolStr) {
        if (protocolStr == null) return ZoomVideoSDKCRCProtocol.ZoomVideoSDKCRCProtocol_H323;

        ZoomVideoSDKCRCProtocol protocol;
        protocol = protocols.containsKey(protocolStr)? protocols.get(protocolStr) : ZoomVideoSDKCRCProtocol.ZoomVideoSDKCRCProtocol_H323;

        return protocol;
    }
}
