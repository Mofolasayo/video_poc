package com.flutterzoom.videosdk;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkErrors;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKErrors;
import us.zoom.sdk.ZoomVideoSDKUser;
import us.zoom.sdk.ZoomVideoSDKUserHelper;

public class FlutterZoomVideoSdkUserHelper {

    private Activity activity;

    FlutterZoomVideoSdkUserHelper(Activity activity) {
        this.activity = activity;
    }

    private ZoomVideoSDKUserHelper getUserHelper() {
        ZoomVideoSDKUserHelper userHelper = null;
        try {
            userHelper = ZoomVideoSDK.getInstance().getUserHelper();
            if (userHelper == null) {
                throw new Exception("No User Helper Found");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userHelper;
    }

    public void changeName(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> params = call.arguments();
        String userId = (String) params.get("userId");
        String name = (String) params.get("name");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }

        ZoomVideoSDKUser user = FlutterZoomVideoSdkUser.getUser(userId);
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getUserHelper().changeName(name, user));
            }
        });
    }

    public void makeHost(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> params = call.arguments();
        String userId = (String) params.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }

        ZoomVideoSDKUser user = FlutterZoomVideoSdkUser.getUser(userId);
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getUserHelper().makeHost(user));
            }
        });
    }

    public void makeManager(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> params = call.arguments();
        String userId = (String) params.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }

        ZoomVideoSDKUser user = FlutterZoomVideoSdkUser.getUser(userId);
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getUserHelper().makeManager(user));
            }
        });
    }

    public void revokeManager(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> params = call.arguments();
        String userId = (String) params.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }

        ZoomVideoSDKUser user = FlutterZoomVideoSdkUser.getUser(userId);
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getUserHelper().revokeManager(user));
            }
        });
    }

    public void removeUser(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> params = call.arguments();
        String userId = (String) params.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }

        ZoomVideoSDKUser user = FlutterZoomVideoSdkUser.getUser(userId);
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getUserHelper().removeUser(user));
            }
        });
    }

}
