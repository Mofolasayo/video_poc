package com.flutterzoom.videosdk;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkCameraFacingType;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKCameraDevice;

public class FlutterZoomVideoSdkCameraDevice {

    public static String jsonCameraArray(List<ZoomVideoSDKCameraDevice> cameraList) {
        JsonArray mappedCameraArray = new JsonArray();
        for (ZoomVideoSDKCameraDevice camera : cameraList) {
            JsonElement jsonCamera = new Gson().fromJson(jsonCamera(camera), JsonElement.class);
            mappedCameraArray.add(jsonCamera);
        }
        return mappedCameraArray.toString();
    }

    public static String jsonCamera(ZoomVideoSDKCameraDevice camera) {
        Map<String, Object> mappedCamera = new HashMap<>();
        mappedCamera.put("deviceId", camera.getDeviceId());
        mappedCamera.put("deviceName", camera.getDeviceName());
        mappedCamera.put("isSelectedDevice", camera.isSelectedDevice());
        mappedCamera.put("cameraFacingType", FlutterZoomVideoSdkCameraFacingType.valueOf(camera.getCameraFacingType()));

        Gson gson = new GsonBuilder().create();
        String jsonCamera = gson.toJson(mappedCamera);

        return jsonCamera;
    }
}