package com.flutterzoom.videosdk;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkShareStatus;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkShareType;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkVideoSubscribeFailReason;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKShareAction;

public class FlutterZoomVideoSdkShareAction {

    public static String jsonShareActionArray(List<ZoomVideoSDKShareAction> shareActionList) {
        JsonArray mappedShareActionArray = new JsonArray();
        for (ZoomVideoSDKShareAction shareAction : shareActionList) {
            JsonElement jsonShareAction = new Gson().fromJson(jsonShareAction(shareAction), JsonElement.class);
            mappedShareActionArray.add(jsonShareAction);
        }

        return mappedShareActionArray.toString();
    }

    public static String jsonShareAction(ZoomVideoSDKShareAction shareAction) {
        Map<String, Object> mappedShareAction = new HashMap<>();
        Gson gson = new GsonBuilder().create();
        if (shareAction == null) {
            return gson.toJson(mappedShareAction);
        }
        mappedShareAction.put("shareSourceId", shareAction.getShareSourceId());
        mappedShareAction.put("shareStatus", FlutterZoomVideoSdkShareStatus.valueOf(shareAction.getShareStatus()));
        mappedShareAction.put("subscribeFailReason", FlutterZoomVideoSdkVideoSubscribeFailReason.valueOf(shareAction.getSubscribeFailReason()));
        mappedShareAction.put("isAnnotationPrivilegeEnabled", shareAction.isAnnotationPrivilegeEnabled());
        mappedShareAction.put("shareType", FlutterZoomVideoSdkShareType.valueOf(shareAction.getShareType()));

        String jsonShareAction = gson.toJson(mappedShareAction);

        return jsonShareAction;
    }
}
