package com.flutterzoom.videosdk;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkDialInNumberType;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKSessionDialInNumberInfo;

public class FlutterZoomVideoSdkSessionDialInNumberInfo {

    public static String jsonSessionDialInNumberInfo(ZoomVideoSDKSessionDialInNumberInfo sessionDialInNumberInfo) {
        Map<String, Object> mappedDialInNumberInfo = new HashMap<>();
        Gson gson = new GsonBuilder().create();
        if (sessionDialInNumberInfo == null) {
            return gson.toJson(mappedDialInNumberInfo);
        }
        mappedDialInNumberInfo.put("countryID", sessionDialInNumberInfo.getCountryId());
        mappedDialInNumberInfo.put("countryCode", sessionDialInNumberInfo.getCountryCode());
        mappedDialInNumberInfo.put("countryName", sessionDialInNumberInfo.getCountryName());
        mappedDialInNumberInfo.put("number", sessionDialInNumberInfo.getNumber());
        mappedDialInNumberInfo.put("displayNumber", sessionDialInNumberInfo.getDisplayNumber());
        mappedDialInNumberInfo.put("type", FlutterZoomVideoSdkDialInNumberType.valueOf(sessionDialInNumberInfo.getType()));

        String jsonSessionDialInNumberInfo = gson.toJson(mappedDialInNumberInfo);
        return jsonSessionDialInNumberInfo;
    }

    public static String jsonSessionDialInNumberInfoArray(List<ZoomVideoSDKSessionDialInNumberInfo> dialInNumberInfoList) {
        JsonArray mapSessionDialInNumberInfoArray = new JsonArray();
        for (ZoomVideoSDKSessionDialInNumberInfo dialInNumberInfo : dialInNumberInfoList) {
            JsonElement jsonCountryInfo = new Gson().fromJson(jsonSessionDialInNumberInfo(dialInNumberInfo), JsonElement.class);
            mapSessionDialInNumberInfoArray.add(jsonCountryInfo);
        }

        return mapSessionDialInNumberInfoArray.toString();
    }

}
