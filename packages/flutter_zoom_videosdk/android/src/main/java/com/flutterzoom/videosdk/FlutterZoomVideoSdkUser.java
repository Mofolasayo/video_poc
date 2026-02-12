package com.flutterzoom.videosdk;

import androidx.annotation.NonNull;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkDataType;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkErrors;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkNetworkStatus;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKDataType;
import us.zoom.sdk.ZoomVideoSDKErrors;
import us.zoom.sdk.ZoomVideoSDKSession;
import us.zoom.sdk.ZoomVideoSDKShareAction;
import us.zoom.sdk.ZoomVideoSDKUser;

public class FlutterZoomVideoSdkUser {

    public static ZoomVideoSDKUser getUser(String userId) {
        ZoomVideoSDKSession session = ZoomVideoSDK.getInstance().getSession();
        ZoomVideoSDKUser myUser = session.getMySelf();

        if (myUser.getUserID().equals(userId)) {
            return myUser;
        }

        return session.getRemoteUsers()
                .stream()
                .filter(u -> u.getUserID().equals(userId))
                .findAny()
                .orElse(null);
    }

    public static String jsonUserArray(List<ZoomVideoSDKUser> userList) {
        JsonArray mappedUserArray = new JsonArray();
        for (ZoomVideoSDKUser user : userList) {
            JsonElement jsonUser = new Gson().fromJson(jsonUser(user), JsonElement.class);
            mappedUserArray.add(jsonUser);
        }

        return mappedUserArray.toString();
    }

    public static String jsonUser(ZoomVideoSDKUser user) {
        Map<String, Object> mappedUser = new HashMap<>();
        mappedUser.put("userId", user.getUserID());
        mappedUser.put("customUserId", user.getCustomIdentity());
        mappedUser.put("userName", user.getUserName());
        mappedUser.put("isHost", user.isHost());
        mappedUser.put("isManager", user.isManager());
        mappedUser.put("isVideoSpotLighted", user.isVideoSpotLighted());

        Gson gson = new GsonBuilder().create();
        String jsonUser = gson.toJson(mappedUser);

        return jsonUser;
    }

    public void getUserName(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String userId = (String) args.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }
        ZoomVideoSDKUser user = getUser(userId);
        if (user != null) {
            result.success(user.getUserName());
        } else {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "User not found", null);
        }
    }

    public void getShareActionList(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String userId = (String) args.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }
        ZoomVideoSDKUser user = getUser(userId);
        if (user != null) {
            List<ZoomVideoSDKShareAction> shareActionList = user.getShareActionList();
            result.success(FlutterZoomVideoSdkShareAction.jsonShareActionArray(shareActionList));
        } else {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "User not found", null);
        }
    }

    public void isHost(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String userId = (String) args.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }
        ZoomVideoSDKUser user = getUser(userId);
        if (user != null) {
            result.success(user.isHost());
        } else {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "User not found", null);
        }
    }

    public void isManager(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String userId = (String) args.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }
        ZoomVideoSDKUser user = getUser(userId);
        if (user != null) {
            result.success(user.isManager());
        } else {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "User not found", null);
        }
    }

    public void isVideoSpotLighted(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String userId = (String) args.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }
        ZoomVideoSDKUser user = getUser(userId);
        if (user != null) {
            result.success(user.isVideoSpotLighted());
        } else {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "User not found", null);
        }
    }

    public void getMultiCameraCanvasList(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String userId = (String) args.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }
        ZoomVideoSDKUser user = getUser(userId);
        if (user != null) {
            result.success(user.getMultiCameraCanvasList());
        } else {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "User not found", null);
        }
    }

    public void hasIndividualRecordingConsent(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String userId = (String) args.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }
        ZoomVideoSDKUser user = getUser(userId);
        if (user != null) {
            result.success(user.hasIndividualRecordingConsent());
        } else {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "User not found", null);
        }
    }

    public void setUserVolume(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String userId = (String) args.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }
        float volume = ((Double) args.get("volume")).floatValue();
        boolean isShareAudio = (boolean) args.get("isShareAudio");
        ZoomVideoSDKUser user = getUser(userId);
        if (user != null) {
            result.success(user.setUserVolume(volume, isShareAudio));
        } else {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "User not found", null);
        }
    }

    public void getUserVolume(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String userId = (String) args.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }
        boolean isShareAudio = (boolean) args.get("isShareAudio");
        ZoomVideoSDKUser user = getUser(userId);
        if (user != null) {
            result.success(user.getUserVolume(isShareAudio));
        } else {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "User not found", null);
        }
    }

    public void canSetUserVolume(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String userId = (String) args.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }
        boolean isShareAudio = (boolean) args.get("isShareAudio");
        ZoomVideoSDKUser user = getUser(userId);
        if (user != null) {
            result.success(user.canSetUserVolume(isShareAudio));
        } else {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "User not found", null);
        }
    }

    public void getUserGUID(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String userId = (String) args.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }
        ZoomVideoSDKUser user = getUser(userId);
        if (user != null) {
            result.success(user.getUserGUID());
        } else {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "User not found", null);
        }
    }

    public void getNetworkLevel(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String userId = (String) args.get("userId");
        String dataType = (String) args.get("dataType");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }
        ZoomVideoSDKUser user = getUser(userId);
        ZoomVideoSDKDataType type = FlutterZoomVideoSdkDataType.typeOf(dataType);
        if (user != null) {
            result.success(FlutterZoomVideoSdkNetworkStatus.valueOf(user.getNetworkLevel(type)));
        } else {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "User not found", null);
        }
    }

    public void  getOverallNetworkLevel(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String userId = (String) args.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }
        ZoomVideoSDKUser user = getUser(userId);
        if (user != null) {
            result.success(FlutterZoomVideoSdkNetworkStatus.valueOf(user.getOverallNetworkLevel()));
        } else {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "User not found", null);
        }
    }

}
