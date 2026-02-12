package com.flutterzoom.videosdk;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkErrors;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkRecordingStatus;

import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKRecordingHelper;

public class FlutterZoomVideoSdkRecordingHelper {

    private Activity activity;

    FlutterZoomVideoSdkRecordingHelper(Activity activity) {
        this.activity = activity;
    }

    private ZoomVideoSDKRecordingHelper getRecordingHelper() {
        ZoomVideoSDKRecordingHelper recordingHelper = null;
        try {
            recordingHelper = ZoomVideoSDK.getInstance().getRecordingHelper();
            if (recordingHelper == null) {
                throw new Exception ("Recording is not available");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return recordingHelper;
    }

    public void canStartRecording(@NonNull MethodChannel.Result result) {
        result.success(FlutterZoomVideoSdkErrors.valueOf(getRecordingHelper().canStartRecording()));
    }

    public void startCloudRecording(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getRecordingHelper().startCloudRecording()));
            }
        });
    }

    public void stopCloudRecording(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getRecordingHelper().stopCloudRecording()));
            }
        });
    }

    public void pauseCloudRecording(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getRecordingHelper().pauseCloudRecording()));
            }
        });
    }

    public void resumeCloudRecording(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getRecordingHelper().resumeCloudRecording()));
            }
        });
    }

    public void getCloudRecordingStatus(@NonNull MethodChannel.Result result) {
        result.success(FlutterZoomVideoSdkRecordingStatus.valueOf(getRecordingHelper().getCloudRecordingStatus()));
    }

}
