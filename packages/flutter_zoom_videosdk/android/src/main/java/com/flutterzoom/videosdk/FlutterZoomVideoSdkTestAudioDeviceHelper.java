package com.flutterzoom.videosdk;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkErrors;

import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKTestAudioDeviceHelper;

public class FlutterZoomVideoSdkTestAudioDeviceHelper {

    private Activity activity;

    FlutterZoomVideoSdkTestAudioDeviceHelper(Activity activity) {
        this.activity = activity;
    }

    private ZoomVideoSDKTestAudioDeviceHelper getTestAudioDeviceHelper() {
        ZoomVideoSDKTestAudioDeviceHelper testAudioDeviceHelper = null;
        try {
            testAudioDeviceHelper = ZoomVideoSDK.getInstance().getTestAudioDeviceHelper();
            if (testAudioDeviceHelper == null) {
                throw new Exception ("Test audio is not available");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return testAudioDeviceHelper;
    }

    public void startMicTest(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                getTestAudioDeviceHelper().stopMicTest();
                result.success(FlutterZoomVideoSdkErrors.valueOf(getTestAudioDeviceHelper().startMicTest()));
            }
        });
    }

    public void stopMicTest(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getTestAudioDeviceHelper().stopMicTest()));
            }
        });
    }

    public void playMicTest(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getTestAudioDeviceHelper().playMicTest()));
            }
        });
    }

    public void startSpeakerTest(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getTestAudioDeviceHelper().startSpeakerTest()));
            }
        });
    }

    public void stopSpeakerTest(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getTestAudioDeviceHelper().stopSpeakerTest()));
            }
        });
    }

}
