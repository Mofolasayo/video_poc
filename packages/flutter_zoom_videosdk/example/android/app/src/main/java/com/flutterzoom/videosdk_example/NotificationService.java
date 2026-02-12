package com.flutterzoom.videosdk_example;

import android.Manifest;
import android.app.Notification;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ServiceInfo;
import android.os.Binder;
import android.os.Build;
import android.os.Bundle;
import android.os.IBinder;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;

import us.zoom.sdk.ZoomVideoSDK;

public class NotificationService extends Service {
  private static final String TAG="NotificationService";

  private final IBinder binder = new LocalBinder();

  public static final String ARG_COMMAND_TYPE = "args_command_type";
  public static final String ARGS_EXTRA = "args_extra";
  public static final int COMMAND_MEDIA_PROJECTION_START = 0;
  public static final int COMMAND_MEDIA_PROJECTION_END = 1;

  public class LocalBinder extends Binder {
    NotificationService getService() {
      return NotificationService.this;
    }
  }

  private static boolean isAtLeastU() {
    return Build.VERSION.SDK_INT >= 34;
  }

  @RequiresApi(api = Build.VERSION_CODES.Q)
  public int getCurrentForegroundServiceType() {
    int foregroundServiceType = getForegroundServiceType() | ServiceInfo.FOREGROUND_SERVICE_TYPE_MEDIA_PLAYBACK;
    if (ZoomVideoSDK.getInstance().getShareHelper().isScreenSharingOut()) {
      foregroundServiceType |= ServiceInfo.FOREGROUND_SERVICE_TYPE_MEDIA_PROJECTION;
    } else {
      foregroundServiceType &= ~ServiceInfo.FOREGROUND_SERVICE_TYPE_MEDIA_PROJECTION;
    }
    if (isAtLeastU()) {
      if (!hasPermission(getApplicationContext(), android.Manifest.permission.RECORD_AUDIO)) {
        foregroundServiceType &= ~ServiceInfo.FOREGROUND_SERVICE_TYPE_MICROPHONE;
      } else {
        foregroundServiceType |= ServiceInfo.FOREGROUND_SERVICE_TYPE_MICROPHONE;
      }
      if (!hasPermission(getApplicationContext(), Manifest.permission.BLUETOOTH_CONNECT)) {
        foregroundServiceType &= ~ServiceInfo.FOREGROUND_SERVICE_TYPE_CONNECTED_DEVICE;
      } else {
        foregroundServiceType |= ServiceInfo.FOREGROUND_SERVICE_TYPE_CONNECTED_DEVICE;
      }
    }
    return foregroundServiceType;
  }

  public static boolean hasPermission(@Nullable Context context, @NonNull String permission){
    if(context == null)
      return false;
    if(Build.VERSION.SDK_INT < Build.VERSION_CODES.M)
      return true;
    try{
      return context.checkSelfPermission(permission) == PackageManager.PERMISSION_GRANTED;
    }
    catch (Throwable e){
      return false;
    }
  }

  @Override
  public void onCreate() {
    super.onCreate();
    Notification notification = NotificationMgr.getConfNotification();
    if (null != notification) {
      if (isAtLeastU()) {
        startForeground(NotificationMgr.PT_NOTICICATION_ID, notification, getCurrentForegroundServiceType());
      } else {
        startForeground(NotificationMgr.PT_NOTICICATION_ID, notification);
      }
    } else {
      stopSelf();
    }
  }

  @Override
  public int onStartCommand(Intent intent, int flags, int startId) {
    Log.d(TAG, "service onStartCommand");
    if (isAtLeastU()) {
      Bundle args = intent.getBundleExtra(ARGS_EXTRA);
      if (args != null) {
        int commandType = args.getInt(ARG_COMMAND_TYPE);
        if (commandType == COMMAND_MEDIA_PROJECTION_START) {
          Log.d(TAG, "service onStartCommand COMMAND_MEDIA_PROJECTION_START");
          doMediaProjection(true);
        } else if (commandType == COMMAND_MEDIA_PROJECTION_END) {
          Log.d(TAG, "service onStartCommand COMMAND_MEDIA_PROJECTION_END");
          doMediaProjection(false);
        }
      }
    }
    return START_NOT_STICKY;
  }

  private void doMediaProjection(boolean start) {
    if (isAtLeastU()) {
      int foregroundServiceType = getCurrentForegroundServiceType();
      if (start) {
        foregroundServiceType |= ServiceInfo.FOREGROUND_SERVICE_TYPE_MEDIA_PROJECTION;
      } else {
        foregroundServiceType &= ~ServiceInfo.FOREGROUND_SERVICE_TYPE_MEDIA_PROJECTION;
      }
      Notification notification = NotificationMgr.getConfNotification();
      if (notification != null) {
        startForeground(NotificationMgr.PT_NOTICICATION_ID, notification, foregroundServiceType);
      }
      if (start) {
        SimpleEventBus.get().post(SimpleEventBus.EVENT_MEDIA_PROJECTION_FOREGROUND_SERVICE_STARTED, null);
      }
    }
  }

  @Override
  public void onDestroy() {
    super.onDestroy();
    Log.d(TAG, "service onDestroy isInSession=:" + ZoomVideoSDK.getInstance().isInSession());
  }

  @Override
  public IBinder onBind(Intent intent) {
    return binder;
  }

  public void onTaskRemoved(Intent rootIntent) {
    Log.d(TAG, "service onTaskRemoved:"+rootIntent);
    NotificationMgr.removeConfNotification();
    stopSelf();
    ZoomVideoSDK.getInstance().getShareHelper().stopShare();
    ZoomVideoSDK.getInstance().leaveSession(false);
  }

}
