package com.flutterzoom.videosdk;

import android.app.Activity;
import android.util.DisplayMetrics;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;
import androidx.fragment.app.FragmentActivity;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkErrors;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkExportFormat;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKErrors;
import us.zoom.sdk.ZoomVideoSDKExportFormat;
import us.zoom.sdk.ZoomVideoSDKWhiteboardHelper;

public class FlutterZoomVideoSdkWhiteboardHelper {
    private Activity activity;
    private FrameLayout container;

    FlutterZoomVideoSdkWhiteboardHelper(Activity activity) {
        this.activity = activity;
    }

    private ZoomVideoSDKWhiteboardHelper getWhiteboardHelper() {
        ZoomVideoSDKWhiteboardHelper whiteboardHelper = null;
        try {
            whiteboardHelper = ZoomVideoSDK.getInstance().getShareHelper().getWhiteboardHelper();
            if (whiteboardHelper == null) {
                throw new Exception("No         int left = xPx + insetL;\n" +
                        "        int top  = yPx + insetT; Helper Found");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return whiteboardHelper;
    }

    public void canStartShareWhiteboard(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getWhiteboardHelper().canStartShareWhiteboard());
            }
        });
    }

    public void canStopShareWhiteboard(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getWhiteboardHelper().canStopShareWhiteboard());
            }
        });
    }

    public void startShareWhiteboard(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getWhiteboardHelper().startShareWhiteboard()));
            }
        });
    }

    public void stopShareWhiteboard(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                detach();
                result.success(FlutterZoomVideoSdkErrors.valueOf(getWhiteboardHelper().stopShareWhiteboard()));
            }
        });
    }

    public void isOtherSharingWhiteboard(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getWhiteboardHelper().isOtherSharingWhiteboard());
            }
        });
    }

    public void exportWhiteboard(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String exportFormat = (String) args.get("exportFormat");

        if (exportFormat == null ||exportFormat.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "format is null or empty", null);
            return;
        }

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                ZoomVideoSDKExportFormat format = FlutterZoomVideoSdkExportFormat.typeOf(exportFormat);
                result.success(FlutterZoomVideoSdkErrors.valueOf(getWhiteboardHelper().exportWhiteboard(format)));
            }
        });
    }

    public void subscribeWhiteboard(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                Map<String, Object> args = call.arguments();
                double x = args.get("x") != null ? (Double) args.get("x") : 0.0;
                double y = args.get("y") != null ? (Double) args.get("y") : 0.0;
                double width = args.get("width") != null ? (Double) args.get("width") : 0.0;
                double height = args.get("height") != null ? (Double) args.get("height") : 0.0;
                ensureAttached(activity);
                setRectFromFlutter(x, y, width, height);
                result.success(FlutterZoomVideoSdkErrors.valueOf(getWhiteboardHelper().subscribeWhiteboard((FragmentActivity) activity, container)));
            }
        });
    }

    public void unSubscribeWhiteboard(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                detach();
                result.success(FlutterZoomVideoSdkErrors.valueOf(getWhiteboardHelper().unSubscribeWhiteboard((FragmentActivity) activity)));
            }
        });
    }
    private void ensureAttached(Activity activity) {
        if (container != null && container.getParent() != null) return;

        ViewGroup root = activity.findViewById(android.R.id.content);
        if (container == null) {
            container = new FrameLayout(activity);
            container.setClipToPadding(true);
            container.setClipChildren(true);
            container.setClickable(false);
            int id = View.generateViewId();
            container.setId(id);
        }
        if (container.getParent() == null) {
            FrameLayout.LayoutParams lp = new FrameLayout.LayoutParams(0, 0);
            root.addView(container);
        }
        container.bringToFront();
    }
    private void setRectFromFlutter(double xLp, double yLp, double wLp, double hLp) {
        ensureAttached(activity);

        final ViewGroup root = activity.findViewById(android.R.id.content);
        if (root.getWidth() == 0 || root.getHeight() == 0) {
            root.post(() -> setRectFromFlutter(xLp, yLp, wLp, hLp));
            return;
        }

        float density = getDensity(activity);
        int xPx = (int) Math.round(xLp * density);
        int yPx = (int) Math.round(yLp * density);
        int wPx = (int) Math.round(wLp * density);
        int hPx = (int) Math.round(hLp * density);
        int insetL = 0, insetT = 0;

        WindowInsetsCompat wi = ViewCompat.getRootWindowInsets(root);
        if (wi != null) {
            int types = WindowInsetsCompat.Type.systemBars() | WindowInsetsCompat.Type.displayCutout();
            Insets sys = wi.getInsets(types);
            insetL = sys.left; insetT = sys.top;
        }
        int left = xPx + insetL;
        int top  = yPx + insetT;

        FrameLayout.LayoutParams lp;
        ViewGroup.LayoutParams cur = container.getLayoutParams();
        if (cur instanceof FrameLayout.LayoutParams) {
            lp = (FrameLayout.LayoutParams) cur;
        } else {
            lp = new FrameLayout.LayoutParams(wPx, hPx);
        }

        lp.width = Math.max(0, wPx);
        lp.height = Math.max(0, hPx);
        lp.leftMargin = Math.max(0, left);
        lp.topMargin  = Math.max(0, top);

        container.setLayoutParams(lp);

        root.setClipChildren(true);
        root.setClipToPadding(true);
        container.setClipToPadding(true);
        container.setClipChildren(true);

        container.bringToFront();
    }

    private void detach() {
        if (container == null) return;
        ViewGroup parent = (ViewGroup) container.getParent();
        if (parent != null) parent.removeView(container);
        container = null;
    }

    private static float getDensity(Activity activity) {
        DisplayMetrics dm = new DisplayMetrics();
        activity.getWindowManager().getDefaultDisplay().getRealMetrics(dm);
        return dm.density;
    }
}
