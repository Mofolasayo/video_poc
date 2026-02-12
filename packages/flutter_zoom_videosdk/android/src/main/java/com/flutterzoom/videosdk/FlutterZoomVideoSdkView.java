package com.flutterzoom.videosdk;

import android.content.Context;
import android.util.Log;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkVideoAspect;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkVideoResolution;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import io.flutter.plugin.platform.PlatformView;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKAnnotationHelper;
import us.zoom.sdk.ZoomVideoSDKShareAction;
import us.zoom.sdk.ZoomVideoSDKShareStatus;
import us.zoom.sdk.ZoomVideoSDKUser;
import us.zoom.sdk.ZoomVideoSDKVideoAspect;
import us.zoom.sdk.ZoomVideoSDKVideoCanvas;
import us.zoom.sdk.ZoomVideoSDKVideoHelper;
import us.zoom.sdk.ZoomVideoSDKVideoResolution;
import us.zoom.sdk.ZoomVideoSDKVideoView;

public class FlutterZoomVideoSdkView implements PlatformView {

    public static FlutterZoomVideoSdkView instance;
    private ZoomVideoSDKVideoView videoView;
    private ZoomVideoSDKVideoCanvas currentCanvas;
    private String userId = "";
    private boolean sharing = false;
    private ZoomVideoSDKVideoAspect videoAspect = ZoomVideoSDKVideoAspect.ZoomVideoSDKVideoAspect_Original;
    private boolean preview = false;
    private boolean hasMultiCamera = false;
    private String multiCameraIndex = "";
    private ZoomVideoSDKVideoResolution resolution = ZoomVideoSDKVideoResolution.ZoomVideoSDKResolution_Auto;
    private ZoomVideoSDKAnnotationHelper annotationHelper;
    private View annotationView;

    public static FlutterZoomVideoSdkView getInstance() {
        return instance;
    }

    public static FlutterZoomVideoSdkView createInstance(@NonNull Context context, int id, @NonNull Map<String, Object> creationParams) {
        instance = new FlutterZoomVideoSdkView(context, id, creationParams);
        return instance;
    }


    FlutterZoomVideoSdkView(@NonNull Context context, int id, @NonNull Map<String, Object> creationParams) {
        videoView = new ZoomVideoSDKVideoView(context, false);
        videoView.setZOrderMediaOverlay(true);


        if (creationParams.containsKey("userId")) {
            setUserId((String) creationParams.get("userId"));
        }
        if (creationParams.containsKey("sharing")) {
            setSharing((boolean) creationParams.get("sharing"));
        }
        if (creationParams.containsKey("hasMultiCamera")) {
            setHasMultiCamera((boolean) creationParams.get("hasMultiCamera"));
        }
        if (creationParams.containsKey("multiCameraIndex")) {
            setMultiCameraIndex((String) creationParams.get("multiCameraIndex"));
        }
        if (creationParams.containsKey("fullScreen")) {
            setFullScreen(videoView, (boolean) creationParams.get("fullScreen"));
        }
        if (creationParams.containsKey("aspect")) {
            setAspect((String) creationParams.get("aspect"));
        }
        if (creationParams.containsKey("preview")) {
            setPreview(videoView, (boolean) creationParams.get("preview"));
        }
        if (creationParams.containsKey("resolution")) {
            setResolution((String) creationParams.get("resolution"));
        }
        setViewingCanvas();
    }

    public ZoomVideoSDKAnnotationHelper getAnnotationHelper() {
        return annotationHelper;
    }

    public void setAnnotationHelper(ZoomVideoSDKAnnotationHelper helper) {
        this.annotationHelper = helper;
    }

    public void setUserId(String newUserId) {
        if (newUserId.equals(userId)) {
            return;
        }
        this.userId = newUserId;
    }

    public void setSharing(boolean newSharing) {
        if (sharing == newSharing) {
            return;
        }
        this.sharing = newSharing;
        if (ZoomVideoSDK.getInstance().getShareHelper().isAnnotationFeatureSupport()) {
            if (sharing && annotationHelper == null) {
                ZoomVideoSDKUser mySelf = ZoomVideoSDK.getInstance().getSession().getMySelf();
                if (Objects.equals(userId, mySelf.getUserID())) {
                    annotationHelper = ZoomVideoSDK.getInstance().getShareHelper().createAnnotationHelper(null);
                } else {
                    annotationHelper = ZoomVideoSDK.getInstance().getShareHelper().createAnnotationHelper(videoView);
                }
                if (annotationHelper != null) {
                    annotationView = annotationHelper.getAnnotationView();
                }
                if (annotationView != null && annotationView.getParent() == null) {
                    videoView.addView(annotationView);
                }
            } else {
                if (annotationView != null) {
                    if (annotationView.getParent() != null) videoView.removeView(annotationView);
                    annotationView = null;
                }
                if (annotationHelper != null) {
                    ZoomVideoSDK.getInstance().getShareHelper().destroyAnnotationHelper(annotationHelper);
                }
            }
        }
    }

    public void setHasMultiCamera(boolean newHasMultiCamera) {
        if (hasMultiCamera == newHasMultiCamera) {
            return;
        }
        this.hasMultiCamera = newHasMultiCamera;
    }

    public void setMultiCameraIndex(String newIndex) {
        if (multiCameraIndex == newIndex) {
            return;
        }
        this.multiCameraIndex = newIndex;
    }

    public void setFullScreen(ZoomVideoSDKVideoView videoView, Boolean fullScreen) {
        videoView.setZOrderOnTop(!fullScreen);
    }

    public void setAspect(String newVideoAspect) {
        ZoomVideoSDKVideoAspect aspect = FlutterZoomVideoSdkVideoAspect.valueOf(newVideoAspect);
        if (videoAspect == aspect) {
            return;
        }
        this.videoAspect = aspect;
    }

    public void setPreview(ZoomVideoSDKVideoView videoView, boolean newPreview) {
        if (preview == newPreview) {
            return;
        }
        this.preview = newPreview;

        ZoomVideoSDKVideoHelper videoHelper = ZoomVideoSDK.getInstance().getVideoHelper();
        if (preview) {
            videoHelper.startVideoCanvasPreview(videoView, videoAspect);
        } else {
            videoHelper.stopVideoCanvasPreview(videoView);
        }
    }

    private void setResolution(String videoResolution) {
        ZoomVideoSDKVideoResolution resolution = FlutterZoomVideoSdkVideoResolution.valueOf(videoResolution);
        if (resolution == this.resolution) {
            return;
        }
        this.resolution = resolution;
    }

    private void setViewingCanvas()
    {
        ZoomVideoSDKUser user = FlutterZoomVideoSdkUser.getUser(userId);
        ZoomVideoSDKUser mySelf = ZoomVideoSDK.getInstance().getSession().getMySelf();
        ZoomVideoSDKShareAction shareAction = null;
        if (user == null) return;
        if (currentCanvas != null) {
            currentCanvas.unSubscribe(videoView);
            currentCanvas = null;
        }

        if (sharing) {
            if (!Objects.equals(userId, mySelf.getUserID())) {
                List<ZoomVideoSDKShareAction> list = user.getShareActionList();
                if (!list.isEmpty()) {
                    for (ZoomVideoSDKShareAction action : list) {
                        if (action.getShareStatus() == ZoomVideoSDKShareStatus.ZoomVideoSDKShareStatus_Start && action.getShareSourceId() != 0) {
                            shareAction = action;
                            break;
                        }
                    }
                }
                if (null != shareAction) {
                    currentCanvas = shareAction.getShareCanvas();
                }
            }
        } else if (hasMultiCamera) {
            List<ZoomVideoSDKVideoCanvas> multiCameraList = user.getMultiCameraCanvasList();
            int index = Integer.parseInt(multiCameraIndex);
            currentCanvas = multiCameraList.get(index);
        } else {
            currentCanvas = user.getVideoCanvas();
        }

        if (!(Objects.equals(userId, mySelf.getUserID()) && sharing)) {
            currentCanvas.subscribe(videoView, videoAspect, resolution);
        }
    }

    @Nullable
    @Override
    public View getView() {
        return videoView;
    }

    @Override
    public void dispose() {
        videoView = null;
    }
}
