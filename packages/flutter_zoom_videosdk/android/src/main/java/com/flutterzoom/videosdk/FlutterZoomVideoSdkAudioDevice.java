package com.flutterzoom.videosdk;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkAudioSourceType;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkCameraFacingType;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKAudioHelper.ZoomVideoSDKAudioDevice;

public class FlutterZoomVideoSdkAudioDevice {
    public static String jsonAudioDeviceArray(List<ZoomVideoSDKAudioDevice> audioDeviceList) {
        JsonArray mappedAudioDeviceArray = new JsonArray();
        for (ZoomVideoSDKAudioDevice audioDevice : audioDeviceList) {
            JsonElement jsonAudioDevice = new Gson().fromJson(jsonAudioDevice(audioDevice), JsonElement.class);
            mappedAudioDeviceArray.add(jsonAudioDevice);
        }
        return mappedAudioDeviceArray.toString();
    }

    public static String jsonAudioDevice(ZoomVideoSDKAudioDevice audioDevice) {
        Map<String, Object> mappedAudioDevice = new HashMap<>();
        mappedAudioDevice.put("deviceName", audioDevice.getAudioName());
        mappedAudioDevice.put("deviceSourceType", FlutterZoomVideoSdkAudioSourceType.valueOf(audioDevice.getAudioSourceType()));

        Gson gson = new GsonBuilder().create();

        return gson.toJson(mappedAudioDevice);
    }
}
