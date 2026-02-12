package com.flutterzoom.videosdk;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkErrors;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.SubSessionKit;
import us.zoom.sdk.SubSessionUserHelpRequestHandler;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKErrors;
import us.zoom.sdk.ZoomVideoSDKSubSessionHelper;
import us.zoom.sdk.ZoomVideoSDKSubSessionManager;
import us.zoom.sdk.ZoomVideoSDKSubSessionParticipant;

public class FlutterZoomVideoSdkSubSessionHelper {

    private Activity activity;
    private static ZoomVideoSDKSubSessionManager subSessionManager;
    private static ZoomVideoSDKSubSessionParticipant subSessionParticipant;
    private static SubSessionUserHelpRequestHandler subSessionUserHelpRequestHandler;
    private Map<String, SubSessionKit> subSessionKitMap;

    FlutterZoomVideoSdkSubSessionHelper(Activity activity) {
        this.activity = activity;
        subSessionKitMap = new HashMap<>();
    }

    private ZoomVideoSDKSubSessionHelper getSubSessionHelper() {
        ZoomVideoSDKSubSessionHelper subSessionHelper = null;

        try {
            subSessionHelper = ZoomVideoSDK.getInstance().getSubSessionHelper();
            if (subSessionHelper  == null) {
                throw new Exception("No SubSession Helper Found");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return subSessionHelper;
    }

    public static void storeSubSessionUserHelpRequestHandler(SubSessionUserHelpRequestHandler handler) {
        subSessionUserHelpRequestHandler = handler;
    }

    public static void storeSubSessionManager(ZoomVideoSDKSubSessionManager manager) {
        subSessionManager = manager;
    }

    public static void storeSubSessionParticipant(ZoomVideoSDKSubSessionParticipant participant) {
        subSessionParticipant = participant;
    }

    public void joinSubSession(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        if (args == null) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "No call arguments", null);
            return;
        }
        String subSessionId = (String) args.get("subSessionId");
        SubSessionKit subSessionKit = subSessionKitMap.get(subSessionId);
        if (subSessionKit == null) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "No SubSessionKit found for the given subSessionId", null);
            return;
        }

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(subSessionKit.joinSubSession()));
            }
        });
    }

    public void startSubSession(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(subSessionManager.startSubSession()));
            }
        });
    }

    public void isSubSessionStarted(@NonNull MethodChannel.Result result) {
        result.success(subSessionManager.isSubSessionStarted());
    }

    public void stopSubSession(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(subSessionManager.stopSubSession()));
            }
        });
    }

    public void broadcastMessage(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String message = (String) args.get("message");

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(subSessionManager.broadcastMessage(message)));
            }
        });
    }

    public void returnToMainSession(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(subSessionParticipant.returnToMainSession()));
            }
        });
    }

    public void requestForHelp(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(subSessionParticipant.requestForHelp()));
            }
        });
    }

    public void getRequestUserName(@NonNull MethodChannel.Result result) {
        result.success(subSessionUserHelpRequestHandler.getRequestUserName());
    }

    public void getRequestSubSessionName(@NonNull MethodChannel.Result result) {
        result.success(subSessionUserHelpRequestHandler.getRequestSubSessionName());
    }

    public void ignoreUserHelpRequest(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(subSessionUserHelpRequestHandler.ignore()));
            }
        });
    }

    public void joinSubSessionByUserRequest(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(subSessionUserHelpRequestHandler.joinSubSessionByUserRequest()));
            }
        });
    }

    public void commitSubSessionList(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        ArrayList<String> subSessionNames = (ArrayList<String>) call.arguments;

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getSubSessionHelper().commitSubSessionList(subSessionNames)));
            }
        });
    }

    public void getCommittedSubSessionList(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                List<SubSessionKit> subSessionKits = getSubSessionHelper().getCommittedSubSessionList();
                subSessionKits.forEach(kit -> subSessionKitMap.put(kit.getSubSessionID(), kit));
                result.success(FlutterZoomVideoSdkSubSessionKit.jsonSubSessionKitArray(subSessionKits));
            }
        });
    }

    public void withdrawSubSessionList(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getSubSessionHelper().withdrawSubSessionList()));
            }
        });
    }

}
