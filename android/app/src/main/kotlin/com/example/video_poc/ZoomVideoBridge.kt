package com.example.video_poc

import android.content.Context
import android.graphics.Color
import android.os.Handler
import android.os.Looper
import android.view.Gravity
import android.view.View
import android.widget.FrameLayout
import android.widget.TextView
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

object ZoomVideoBridge {
    private val mainHandler = Handler(Looper.getMainLooper())
    var eventSink: EventChannel.EventSink? = null

    fun emit(event: String, data: Any? = null) {
        val payload = HashMap<String, Any?>()
        payload["event"] = event
        if (data != null) {
            payload["data"] = data
        }
        mainHandler.post {
            eventSink?.success(payload)
        }
    }
}

class ZoomVideoEventStreamHandler : EventChannel.StreamHandler {
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        ZoomVideoBridge.eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        ZoomVideoBridge.eventSink = null
    }
}

class ZoomVideoViewFactory(private val isLocal: Boolean) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return ZoomVideoPlatformView(context, isLocal)
    }
}

class ZoomVideoPlatformView(context: Context, private val isLocal: Boolean) : PlatformView {
    private val container: FrameLayout = FrameLayout(context).apply {
        setBackgroundColor(Color.BLACK)
        val label = TextView(context).apply {
            text = if (isLocal) "Local video" else "Remote video"
            setTextColor(Color.WHITE)
            textSize = 12f
            gravity = Gravity.CENTER
        }
        addView(label, FrameLayout.LayoutParams(
            FrameLayout.LayoutParams.MATCH_PARENT,
            FrameLayout.LayoutParams.MATCH_PARENT
        ))
    }

    override fun getView(): View = container

    override fun dispose() {
        // No-op for placeholder view.
    }
}
