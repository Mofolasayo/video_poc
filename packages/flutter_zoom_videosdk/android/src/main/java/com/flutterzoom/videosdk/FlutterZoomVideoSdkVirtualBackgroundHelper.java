package com.flutterzoom.videosdk;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import androidx.annotation.NonNull;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkErrors;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKErrors;
import us.zoom.sdk.ZoomVideoSDKVirtualBackgroundHelper;
import us.zoom.sdk.ZoomVideoSDKVirtualBackgroundItem;

public class FlutterZoomVideoSdkVirtualBackgroundHelper {

    private Activity activity;

    FlutterZoomVideoSdkVirtualBackgroundHelper(Activity activity) {
        this.activity = activity;
    }

    private ZoomVideoSDKVirtualBackgroundHelper getVirtualBackgroundHelper() {
        ZoomVideoSDKVirtualBackgroundHelper virtualBackgroundHelper = null;
        try {
            virtualBackgroundHelper = ZoomVideoSDK.getInstance().getVirtualBackgroundHelper();
            if (virtualBackgroundHelper == null) {
                throw new Exception("No Virtual Background Helper Found");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return virtualBackgroundHelper;
    }

    public void isSupportVirtualBackground(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getVirtualBackgroundHelper().isSupportVirtualBackground());
            }
        });
    }

    public void addVirtualBackgroundItem(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> params = call.arguments();
        String filePath = (String) params.get("filePath");
        if (filePath == null || filePath.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "filePath is null or empty", null);
        }

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Bitmap bitmap = BitmapFactory.decodeFile(filePath);
                if (bitmap == null) {
                    result.error("FlutterZoomVideoSdkVirtualBackgroundHelper::addVirtualBackgroundItem ", "file does not exist", null);
                }
                ZoomVideoSDKVirtualBackgroundItem item = getVirtualBackgroundHelper().addVirtualBackgroundItem(bitmap);
                result.success(FlutterZoomVideoSdkVirtualBackgroundItem.jsonVBItem(item));
            }
        });
    }

    public void removeVirtualBackgroundItem(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> params = call.arguments();
        String imageName = (String) params.get("imageName");
        if (imageName == null || imageName.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                int ret = 1;
                List<ZoomVideoSDKVirtualBackgroundItem> itemList = getVirtualBackgroundHelper().getVirtualBackgroundItemList();
                for (ZoomVideoSDKVirtualBackgroundItem item : itemList) {
                    if(item.getImageName().equals(imageName)) {
                        ret = getVirtualBackgroundHelper().removeVirtualBackgroundItem(item);
                    }
                }
                result.success(FlutterZoomVideoSdkErrors.valueOf(ret));
            }
        });
    }

    public void getVirtualBackgroundItemList(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                List<ZoomVideoSDKVirtualBackgroundItem> itemList = getVirtualBackgroundHelper().getVirtualBackgroundItemList();
                if (itemList == null) {
                    itemList = new ArrayList<>();
                }
                result.success(FlutterZoomVideoSdkVirtualBackgroundItem.jsonItemArray(itemList));
            }
        });
    }

    public void setVirtualBackgroundItem(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> params = call.arguments();
        String imageName = (String) params.get("imageName");
        if (imageName == null || imageName.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                int ret = 1;
                List<ZoomVideoSDKVirtualBackgroundItem> itemList = getVirtualBackgroundHelper().getVirtualBackgroundItemList();
                for (ZoomVideoSDKVirtualBackgroundItem item : itemList) {
                    if(item.getImageName().equals(imageName)) {
                        ret = getVirtualBackgroundHelper().setVirtualBackgroundItem(item);
                    }
                }
                result.success(FlutterZoomVideoSdkErrors.valueOf(ret));
            }
        });
    }

    public void getSelectedVirtualBackgroundItem(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                ZoomVideoSDKVirtualBackgroundItem item = getVirtualBackgroundHelper().getSelectedVirtualBackgroundItem();
                result.success(FlutterZoomVideoSdkVirtualBackgroundItem.jsonVBItem(item));
            }
        });
    }

}
