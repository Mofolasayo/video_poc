package com.flutterzoom.videosdk;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkErrors;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKCmdChannel;
import us.zoom.sdk.ZoomVideoSDKUser;

public class FlutterZoomVideoSdkCmdChannel {

    private Activity activity;

    FlutterZoomVideoSdkCmdChannel(Activity activity) {
        this.activity = activity;
    }

    private ZoomVideoSDKCmdChannel getCmdChannel() {
        ZoomVideoSDKCmdChannel cmdChannel = null;
        try {
            cmdChannel = ZoomVideoSDK.getInstance().getCmdChannel();
            if (cmdChannel == null) {
                throw new Exception("Command channel is not available");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cmdChannel;
    }

    public void sendCommand(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> param = call.arguments();
        String receiverId = (String) param.get("receiverId");
        String strCmd = (String) param.get("strCmd");

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                ZoomVideoSDKCmdChannel cmdChannel = getCmdChannel();
                ZoomVideoSDKUser receiver = null;
                if (receiverId != null) {
                    receiver = FlutterZoomVideoSdkUser.getUser(receiverId);
                }
                result.success(FlutterZoomVideoSdkErrors.valueOf(cmdChannel.sendCommand(receiver, strCmd)));
            }
        });
    }

}
