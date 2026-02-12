package com.flutterzoom.videosdk;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkErrors;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKLiveStreamHelper;

public class FlutterZoomVideoSdkLiveStreamHelper {

    private Activity activity;

    FlutterZoomVideoSdkLiveStreamHelper(Activity activity) {
        this.activity = activity;
    }

    private ZoomVideoSDKLiveStreamHelper getLiveStreamHelper() {
        ZoomVideoSDKLiveStreamHelper liveStreamHelper = null;
        try {
            liveStreamHelper = ZoomVideoSDK.getInstance().getLiveStreamHelper();
            if (liveStreamHelper == null) {
                throw new Exception("No Live Stream Helper Found");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return liveStreamHelper;
    }

    public void canStartLiveStream(@NonNull MethodChannel.Result result) {
        result.success(FlutterZoomVideoSdkErrors.valueOf(getLiveStreamHelper().canStartLiveStream()));
    }

    public void startLiveStream(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> param = call.arguments();
        String streamUrl = (String) param.get("streamUrl");
        String streamKey = (String) param.get("streamKey");
        String broadcastUrl = (String) param.get("broadcastUrl");

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getLiveStreamHelper().startLiveStream(streamUrl, streamKey, broadcastUrl)));
            }
        });
    }

    public void stopLiveStream(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getLiveStreamHelper().stopLiveStream()));
            }
        });
    }

}
