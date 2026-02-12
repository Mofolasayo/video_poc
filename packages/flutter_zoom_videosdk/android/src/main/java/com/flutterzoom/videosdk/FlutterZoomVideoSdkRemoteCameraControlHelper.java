package com.flutterzoom.videosdk;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkErrors;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDKErrors;
import us.zoom.sdk.ZoomVideoSDKRemoteCameraControlHelper;
import us.zoom.sdk.ZoomVideoSDKUser;

public class FlutterZoomVideoSdkRemoteCameraControlHelper {

    private Activity activity;

    FlutterZoomVideoSdkRemoteCameraControlHelper(Activity activity) {
        this.activity = activity;
    }

    private ZoomVideoSDKRemoteCameraControlHelper getRemoteCameraControlHelper(String userId) {
        ZoomVideoSDKRemoteCameraControlHelper remoteCameraControlHelper = null;
        try {
            ZoomVideoSDKUser user = FlutterZoomVideoSdkUser.getUser(userId);
            remoteCameraControlHelper = user.getRemoteCameraControlHelper();
            if (remoteCameraControlHelper == null) {
                throw new Exception("No Remote Camera Control Helper Found");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return remoteCameraControlHelper;
    }

    public void requestControlRemoteCamera(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> params = call.arguments();
        String userId = (String) params.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getRemoteCameraControlHelper(userId).requestControlRemoteCamera()));
            }
        });
    }

    public void giveUpControlRemoteCamera(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> params = call.arguments();
        String userId = (String) params.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getRemoteCameraControlHelper(userId).giveUpControlRemoteCamera()));
            }
        });
    }

    public void turnLeft(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> params = call.arguments();
        int range = (Integer) params.get("range");
        String userId = (String) params.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getRemoteCameraControlHelper(userId).turnLeft(range)));
            }
        });
    }

    public void turnRight(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> params = call.arguments();
        int range = (Integer) params.get("range");
        String userId = (String) params.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getRemoteCameraControlHelper(userId).turnRight(range)));
            }
        });
    }

    public void turnDown(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> params = call.arguments();
        int range = (Integer) params.get("range");
        String userId = (String) params.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getRemoteCameraControlHelper(userId).turnDown(range)));
            }
        });
    }

    public void turnUp(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> params = call.arguments();
        int range = (Integer) params.get("range");
        String userId = (String) params.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getRemoteCameraControlHelper(userId).turnUp(range)));
            }
        });
    }

    public void zoomIn(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> params = call.arguments();
        int range = (Integer) params.get("range");
        String userId = (String) params.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getRemoteCameraControlHelper(userId).zoomIn(range)));
            }
        });
    }

    public void zoomOut(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> params = call.arguments();
        int range = (Integer) params.get("range");
        String userId = (String) params.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getRemoteCameraControlHelper(userId).zoomOut(range)));
            }
        });
    }
}

