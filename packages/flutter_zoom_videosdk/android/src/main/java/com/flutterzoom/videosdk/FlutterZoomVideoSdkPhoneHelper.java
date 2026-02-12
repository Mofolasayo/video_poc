package com.flutterzoom.videosdk;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkErrors;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkPhoneStatus;

import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKErrors;
import us.zoom.sdk.ZoomVideoSDKPhoneHelper;
import us.zoom.sdk.ZoomVideoSDKPhoneSupportCountryInfo;
import us.zoom.sdk.ZoomVideoSDKSessionDialInNumberInfo;

public class FlutterZoomVideoSdkPhoneHelper {

    private Activity activity;

    FlutterZoomVideoSdkPhoneHelper(Activity activity) {
        this.activity = activity;
    }

    private ZoomVideoSDKPhoneHelper getPhoneHelper() {
        ZoomVideoSDKPhoneHelper phoneHelper = null;

        try {
            phoneHelper = ZoomVideoSDK.getInstance().getPhoneHelper();
            if (phoneHelper  == null) {
                throw new Exception("No Phone Helper Found");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return phoneHelper;
    }

    public void cancelInviteByPhone(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getPhoneHelper().cancelInviteByPhone()));
            }
        });
    }

    public void getInviteByPhoneStatus(@NonNull MethodChannel.Result result) {
        result.success(FlutterZoomVideoSdkPhoneStatus.valueOf(getPhoneHelper().getInviteByPhoneStatus()));
    }

    public void getSupportCountryInfo(@NonNull MethodChannel.Result result) {

        List<ZoomVideoSDKPhoneSupportCountryInfo> countryList = getPhoneHelper().getSupportCountryInfo();

        if (countryList == null) {
            result.error("ZoomVideoSdkPhoneHelper::getSupportCountryInfo", "Unable to get support country info", null);
        }

        result.success(FlutterZoomVideoSdkPhoneSupportCountryInfo.jsonPhoneSupportCountryInfoArray(countryList));
    }

    public void inviteByPhone(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> params = call.arguments();
        String countryCode = (String) params.get("countryCode");
        String phoneNumber = (String) params.get("phoneNumber");
        String name = (String) params.get("name");
        if (countryCode.isEmpty() || phoneNumber.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "countryCode or phoneNumber is null or empty", null);
        }

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getPhoneHelper().inviteByPhone(countryCode, phoneNumber, name)));
            }
        });
    }

    public void isSupportPhoneFeature(@NonNull MethodChannel.Result result) {
        result.success(getPhoneHelper().isSupportPhoneFeature());
    }

    public void getSessionDialInNumbers(@NonNull MethodChannel.Result result) {
        List<ZoomVideoSDKSessionDialInNumberInfo> sessionDialInNumberList = getPhoneHelper().getSessionDialInNumbers();

        if (sessionDialInNumberList == null) {
            result.error("ZoomVideoSdkPhoneHelper::getSessionDialInNumbers", "there is no session dial-in numbers", null);
        }

        result.success(FlutterZoomVideoSdkSessionDialInNumberInfo.jsonSessionDialInNumberInfoArray(sessionDialInNumberList));
    }

}
