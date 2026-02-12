package com.flutterzoom.videosdk;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import us.zoom.sdk.ZoomVideoSDKChatMessage;
import us.zoom.sdk.ZoomVideoSDKUser;

public class FlutterZoomVideoSdkChatMessage {

    public static String jsonMessageArray(List<ZoomVideoSDKChatMessage> messageList) {
        JsonArray mappedMessageArray = new JsonArray();
        for (ZoomVideoSDKChatMessage message : messageList) {
            JsonElement jsonMessage = new Gson().fromJson(jsonMessage(message), JsonElement.class);
            mappedMessageArray.add(jsonMessage);
        }

        return mappedMessageArray.toString();
    }

    public static String jsonMessage(ZoomVideoSDKChatMessage chatMessage) {
        Map<String, Object> mappedChatMessage = new HashMap<>();
        Gson gson = new GsonBuilder().create();
        if (chatMessage == null) {
            return gson.toJson(mappedChatMessage);
        }
        ZoomVideoSDKUser receiver = chatMessage.getReceiverUser();
        if (receiver != null) {
            mappedChatMessage.put("receiverUser", FlutterZoomVideoSdkUser.jsonUser(receiver));
        }
        mappedChatMessage.put("senderUser", FlutterZoomVideoSdkUser.jsonUser(chatMessage.getSenderUser()));
        mappedChatMessage.put("content", chatMessage.getContent());
        mappedChatMessage.put("timestamp", chatMessage.getTimeStamp());
        mappedChatMessage.put("isChatToAll", chatMessage.isChatToAll());
        mappedChatMessage.put("isSelfSend", chatMessage.isSelfSend());
        mappedChatMessage.put("messageID", chatMessage.getMessageId());


        String jsonMessage = gson.toJson(mappedChatMessage);

        return jsonMessage;
    }

}
