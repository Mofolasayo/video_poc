package com.flutterzoom.videosdk;

import androidx.annotation.NonNull;

import java.util.List;

import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKSession;
import us.zoom.sdk.ZoomVideoSDKUser;

public class FlutterZoomVideoSdkSession {

    private ZoomVideoSDKSession getSession() {
        ZoomVideoSDKSession session = null;
        try {
            session = ZoomVideoSDK.getInstance().getSession();
            if (session == null) {
                throw new Exception("No Session Found");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return session;
    }

    public void getMySelf(@NonNull MethodChannel.Result result) {
        ZoomVideoSDKUser mySelf = getSession().getMySelf();

        if (mySelf == null) {
            result.error("FlutterZoomVideoSdkSession::getMySelf ", "mySelf doesn't exist in the session", null);
            return;
        }

        result.success(FlutterZoomVideoSdkUser.jsonUser(mySelf));
    }

    public void getRemoteUsers(@NonNull MethodChannel.Result result) {
        List<ZoomVideoSDKUser> remoteUsers = getSession().getRemoteUsers();

        if (remoteUsers == null) {
            result.error("RNZoomVideoSdkSession::getRemoteUsers", "remote users don't exist in the session", null);
            return;
        }

        result.success(FlutterZoomVideoSdkUser.jsonUserArray(remoteUsers));
    }

    public void getSessionHost(@NonNull MethodChannel.Result result) {
        ZoomVideoSDKUser hostUser = getSession().getSessionHost();

        if (hostUser == null) {
            result.error("RNZoomVideoSdkSession::getSessionHost", "host user doesn't exist in the session", null);
            return;
        }

        result.success(hostUser);
    }

    public void getSessionHostName(@NonNull MethodChannel.Result result) {
        String hostName = getSession().getSessionHostName();

        if (hostName == null) {
            result.error("RNZoomVideoSdkSession::getSessionHostName", "host name doesn't exist", null);
        }

        result.success(hostName);
    }

    public void getSessionName(@NonNull MethodChannel.Result result) {
        String sessionName = getSession().getSessionName();

        if (sessionName == null) {
            result.error("RNZoomVideoSdkSession::getSessionName", "session name doesn't exist", null);
        }

        result.success(sessionName);
    }

    public void getSessionID(@NonNull MethodChannel.Result result) {
        if (getSession() == null) {
            result.error("RNZoomVideoSdkSession::getSessionID", "session does not exist", null);
        }
        String sessionID = getSession().getSessionID();

        result.success(sessionID);
    }

    public void getSessionPassword(@NonNull MethodChannel.Result result) {
        if (getSession() == null) {
            result.error("RNZoomVideoSdkSession::getSessionPassword", "session doesn't exist", null);
        }
        String sessionPassword = getSession().getSessionPassword();

        result.success(sessionPassword);
    }

    public void getSessionNumber(@NonNull MethodChannel.Result result) {
        long sessionNumber = getSession().getSessionNumber();
        result.success(Long.toString(sessionNumber));

    }

    public void getSessionPhonePasscode(@NonNull MethodChannel.Result result) {
        String sessionPhonePasscode = getSession().getSessionPhonePasscode();
        if (sessionPhonePasscode == null) {
            result.error("RNZoomVideoSdkSession::getSessionPhonePasscode", "session passcode doesn't exist", null);
        }
        result.success(sessionPhonePasscode);

    }

    public void getSessionShareStatisticInfo(@NonNull MethodChannel.Result result) {
        /* No-op: RNZoomVideoSdkSessionStatisticsInfoModule */
    }

    public void getSessionVideoStatisticInfo(@NonNull MethodChannel.Result result) {
        /* No-op: RNZoomVideoSdkSessionStatisticsInfoModule */
    }

    public void getSessionAudioStatisticInfo(@NonNull MethodChannel.Result result) {
        /* No-op: RNZoomVideoSdkSessionStatisticsInfoModule */
    }




}
