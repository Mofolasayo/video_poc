package com.flutterzoom.videosdk_example;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

public class SimpleEventBus {

    private volatile static SimpleEventBus sInstance;
    public static final int EVENT_MEDIA_PROJECTION_FOREGROUND_SERVICE_STARTED = 0;

    private SimpleEventBus() {
    }

    private ConcurrentHashMap<Integer, List<EventListener>> mEventListeners = new ConcurrentHashMap<>();

    public interface EventListener {
        void onEvent(int eventId, Object extras);
    }

    public static SimpleEventBus get() {
        if (sInstance == null) {
            synchronized (SimpleEventBus.class) {
                if (sInstance == null) {
                    sInstance = new SimpleEventBus();
                }
            }
        }
        return sInstance;
    }

    public void register(int eventId, EventListener eventListener) {
        List<EventListener> eventListeners = mEventListeners.get(eventId);
        if (eventListeners == null) {
            eventListeners = new ArrayList<>();
            mEventListeners.put(eventId, eventListeners);
        }
        eventListeners.add(eventListener);
    }

    public void unRegister(int eventId, EventListener eventListener) {
        List<EventListener> eventListeners = mEventListeners.get(eventId);
        if (eventListeners == null) {
            return;
        }
        eventListeners.removeIf(l -> l == eventListener);
    }

    public void post(int eventId, Object extras) {
        List<EventListener> eventListeners = mEventListeners.get(eventId);
        if (eventListeners == null) {
            return;
        }
        for (EventListener l : eventListeners) {
            l.onEvent(eventId, extras);
        }
    }
}
