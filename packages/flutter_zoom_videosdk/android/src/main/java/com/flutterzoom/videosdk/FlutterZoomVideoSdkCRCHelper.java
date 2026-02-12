package com.flutterzoom.videosdk;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkCRCProtocol;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkErrors;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKCRCHelper;
import us.zoom.sdk.ZoomVideoSDKCRCHelper.ZoomVideoSDKCRCProtocol;

public class FlutterZoomVideoSdkCRCHelper {

    private Activity activity;

    FlutterZoomVideoSdkCRCHelper(Activity activity) {
        this.activity = activity;
    }

    private ZoomVideoSDKCRCHelper getCRCHelper() {
        ZoomVideoSDKCRCHelper CRCHelper = null;
        try {
            CRCHelper = ZoomVideoSDK.getInstance().getCRCHelper();
            if (CRCHelper == null) {
                throw new Exception("No CRC Helper Found");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return CRCHelper;
    }

    public void isCRCEnabled(@NonNull MethodChannel.Result result) {
        result.success(getCRCHelper().isCRCEnabled());
    }

    public void callCRCDevice(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> param = call.arguments();
        String address = (String) param.get("address");
        String protocolStr = (String) param.get("protocol");
        ZoomVideoSDKCRCProtocol protocolEnum = FlutterZoomVideoSdkCRCProtocol.valueOf(protocolStr);
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getCRCHelper().callCRCDevice(address, protocolEnum)));
            }
        });
    }

    public void cancelCallCRCDevice(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getCRCHelper().cancelCallCRCDevice()));
            }
        });
    }

    public void getSessionSIPAddress(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getCRCHelper().getSessionSIPAddress());
            }
        });
    }

}
