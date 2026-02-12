package com.flutterzoom.videosdk;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Map;

import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class FlutterZoomVideoSdkCameraShareViewFactory extends PlatformViewFactory {
    public FlutterZoomVideoSdkCameraShareViewFactory() {
        super(StandardMessageCodec.INSTANCE);
    }

    @NonNull
    @Override
    public PlatformView create(Context context, int viewId, @Nullable Object args) {
        final Map<String, Object> creationParams = (Map<String, Object>) args;
        return FlutterZoomVideoSdkCameraShareView.createInstance(context, viewId, creationParams);
    }
}
