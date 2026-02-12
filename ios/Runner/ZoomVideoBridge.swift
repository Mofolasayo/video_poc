import Flutter
import UIKit

final class ZoomVideoBridge {
    static let shared = ZoomVideoBridge()
    private init() {}

    var eventSink: FlutterEventSink?

    func emit(event: String, data: Any? = nil) {
        var payload: [String: Any] = ["event": event]
        if let data = data {
            payload["data"] = data
        }
        DispatchQueue.main.async {
            self.eventSink?(payload)
        }
    }
}

final class ZoomVideoEventStreamHandler: NSObject, FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        ZoomVideoBridge.shared.eventSink = events
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        ZoomVideoBridge.shared.eventSink = nil
        return nil
    }
}

final class ZoomVideoViewFactory: NSObject, FlutterPlatformViewFactory {
    private let isLocal: Bool

    init(isLocal: Bool) {
        self.isLocal = isLocal
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return ZoomVideoPlatformView(frame: frame, isLocal: isLocal)
    }
}

final class ZoomVideoPlatformView: NSObject, FlutterPlatformView {
    private let container: UIView

    init(frame: CGRect, isLocal: Bool) {
        container = UIView(frame: frame)
        container.backgroundColor = UIColor.black

        let label = UILabel(frame: container.bounds)
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = isLocal ? "Local video" : "Remote video"
        container.addSubview(label)
        super.init()
    }

    func view() -> UIView {
        return container
    }
}
