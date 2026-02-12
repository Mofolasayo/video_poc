package com.flutterzoom.videosdk;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkErrors;
import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkLiveTranscriptionStatus;

import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKErrors;
import us.zoom.sdk.ZoomVideoSDKLiveTranscriptionHelper;

public class FlutterZoomVideoSdkLiveTranscriptionHelper {

    private Activity activity;

    FlutterZoomVideoSdkLiveTranscriptionHelper(Activity activity) {
        this.activity = activity;
    }

    private ZoomVideoSDKLiveTranscriptionHelper getLiveTranscriptionHelper() {
        ZoomVideoSDKLiveTranscriptionHelper liveTranscriptionHelper = null;
        try {
            liveTranscriptionHelper = ZoomVideoSDK.getInstance().getLiveTranscriptionHelper();
            if (liveTranscriptionHelper == null) {
                throw new Exception("No Live Transcription Helper Found");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return liveTranscriptionHelper;
    }

    public void canStartLiveTranscription(@NonNull MethodChannel.Result result) {
        result.success(getLiveTranscriptionHelper().canStartLiveTranscription());
    }

    public void getLiveTranscriptionStatus(@NonNull MethodChannel.Result result) {
        result.success(FlutterZoomVideoSdkLiveTranscriptionStatus.valueOf(getLiveTranscriptionHelper().getLiveTranscriptionStatus()));
    }

    public void startLiveTranscription(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getLiveTranscriptionHelper().startLiveTranscription()));
            }
        });
    }

    public void stopLiveTranscription(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getLiveTranscriptionHelper().stopLiveTranscription()));
            }
        });
    }

    public void getAvailableSpokenLanguages(@NonNull MethodChannel.Result result) {
        List<ZoomVideoSDKLiveTranscriptionHelper.ILiveTranscriptionLanguage> languageList = getLiveTranscriptionHelper().getAvailableSpokenLanguages();

        if (languageList == null) {
            result.error("RNZoomVideoSdkLiveTranscriptionHelper::getAvailableSpokenLanguages", "there is no available language for live transcription", null);
            return;
        }

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkILiveTranscriptionLanguage.jsonLanguageArray(languageList));
            }
        });
    }

    public void setSpokenLanguage(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        int languageID = (Integer) args.get("languageID");

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getLiveTranscriptionHelper().setSpokenLanguage(languageID)));
            }
        });

    }

    public void getSpokenLanguage(@NonNull MethodChannel.Result result) {
        ZoomVideoSDKLiveTranscriptionHelper.ILiveTranscriptionLanguage language = getLiveTranscriptionHelper().getSpokenLanguage();

        if (language == null) {
            result.error("RNZoomVideoSdkLiveTranscriptionHelper::getSpokenLanguage ", "spoken language doesn't exist", null);
            return;
        }

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkILiveTranscriptionLanguage.jsonLanguage(language));
            }
        });

    }

    public void getAvailableTranslationLanguages(@NonNull MethodChannel.Result result) {
        List<ZoomVideoSDKLiveTranscriptionHelper.ILiveTranscriptionLanguage> languageList = getLiveTranscriptionHelper().getAvailableTranslationLanguages();

        if (languageList == null) {
            result.error("RNZoomVideoSdkLiveTranscriptionHelper::getAvailableTranslationLanguages", "there is no available translation language for live transcription", null);
            return;
        }

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkILiveTranscriptionLanguage.jsonLanguageArray(languageList));
            }
        });

    }

    public void setTranslationLanguage(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        int languageID = (Integer) args.get("languageID");

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getLiveTranscriptionHelper().setTranslationLanguage(languageID)));
            }
        });

    }

    public void getTranslationLanguage(@NonNull MethodChannel.Result result) {
        ZoomVideoSDKLiveTranscriptionHelper.ILiveTranscriptionLanguage language = getLiveTranscriptionHelper().getTranslationLanguage();

        if (language == null) {
            result.error("RNZoomVideoSdkLiveTranscriptionHelper::getTranslationLanguage ", "translation language doesn't exist", null);
            return;
        }

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkILiveTranscriptionLanguage.jsonLanguage(language));
            }
        });
    }

    public void isReceiveSpokenLanguageContentEnabled(@NonNull MethodChannel.Result result) {
        result.success(getLiveTranscriptionHelper().isReceiveSpokenLanguageContentEnabled());
    }

    public void enableReceiveSpokenLanguageContent(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Map<String, Object> args = call.arguments();
        boolean enable = (boolean) args.get("enable");

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkErrors.valueOf(getLiveTranscriptionHelper().enableReceiveSpokenLanguageContent(enable)));
            }
        });
    }

    public void isAllowViewHistoryTranslationMessageEnabled(@NonNull MethodChannel.Result result) {
        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(getLiveTranscriptionHelper().isAllowViewHistoryTranslationMessageEnabled());
            }
        });
    }

    public void getHistoryTranslationMessageList(@NonNull MethodChannel.Result result) {
        List<ZoomVideoSDKLiveTranscriptionHelper.ILiveTranscriptionMessageInfo> messageInfoList = getLiveTranscriptionHelper().getHistoryTranslationMessageList();

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                result.success(FlutterZoomVideoSdkILiveTranscriptionMessageInfo.jsonMessageInfoArray(messageInfoList));
            }
        });

    }
}
