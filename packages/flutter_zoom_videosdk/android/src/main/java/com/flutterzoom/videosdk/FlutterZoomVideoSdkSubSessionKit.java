package com.flutterzoom.videosdk;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import us.zoom.sdk.SubSessionKit;

public class FlutterZoomVideoSdkSubSessionKit {

    public static String jsonSubSessionKitArray(List<SubSessionKit> subSessionKitsList) {
        JsonArray mappedSubSessionKitArray = new JsonArray();
        for (SubSessionKit subSessionKit : subSessionKitsList) {
            JsonElement jsonSubSessionKit = new Gson().fromJson(jsonSubSessionKit(subSessionKit), JsonElement.class);
            mappedSubSessionKitArray.add(jsonSubSessionKit);
        }

        return mappedSubSessionKitArray.toString();
    }

    public static String jsonSubSessionKit(SubSessionKit subSessionKit) {
        Map<String, Object> mappedSubSessionKit = new HashMap<>();
        Gson gson = new GsonBuilder().create();
        if (subSessionKit == null) {
            return gson.toJson(mappedSubSessionKit);
        }
        mappedSubSessionKit.put("subSessionId", subSessionKit.getSubSessionID());
        mappedSubSessionKit.put("subSessionName", subSessionKit.getSubSessionName());
        mappedSubSessionKit.put("subSessionUserList", FlutterZoomVideoSdkSubSessionUser.jsonSubSessionUserArray(subSessionKit.getSubSessionUserList()));

        return gson.toJson(mappedSubSessionKit);
    }
}
