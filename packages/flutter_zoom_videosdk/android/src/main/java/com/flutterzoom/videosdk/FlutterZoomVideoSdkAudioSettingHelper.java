package com.flutterzoom.videosdk;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkErrors;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKAudioSettingHelper;

public class FlutterZoomVideoSdkAudioSettingHelper {

    private Activity activity;

    FlutterZoomVideoSdkAudioSettingHelper(Activity activity) {
        this.activity = activity;
    }

    private ZoomVideoSDKAudioSettingHelper getAudioSettingHelper() {
        ZoomVideoSDKAudioSettingHelper audioSettingHelper = null;

        try {
            audioSettingHelper = ZoomVideoSDK.getInstance().getAudioSettingHelper();
            if (audioSettingHelper == null) {
                throw new Exception("No Audio Setting Helper Found");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return audioSettingHelper;
    }

    public void isMicOriginalInputEnable(@NonNull MethodChannel.Result result) {
        result.success(getAudioSettingHelper().isMicOriginalInputEnable());
    }

    public void enableMicOriginalInput(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        boolean enable = (Boolean) args.get("enable");
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAudioSettingHelper().enableMicOriginalInput(enable)));
            }
        });
    }

    public void enableAutoAdjustMicVolume(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        boolean enable = (Boolean) args.get("enable");
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAudioSettingHelper().enableAutoAdjustMicVolume(enable)));
            }
        });
    }

    public void isAutoAdjustMicVolumeEnabled(@NonNull MethodChannel.Result result) {
        result.success(getAudioSettingHelper().isAutoAdjustMicVolumeEnabled());
    }

}
