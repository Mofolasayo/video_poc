package com.flutterzoom.videosdk;

import com.flutterzoom.videosdk.convert.FlutterZoomVideoSdkLiveTranscriptionOperationType;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKLiveTranscriptionHelper;

public class FlutterZoomVideoSdkILiveTranscriptionMessageInfo {

    public static String jsonMessageInfoArray(List<ZoomVideoSDKLiveTranscriptionHelper.ILiveTranscriptionMessageInfo> messageInfoList) {
        JsonArray mappedMessageInfoArray = new JsonArray();
        for (ZoomVideoSDKLiveTranscriptionHelper.ILiveTranscriptionMessageInfo messageInfo : messageInfoList) {
            JsonElement jsonMessage = new Gson().fromJson(jsonMessageInfo(messageInfo), JsonElement.class);
            mappedMessageInfoArray.add(jsonMessage);
        }

        return mappedMessageInfoArray.toString();
    }

    public static String jsonMessageInfo(ZoomVideoSDKLiveTranscriptionHelper.ILiveTranscriptionMessageInfo messageInfo) {
        Map<String, Object> mappedMessageInfo = new HashMap<>();
        Gson gson = new GsonBuilder().create();
        if (messageInfo == null) {
            return gson.toJson(mappedMessageInfo);
        }
        mappedMessageInfo.put("messageID", messageInfo.getMessageID());
        mappedMessageInfo.put("messageContent", messageInfo.getMessageContent());
        mappedMessageInfo.put("messageType", FlutterZoomVideoSdkLiveTranscriptionOperationType.valueOf(messageInfo.getMessageType()));
        mappedMessageInfo.put("speakerName", messageInfo.getSpeakerName());
        mappedMessageInfo.put("speakerID", messageInfo.getSpeakerID());
        mappedMessageInfo.put("timeStamp", String.valueOf(messageInfo.getTimeStamp()));

        String jsonMessage = gson.toJson(mappedMessageInfo);

        return jsonMessage;
    }
}
