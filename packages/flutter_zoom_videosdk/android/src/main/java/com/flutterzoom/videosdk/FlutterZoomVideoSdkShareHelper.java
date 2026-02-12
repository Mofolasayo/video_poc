package com.flutterzoom.videosdk;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.media.projection.MediaProjectionManager;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkErrors;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKErrors;
import us.zoom.sdk.ZoomVideoSDKShareHelper;

public class FlutterZoomVideoSdkShareHelper {

    private Activity activity;
    private Context context;
    public final static int REQUEST_SHARE_SCREEN_PERMISSION = 1001;
    public final static int REQUEST_STOP_SHARE = 1002;
    private static final String TAG = "FlutterZoomVideoSdkShareHelper";


    FlutterZoomVideoSdkShareHelper(Activity activity, Context context) {
        this.activity = activity;
        this.context = context;
    }

    private ZoomVideoSDKShareHelper getShareHelper() {
        ZoomVideoSDKShareHelper shareHelper = null;
        try {
            shareHelper = ZoomVideoSDK.getInstance().getShareHelper();
            if (shareHelper == null) {
                throw new Exception("No Share Found");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return shareHelper;
    }

    public void shareScreen() throws Exception {
        if (Build.VERSION.SDK_INT < 21) {
            return;
        }
        if (ZoomVideoSDK.getInstance().getShareHelper().isSharingOut()) {
            return;
        }
        MediaProjectionManager mgr = (MediaProjectionManager) context.getSystemService(Context.MEDIA_PROJECTION_SERVICE);
        if (mgr != null) {
            Intent intent = mgr.createScreenCaptureIntent();
            try {
                activity.startActivityForResult(intent, REQUEST_SHARE_SCREEN_PERMISSION);
            } catch (Exception e) {
                Log.e(TAG, "askScreenSharePermission failed");
            }
        }
    }

    public void shareView() {
        // TODO
    }

    public void lockShare(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        boolean lock = (Boolean) args.get("lock");

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getShareHelper().lockShare(lock)));
            }
        });
    }

    public void stopShare(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getShareHelper().stopShare()));
            }
        });
    }

    public void isOtherSharing(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getShareHelper().isOtherSharing());
            }
        });
    }

    public void isScreenSharingOut(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getShareHelper().isScreenSharingOut());
            }
        });
    }

    public void isShareLocked(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getShareHelper().isShareLocked());
            }
        });
    }

    public void isSharingOut(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getShareHelper().isSharingOut());
            }
        });
    }

    public void isAnnotationFeatureSupport(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getShareHelper().isAnnotationFeatureSupport());
            }
        });
    }

    public void disableViewerAnnotation(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        boolean disable = (Boolean) args.get("disable");
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getShareHelper().disableViewerAnnotation(disable));
            }
        });
    }

    public void isViewerAnnotationDisabled(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getShareHelper().isViewerAnnotationDisabled());
            }
        });
    }

    public void destroyAnnotationHelper(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getShareHelper().destroyAnnotationHelper(FlutterZoomVideoSdkView.getInstance().getAnnotationHelper()));
            }
        });
    }

    public void pauseShare(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getShareHelper().pauseShare()));
            }
        });
    }

    public void resumeShare(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getShareHelper().resumeShare()));
            }
        });
    }

    public void startShareCamera(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                FlutterZoomVideoSdkCameraShareView cameraView = FlutterZoomVideoSdkCameraShareView.getInstance();
                if (cameraView != null) {
                    String err = FlutterZoomVideoSdkErrors.valueOf(getShareHelper().startShareCamera(cameraView.getCameraShareView()));
                    result.success(err);
                } else {
                    result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Internal_Error), "Failed to setShareCameraView", null);
                }
            }
        });
    }

    public void setAnnotationVanishingToolTime(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        if (args == null || !args.containsKey("displayTime") || !args.containsKey("vanishingTime")) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "Invalid parameter", null);
            return;
        }
        int displayTime = (Integer) args.get("displayTime");
        int vanishingTime = (Integer) args.get("vanishingTime");
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getShareHelper().setAnnotationVanishingToolTime(displayTime, vanishingTime)));
            }
        });
    }

    public void getAnnotationVanishingToolDisplayTime(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getShareHelper().getAnnotationVanishingToolDisplayTime());
            }
        });
    }

    public void getAnnotationVanishingToolVanishingTime(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getShareHelper().getAnnotationVanishingToolVanishingTime());
            }
        });
    }

}
