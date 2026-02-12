package com.flutterzoom.videosdk;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkErrors;

import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKAudioHelper;
import us.zoom.sdk.ZoomVideoSDKErrors;
import us.zoom.sdk.ZoomVideoSDKUser;

public class FlutterZoomVideoSdkAudioHelper {

    private Activity activity;
    private Map<String, ZoomVideoSDKAudioHelper.ZoomVideoSDKAudioDevice> audioDeviceMap;

    FlutterZoomVideoSdkAudioHelper(Activity activity) {
        this.activity = activity;
    }

    private ZoomVideoSDKAudioHelper getAudioHelper() {
        ZoomVideoSDKAudioHelper audioHelper = null;
        try {
            audioHelper = ZoomVideoSDK.getInstance().getAudioHelper();
            if (audioHelper == null) {
                throw new Exception("No Audio Helper Found");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return audioHelper;
    }

    public void canSwitchSpeaker(@NonNull MethodChannel.Result result) {
        result.success(getAudioHelper().canSwitchSpeaker());
    }

    public void getSpeakerStatus(@NonNull MethodChannel.Result result) {
        result.success(getAudioHelper().getSpeakerStatus());
    }

    public void muteAudio(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String userId = (String) args.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }
        ZoomVideoSDKUser user = FlutterZoomVideoSdkUser.getUser(userId);
        if (user != null) {
            activity.runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    result.success(FlutterZoomVideoSdkErrors.valueOf(getAudioHelper().muteAudio(user)));
                }
            });
        } else {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "User not found", null);
        }
    }

    public void unmuteAudio(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String userId = (String) args.get("userId");
        if (userId == null || userId.isEmpty()) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "userId is null or empty", null);
        }
        ZoomVideoSDKUser user = FlutterZoomVideoSdkUser.getUser(userId);
        if (user != null) {
            activity.runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    result.success(FlutterZoomVideoSdkErrors.valueOf(getAudioHelper().unMuteAudio(user)));
                }
            });
        } else {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "User not found", null);
        }
    }

    public void muteAllAudio(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        boolean allowUnmute = (Boolean) args.get("allowUnmute");
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAudioHelper().muteAllAudio(allowUnmute)));
            }
        });
    }

    public void unmuteAllAudio(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAudioHelper().unmuteAllAudio()));
            }
        });
    }

    public void allowAudioUnmutedBySelf(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        boolean allowUnmute = (Boolean) args.get("allowUnmute");
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAudioHelper().allowAudioUnmutedBySelf(allowUnmute)));
            }
        });
    }

    public void setSpeaker(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        boolean isOn = (Boolean) args.get("isOn");

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAudioHelper().setSpeaker(isOn)));
            }
        });
    }

    public void startAudio(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAudioHelper().startAudio()));
            }
        });
    }

    public void stopAudio(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAudioHelper().stopAudio()));
            }
        });
    }

    public void subscribe(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAudioHelper().subscribe()));
            }
        });
    }

    public void unsubscribe(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAudioHelper().unSubscribe()));
            }
        });
    }

    public void resetAudioSession(@NonNull MethodChannel.Result result) {
        result.success(false);
    }

    public void cleanAudioSession(@NonNull MethodChannel.Result result) {
        result.success(null);
    }

    public void getAudioDeviceList(@NonNull MethodChannel.Result result) {
        List<ZoomVideoSDKAudioHelper.ZoomVideoSDKAudioDevice> audioDeviceList = getAudioHelper().getAudioDeviceList();
        for (ZoomVideoSDKAudioHelper.ZoomVideoSDKAudioDevice device : audioDeviceList) {
            if (audioDeviceMap == null) {
                audioDeviceMap = new java.util.HashMap<>();
            }
            audioDeviceMap.put(device.getAudioName(), device);
        }

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkAudioDevice.jsonAudioDeviceArray(audioDeviceList));
            }
        });
    }

    public void getUsingAudioDevice(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkAudioDevice.jsonAudioDevice(getAudioHelper().getUsingAudioDevice()));
            }
        });
    }

    public void switchToAudioSourceType(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        String deviceName = (String) args.get("deviceName");
        ZoomVideoSDKAudioHelper.ZoomVideoSDKAudioDevice device = audioDeviceMap.get(deviceName);
        if (device == null) {
            result.error(FlutterZoomVideoSdkErrors.valueOf(ZoomVideoSDKErrors.Errors_Invalid_Parameter), "Audio device not found", null);
            return;
        }
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getAudioHelper().switchToAudioSourceType(device)));
            }
        });
    }

}
