package com.flutterzoom.videosdk;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkVirtualBackgroundDataType;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKVirtualBackgroundItem;

public class FlutterZoomVideoSdkVirtualBackgroundItem {

    public static String jsonItemArray(List<ZoomVideoSDKVirtualBackgroundItem> itemList) {
        JsonArray mapItemArray = new JsonArray();
        for (ZoomVideoSDKVirtualBackgroundItem item : itemList) {
            JsonElement jsonMessage = new Gson().fromJson(jsonVBItem(item), JsonElement.class);
            mapItemArray.add(jsonMessage);
        }

        return mapItemArray.toString();
    }

    public static String jsonVBItem(ZoomVideoSDKVirtualBackgroundItem item) {
        Map<String, Object> mappedItem = new HashMap<>();
        Gson gson = new GsonBuilder().create();
        if (item == null) {
            return gson.toJson(mappedItem);
        }

        mappedItem.put("filePath", item.getImageFilePath());
        mappedItem.put("imageName", item.getImageName());
        mappedItem.put("type", FlutterZoomVideoSdkVirtualBackgroundDataType.valueOf(item.getType()));
        mappedItem.put("canBeDeleted", item.canVirtualBackgroundBeDeleted());

        String jsonItem = gson.toJson(mappedItem);

        return jsonItem;
    }
}
