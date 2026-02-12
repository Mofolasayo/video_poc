package com.flutterzoom.videosdk_example;

import android.app.Notification;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDK;

public class MainActivity extends FlutterFragmentActivity implements SimpleEventBus.EventListener {
    public final static int REQUEST_SHARE_SCREEN_PERMISSION = 1001;
    private static final String TAG = "MainActivity";
    private static final String CHANNEL = "flutter_zoom_videosdk_activity";
    static MainActivity instance;
    private Intent mScreenInfoData;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        instance = this;
        SimpleEventBus.get().register(SimpleEventBus.EVENT_MEDIA_PROJECTION_FOREGROUND_SERVICE_STARTED, this);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        SimpleEventBus.get().unRegister(SimpleEventBus.EVENT_MEDIA_PROJECTION_FOREGROUND_SERVICE_STARTED, this);
    }

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("stopShareScreen")) {
                        Log.d(TAG, "receive stopShareScreen");
                        onStopShareScreen();
                        result.success(null);
                    } else {
                        result.notImplemented();
                    }
                });
    }


    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        switch (requestCode) {
            case REQUEST_SHARE_SCREEN_PERMISSION:
                Log.d(TAG, "onActivityResult REQUEST_SHARE_SCREEN_PERMISSION");
                if (resultCode != RESULT_OK) {
                    if (BuildConfig.DEBUG)
                        Log.d(TAG, "onActivityResult REQUEST_SHARE_SCREEN_PERMISSION no ok ");
                    break;
                }
                onStartShareScreen(data);
                break;
        }
    }
    public static Context getInstance(){
        return instance.getApplicationContext();
    }
    public static Notification getNotification(){
        return NotificationMgr.getConfNotification();
    }

    protected void onStartShareScreen(Intent data) {
        mScreenInfoData = data;
        if (Build.VERSION.SDK_INT >= 29) {
            //MediaProjection  need service with foregroundServiceType mediaProjection in android Q
            boolean hasForegroundNotification = NotificationMgr.hasNotification(NotificationMgr.PT_NOTICICATION_ID);
            if (Build.VERSION.SDK_INT >= 34) {
                Bundle args = new Bundle();
                Intent intent = new Intent(getApplicationContext(), NotificationService.class);
                args.putInt(NotificationService.ARG_COMMAND_TYPE, NotificationService.COMMAND_MEDIA_PROJECTION_START);
                intent.putExtra(NotificationService.ARGS_EXTRA, args);
                intent.setClassName(getPackageName(), "com.flutterzoom.videosdk_example.NotificationService");
                startForegroundService(intent);
            } else {
                if (!hasForegroundNotification) {
                    Intent intent = new Intent(this, NotificationService.class);
                    startForegroundService(intent);
                }
            }
        }

        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            startShareScreen();
        }
    }

    private void startShareScreen() {
        int ret = ZoomVideoSDK.getInstance().getShareHelper().startShareScreen(mScreenInfoData);
    }

    protected void onStopShareScreen() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            Bundle args = new Bundle();
            Intent intent = new Intent(getApplicationContext(), NotificationService.class);
            args.putInt(NotificationService.ARG_COMMAND_TYPE, NotificationService.COMMAND_MEDIA_PROJECTION_END);
            intent.putExtra(NotificationService.ARGS_EXTRA, args);
            startForegroundService(intent);
        }
    }

    @Override
    public void onEvent(int eventId, Object extras) {
        switch (eventId) {
            case SimpleEventBus.EVENT_MEDIA_PROJECTION_FOREGROUND_SERVICE_STARTED:
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
                    startShareScreen();
                }
                break;
        }

    }
}
