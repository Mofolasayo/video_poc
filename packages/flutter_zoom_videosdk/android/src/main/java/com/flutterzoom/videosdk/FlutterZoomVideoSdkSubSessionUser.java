package com.flutterzoom.videosdk;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import us.zoom.sdk.SubSessionUser;

public class FlutterZoomVideoSdkSubSessionUser {

    public static String jsonSubSessionUserArray(List<SubSessionUser> subSessionUsersList) {
        JsonArray mappedSubSessionUserArray = new JsonArray();
        for (SubSessionUser subSessionUser : subSessionUsersList) {
            JsonElement jsonSubSessionUser = new Gson().fromJson(jsonSubSessionUser(subSessionUser), JsonElement.class);
            mappedSubSessionUserArray.add(jsonSubSessionUser);
        }

        return mappedSubSessionUserArray.toString();
    }

    public static String jsonSubSessionUser(SubSessionUser subSessionUser) {
        Map<String, Object> mappedSubSessionUser = new HashMap<>();
        Gson gson = new GsonBuilder().create();
        if (subSessionUser == null) {
            return gson.toJson(mappedSubSessionUser);
        }
        mappedSubSessionUser.put("userGUID", subSessionUser.getUserGUID());
        mappedSubSessionUser.put("userName", subSessionUser.getUserName());

        return gson.toJson(mappedSubSessionUser);
    }
}
