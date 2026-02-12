package com.flutterzoom.videosdk;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKPhoneSupportCountryInfo;

public class FlutterZoomVideoSdkPhoneSupportCountryInfo {

    public static String jsonPhoneSupportCountryInfoArray(List<ZoomVideoSDKPhoneSupportCountryInfo> countryList) {
        JsonArray mappedCountryArray = new JsonArray();
        for (ZoomVideoSDKPhoneSupportCountryInfo country : countryList) {
            JsonElement jsonCountryInfo = new Gson().fromJson(jsonSupportCountryInfo(country), JsonElement.class);
            mappedCountryArray.add(jsonCountryInfo);
        }

        return mappedCountryArray.toString();
    }

    public static String jsonSupportCountryInfo(ZoomVideoSDKPhoneSupportCountryInfo country) {
        Map<String, Object> mappedCountry = new HashMap<>();
        Gson gson = new GsonBuilder().create();
        if (country == null) {
            return gson.toJson(mappedCountry);
        }
        mappedCountry.put("countryCode", country.getCountryCode());
        mappedCountry.put("countryID", country.getCountryID());
        mappedCountry.put("countryName", country.getCountryName());

        String jsonSupportCountryInfo = gson.toJson(mappedCountry);
        return jsonSupportCountryInfo;
    }

}
