package com.flutterzoom.videosdk.convert;

import java.util.HashMap;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKChatPrivilegeType;

public class FlutterZoomVideoSdkChatPrivilegeType {

    private static final Map<String, ZoomVideoSDKChatPrivilegeType> privilegeTypeMap =
            new HashMap<String, ZoomVideoSDKChatPrivilegeType>() {{
                put("ZoomVideoSDKChatPrivilege_Publicly_And_Privately", ZoomVideoSDKChatPrivilegeType.ZoomVideoSDKChatPrivilege_Publicly_And_Privately);
                put("ZoomVideoSDKChatPrivilege_Publicly", ZoomVideoSDKChatPrivilegeType.ZoomVideoSDKChatPrivilege_Publicly);
                put("ZoomVideoSDKChatPrivilege_No_One", ZoomVideoSDKChatPrivilegeType.ZoomVideoSDKChatPrivilege_No_One);
                put("ZoomVideoSDKChatPrivilege_Unknown", ZoomVideoSDKChatPrivilegeType.ZoomVideoSDKChatPrivilege_Unknown);
            }};

    private static final Map<ZoomVideoSDKChatPrivilegeType, String> privilegeStringMap =
            new HashMap<ZoomVideoSDKChatPrivilegeType, String>() {{
                put(ZoomVideoSDKChatPrivilegeType.ZoomVideoSDKChatPrivilege_Publicly_And_Privately, "ZoomVideoSDKChatPrivilege_Publicly_And_Privately");
                put(ZoomVideoSDKChatPrivilegeType.ZoomVideoSDKChatPrivilege_Publicly, "ZoomVideoSDKChatPrivilege_Publicly");
                put(ZoomVideoSDKChatPrivilegeType.ZoomVideoSDKChatPrivilege_No_One, "ZoomVideoSDKChatPrivilege_No_One");
                put(ZoomVideoSDKChatPrivilegeType.ZoomVideoSDKChatPrivilege_Unknown, "ZoomVideoSDKChatPrivilege_Unknown");
            }};

    public static ZoomVideoSDKChatPrivilegeType typeOf(String privilegeType) {
        if (privilegeType == null || privilegeType.equals("")) return ZoomVideoSDKChatPrivilegeType.ZoomVideoSDKChatPrivilege_Unknown;

        ZoomVideoSDKChatPrivilegeType type;
        type = privilegeTypeMap.containsKey(privilegeType)? privilegeTypeMap.get(privilegeType) : ZoomVideoSDKChatPrivilegeType.ZoomVideoSDKChatPrivilege_Unknown;
        return type;
    }

    public static String valueOf(ZoomVideoSDKChatPrivilegeType privilegeType) {
        if (privilegeType == null) return "ZoomVideoSDKChatPrivilege_Unknown";

        String type;
        type = privilegeStringMap.containsKey(privilegeType)? privilegeStringMap.get(privilegeType) : "ZoomVideoSDKChatPrivilege_Unknown";
        return type;
    }
}
