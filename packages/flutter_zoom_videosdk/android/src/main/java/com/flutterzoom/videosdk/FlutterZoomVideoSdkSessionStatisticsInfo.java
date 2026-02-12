package com.flutterzoom.videosdk;

import androidx.annotation.NonNull;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;
import us.zoom.sdk.ZoomVideoSDK;
import us.zoom.sdk.ZoomVideoSDKSession;

public class FlutterZoomVideoSdkSessionStatisticsInfo {

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

    // -----------------------------------------------------------------------------------------------
    // region Audio Statistics Info
    // -----------------------------------------------------------------------------------------------
    
    public void getAudioStatisticsInfo(@NonNull MethodChannel.Result result) {
        int recvFrequency = getSession().getSessionAudioStatisticInfo().getRecvFrequency();
        int recvJitter = getSession().getSessionAudioStatisticInfo().getRecvJitter();
        int recvLatency = getSession().getSessionAudioStatisticInfo().getRecvLatency();
        float recvPacketLossAvg = getSession().getSessionAudioStatisticInfo().getRecvPacketLossAvg();
        float recvPacketLossMax = getSession().getSessionAudioStatisticInfo().getRecvPacketLossMax();
        int sendFrequency = getSession().getSessionAudioStatisticInfo().getSendFrequency();
        int sendJitter = getSession().getSessionAudioStatisticInfo().getSendJitter();
        int sendLatency = getSession().getSessionAudioStatisticInfo().getSendLatency();
        float sendPacketLossAvg = getSession().getSessionAudioStatisticInfo().getSendPacketLossAvg();
        float sendPacketLossMax = getSession().getSessionAudioStatisticInfo().getSendPacketLossMax();

        Map<String, Object> info = new HashMap<>();
        info.put("recvFrequency", recvFrequency);
        info.put("recvJitter", recvJitter);
        info.put("recvLatency", recvLatency);
        info.put("recvPacketLossAvg", recvPacketLossAvg);
        info.put("recvPacketLossMax", recvPacketLossMax);
        info.put("sendFrequency", sendFrequency);
        info.put("sendJitter", sendJitter);
        info.put("sendLatency", sendLatency);
        info.put("sendPacketLossAvg", sendPacketLossAvg);
        info.put("sendPacketLossMax", sendPacketLossMax);

        Gson gson = new GsonBuilder().create();
        String jsonAudioStatisticsInfo = gson.toJson(info);


        result.success(jsonAudioStatisticsInfo);
    }

    // -----------------------------------------------------------------------------------------------
    // endregion
    // -----------------------------------------------------------------------------------------------

    // -----------------------------------------------------------------------------------------------
    // region Video Statistics Info
    // -----------------------------------------------------------------------------------------------
    
    public void getVideoStatisticsInfo(@NonNull MethodChannel.Result result) {
        int recvFps = getSession().getSessionVideoStatisticInfo().getRecvFps();
        int recvFrameHeight = getSession().getSessionVideoStatisticInfo().getRecvFrameHeight();
        int recvFrameWidth = getSession().getSessionVideoStatisticInfo().getRecvFrameWidth();
        int recvJitter = getSession().getSessionVideoStatisticInfo().getRecvJitter();
        int recvLatency = getSession().getSessionVideoStatisticInfo().getRecvLatency();
        float recvPacketLossAvg = getSession().getSessionVideoStatisticInfo().getRecvPacketLossAvg();
        float recvPacketLossMax = getSession().getSessionVideoStatisticInfo().getRecvPacketLossMax();
        int sendFps = getSession().getSessionVideoStatisticInfo().getSendFps();
        int sendFrameHeight = getSession().getSessionVideoStatisticInfo().getSendFrameHeight();
        int sendFrameWidth = getSession().getSessionVideoStatisticInfo().getSendFrameWidth();
        int sendJitter = getSession().getSessionVideoStatisticInfo().getSendJitter();
        int sendLatency = getSession().getSessionVideoStatisticInfo().getSendLatency();
        float sendPacketLossAvg = getSession().getSessionVideoStatisticInfo().getSendPacketLossAvg();
        float sendPacketLossMax = getSession().getSessionVideoStatisticInfo().getSendPacketLossMax();

        Map<String, Object> info = new HashMap<>();
        info.put("recvFps", recvFps);
        info.put("recvFrameHeight", recvFrameHeight);
        info.put("recvFrameWidth", recvFrameWidth);
        info.put("recvJitter", recvJitter);
        info.put("recvLatency", recvLatency);
        info.put("recvPacketLossAvg", recvPacketLossAvg);
        info.put("recvPacketLossMax", recvPacketLossMax);
        info.put("sendFps", sendFps);
        info.put("sendFrameHeight", sendFrameHeight);
        info.put("sendFrameWidth", sendFrameWidth);
        info.put("sendJitter", sendJitter);
        info.put("sendLatency", sendLatency);
        info.put("sendPacketLossAvg", sendPacketLossAvg);
        info.put("sendPacketLossMax", sendPacketLossMax);

        Gson gson = new GsonBuilder().create();
        String jsonVideoStatisticsInfo = gson.toJson(info);


        result.success(jsonVideoStatisticsInfo);
    }

    // -----------------------------------------------------------------------------------------------
    // endregion
    // -----------------------------------------------------------------------------------------------

    // -----------------------------------------------------------------------------------------------
    // region Share Statistics Info
    // -----------------------------------------------------------------------------------------------

    
    public void getShareStatisticsInfo(@NonNull MethodChannel.Result result) {
        int recvFps = getSession().getSessionShareStatisticInfo().getRecvFps();
        int recvFrameHeight = getSession().getSessionShareStatisticInfo().getRecvFrameHeight();
        int recvFrameWidth = getSession().getSessionShareStatisticInfo().getRecvFrameWidth();
        int recvJitter = getSession().getSessionShareStatisticInfo().getRecvJitter();
        int recvLatency = getSession().getSessionShareStatisticInfo().getRecvLatency();
        float recvPacketLossAvg = getSession().getSessionShareStatisticInfo().getRecvPacketLossAvg();
        float recvPacketLossMax = getSession().getSessionShareStatisticInfo().getRecvPacketLossMax();
        int sendFps = getSession().getSessionShareStatisticInfo().getSendFps();
        int sendFrameHeight = getSession().getSessionShareStatisticInfo().getSendFrameHeight();
        int sendFrameWidth = getSession().getSessionShareStatisticInfo().getSendFrameWidth();
        int sendJitter = getSession().getSessionShareStatisticInfo().getSendJitter();
        int sendLatency = getSession().getSessionShareStatisticInfo().getSendLatency();
        float sendPacketLossAvg = getSession().getSessionShareStatisticInfo().getSendPacketLossAvg();
        float sendPacketLossMax = getSession().getSessionShareStatisticInfo().getSendPacketLossMax();

        Map<String, Object> info = new HashMap<>();
        info.put("recvFps", recvFps);
        info.put("recvFrameHeight", recvFrameHeight);
        info.put("recvFrameWidth", recvFrameWidth);
        info.put("recvJitter", recvJitter);
        info.put("recvLatency", recvLatency);
        info.put("recvPacketLossAvg", recvPacketLossAvg);
        info.put("recvPacketLossMax", recvPacketLossMax);
        info.put("sendFps", sendFps);
        info.put("sendFrameHeight", sendFrameHeight);
        info.put("sendFrameWidth", sendFrameWidth);
        info.put("sendJitter", sendJitter);
        info.put("sendLatency", sendLatency);
        info.put("sendPacketLossAvg", sendPacketLossAvg);
        info.put("sendPacketLossMax", sendPacketLossMax);

        Gson gson = new GsonBuilder().create();
        String jsonShareStatisticsInfo = gson.toJson(info);


        result.success(jsonShareStatisticsInfo);
    }

    // -----------------------------------------------------------------------------------------------
    // endregion
    // -----------------------------------------------------------------------------------------------

}
