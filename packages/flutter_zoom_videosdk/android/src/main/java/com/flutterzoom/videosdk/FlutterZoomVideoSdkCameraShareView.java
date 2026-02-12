package com.flutterzoom.videosdk;

import android.content.Context;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Map;

import io.flutter.plugin.platform.PlatformView;
import us.zoom.sdk.ZoomVideoSDKCameraShareView;

public class FlutterZoomVideoSdkCameraShareView implements PlatformView {

    public static FlutterZoomVideoSdkCameraShareView instance;
    private ZoomVideoSDKCameraShareView cameraShareView;

    public static FlutterZoomVideoSdkCameraShareView getInstance() {
        return instance;
    }

    public static FlutterZoomVideoSdkCameraShareView createInstance(@NonNull Context context, int id, @NonNull Map<String, Object> creationParams) {
        instance = new FlutterZoomVideoSdkCameraShareView(context, id, creationParams);
        return instance;
    }


    FlutterZoomVideoSdkCameraShareView(@NonNull Context context, int id, @NonNull Map<String, Object> creationParams) {
        cameraShareView = new ZoomVideoSDKCameraShareView(context);
    }

    public ZoomVideoSDKCameraShareView getCameraShareView() {
        if (cameraShareView == null) {
            throw new NullPointerException("No Camera Share View Found");
        }
        return cameraShareView;
    }

    @Nullable
    @Override
    public View getView() {
        return cameraShareView;
    }

    @Override
    public void dispose() {
        cameraShareView = null;
    }
}
