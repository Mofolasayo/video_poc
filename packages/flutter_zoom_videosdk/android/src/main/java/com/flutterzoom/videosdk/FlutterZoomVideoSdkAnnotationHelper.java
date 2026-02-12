package com.flutterzoom.videosdk;

import android.app.Activity;
import android.graphics.Color;

import androidx.annotation.NonNull;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkAnnotationClearType;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkAnnotationToolType;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkErrors;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDKAnnotationHelper;
import us.zoom.sdk.ZoomVideoSDKErrors;

public class FlutterZoomVideoSdkAnnotationHelper {

    private Activity activity;
    private ZoomVideoSDKAnnotationHelper annotationHelper;
    public static FlutterZoomVideoSdkAnnotationHelper instance;

    FlutterZoomVideoSdkAnnotationHelper(Activity activity) {
        this.activity = activity;
    }

    private ZoomVideoSDKAnnotationHelper getAnnotationHelper() {
        try {
            annotationHelper = FlutterZoomVideoSdkView.getInstance().getAnnotationHelper();
            if (annotationHelper == null) {
                throw new NullPointerException("No Annotation Helper Found");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return annotationHelper;
    }

    public static FlutterZoomVideoSdkAnnotationHelper createInstance(Activity activity) {
        if (instance == null) {
            instance = new FlutterZoomVideoSdkAnnotationHelper(activity);
        }
        return instance;
    }

    public static FlutterZoomVideoSdkAnnotationHelper getInstance() {
        return instance;
    }

    public void setAnnotationHelper(ZoomVideoSDKAnnotationHelper helper) {
        this.annotationHelper = helper;
        FlutterZoomVideoSdkView.getInstance().setAnnotationHelper(null);
    }

    public void isSenderDisableAnnotation(@NonNull MethodChannel.Result result) {
        result.success(getAnnotationHelper().isSenderDisableAnnotation());
    }

    public void canDoAnnotation(@NonNull MethodChannel.Result result) {
        result.success(getAnnotationHelper().canDoAnnotation());
    }

    public void startAnnotation(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAnnotationHelper().startAnnotation()));
            }
        });
    }

    public void stopAnnotation(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAnnotationHelper().stopAnnotation()));
            }
        });
    }

    public void setToolColor(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String toolColor = (String) args.get("toolColor");
        if (toolColor == null || toolColor.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "toolColor is null or empty", null);
        }
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAnnotationHelper().setToolColor(Color.parseColor(toolColor))));
            }
        });
    }

    public void getToolColor(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                String hexColor = String.format("#%06X", (0xFFFFFF & getAnnotationHelper().getToolColor()));
                result.success(hexColor);
            }
        });
    }

    public void setToolType(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String toolType = (String) args.get("toolType");
        if (toolType == null || toolType.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "toolType is null or empty", null);
        }
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAnnotationHelper().setToolType(FlutterZoomVideoSdkAnnotationToolType.valueOf(toolType))));
            }
        });
    }

    public void getToolType(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkAnnotationToolType.stringOf(getAnnotationHelper().getToolType()));
            }
        });
    }

    public void setToolWidth(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        long width = (Long) args.get("width");
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAnnotationHelper().setToolWidth(width)));
            }
        });
    }

    public void getToolWidth(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getAnnotationHelper().getToolWidth());
            }
        });
    }

    public void undo(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAnnotationHelper().undo()));
            }
        });
    }

    public void redo(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAnnotationHelper().redo()));
            }
        });
    }

    public void clear(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String clearType = (String) args.get("clearType");
        if (clearType == null || clearType.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "clearType is null or empty", null);
        }
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAnnotationHelper().clear(FlutterZoomVideoSdkAnnotationClearType.valueOf(clearType))));
            }
        });
    }

}
