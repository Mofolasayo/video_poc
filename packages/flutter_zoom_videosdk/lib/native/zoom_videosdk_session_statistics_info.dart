/// Zoom Video SDK Session Audio Statistics Information
class ZoomVideoSdkSessionAudioStatisticsInfo {
  num recvFrequency; /// session receive frequency
  num recvJitter; /// session receive jitter
  num recvLatency; /// session receive latency
  num recvPacketLossAvg; /// session receive packet loss average value
  num recvPacketLossMax; /// session receive packet loss max value
  num sendFrequency; /// session send frequency
  num sendJitter; /// session send jitter
  num sendLatency; /// session send latency
  num sendPacketLossAvg; /// session send packet loss average value
  num sendPacketLossMax; /// session send packet loss max value

  ZoomVideoSdkSessionAudioStatisticsInfo(
      this.recvFrequency,
      this.recvJitter,
      this.recvLatency,
      this.recvPacketLossAvg,
      this.recvPacketLossMax,
      this.sendFrequency,
      this.sendJitter,
      this.sendLatency,
      this.sendPacketLossAvg,
      this.sendPacketLossMax);

  ZoomVideoSdkSessionAudioStatisticsInfo.fromJson(Map<String, dynamic> json)
      : recvFrequency = json['recvFrequency'],
        recvJitter = json['recvJitter'],
        recvLatency = json['recvLatency'],
        recvPacketLossAvg = json['recvPacketLossAvg'],
        recvPacketLossMax = json['recvPacketLossMax'],
        sendFrequency = json['sendFrequency'],
        sendJitter = json['sendJitter'],
        sendLatency = json['sendLatency'],
        sendPacketLossAvg = json['sendPacketLossAvg'],
        sendPacketLossMax = json['sendPacketLossMax'];

  Map<String, dynamic> toJson() => {
        'recvFrequency': recvFrequency,
        'recvJitter': recvJitter,
        'recvLatency': recvLatency,
        'recvPacketLossAvg': recvPacketLossAvg,
        'recvPacketLossMax': recvPacketLossMax,
        'sendFrequency': sendFrequency,
        'sendJitter': sendJitter,
        'sendLatency': sendLatency,
        'sendPacketLossAvg': sendPacketLossAvg,
        'sendPacketLossMax': sendPacketLossMax,
      };
}

/// Zoom Video SDK Session Video Statistics Information
class ZoomVideoSdkSessionVideoStatisticsInfo {
  num recvFps; /// the video's Frames Per Second session receive
  num recvFrameHeight; /// the video's frame height in pixels session receive
  num recvFrameWidth; /// the video's frame width in pixels session receive
  num recvJitter; /// session receive jitter
  num recvLatency; /// session receive latency
  num recvPacketLossAvg; /// session receive packet loss average value
  num recvPacketLossMax; /// session receive packet loss max value
  num sendFps; /// the video's Frames Per Second session send
  num sendFrameHeight; /// the video's frame height in pixels session send
  num sendFrameWidth; /// the video's frame width in pixels session send
  num sendJitter; /// session send jitter
  num sendLatency; /// session send latency
  num sendPacketLossAvg; /// session send packet loss average value
  num sendPacketLossMax; /// session send packet loss max value

  ZoomVideoSdkSessionVideoStatisticsInfo(
      this.recvFps,
      this.recvFrameHeight,
      this.recvFrameWidth,
      this.recvJitter,
      this.recvLatency,
      this.recvPacketLossAvg,
      this.recvPacketLossMax,
      this.sendFps,
      this.sendFrameHeight,
      this.sendFrameWidth,
      this.sendJitter,
      this.sendLatency,
      this.sendPacketLossAvg,
      this.sendPacketLossMax);

  ZoomVideoSdkSessionVideoStatisticsInfo.fromJson(Map<String, dynamic> json)
      : recvFps = json['recvFps'],
        recvFrameHeight = json['recvFps'],
        recvFrameWidth = json['recvFps'],
        recvJitter = json['recvJitter'],
        recvLatency = json['recvLatency'],
        recvPacketLossAvg = json['recvPacketLossAvg'],
        recvPacketLossMax = json['recvPacketLossMax'],
        sendFps = json['sendFps'],
        sendFrameHeight = json['sendFrameHeight'],
        sendFrameWidth = json['sendFrameWidth'],
        sendJitter = json['sendJitter'],
        sendLatency = json['sendLatency'],
        sendPacketLossAvg = json['sendPacketLossAvg'],
        sendPacketLossMax = json['sendPacketLossMax'];

  Map<String, dynamic> toJson() => {
        'recvFps': recvFps,
        'recvFrameHeight': recvFrameHeight,
        'recvFrameWidth': recvFrameWidth,
        'recvJitter': recvJitter,
        'recvLatency': recvLatency,
        'recvPacketLossAvg': recvPacketLossAvg,
        'recvPacketLossMax': recvPacketLossMax,
        'sendFps': sendFps,
        'sendFrameHeight': sendFrameHeight,
        'sendFrameWidth': sendFrameWidth,
        'sendJitter': sendJitter,
        'sendLatency': sendLatency,
        'sendPacketLossAvg': sendPacketLossAvg,
        'sendPacketLossMax': sendPacketLossMax,
      };
}

class ZoomVideoSdkSessionShareStatisticsInfo {
  num recvFps; /// the video's Frames Per Second session receive
  num recvFrameHeight; /// the video's frame height in pixels session receive
  num recvFrameWidth; /// the video's frame width in pixels session receive
  num recvJitter; /// session receive jitter
  num recvLatency; /// session receive latency
  num recvPacketLossAvg; /// session receive packet loss average value
  num recvPacketLossMax; /// session receive packet loss max value
  num sendFps; /// the video's Frames Per Second session send
  num sendFrameHeight; /// the video's frame height in pixels session send
  num sendFrameWidth; /// the video's frame width in pixels session send
  num sendJitter; /// session send jitter
  num sendLatency; /// session send latency
  num sendPacketLossAvg; /// session send packet loss average value
  num sendPacketLossMax; /// session send packet loss max value

  ZoomVideoSdkSessionShareStatisticsInfo(
      this.recvFps,
      this.recvFrameHeight,
      this.recvFrameWidth,
      this.recvJitter,
      this.recvLatency,
      this.recvPacketLossAvg,
      this.recvPacketLossMax,
      this.sendFps,
      this.sendFrameHeight,
      this.sendFrameWidth,
      this.sendJitter,
      this.sendLatency,
      this.sendPacketLossAvg,
      this.sendPacketLossMax);

  ZoomVideoSdkSessionShareStatisticsInfo.fromJson(Map<String, dynamic> json)
      : recvFps = json['recvFps'],
        recvFrameHeight = json['recvFps'],
        recvFrameWidth = json['recvFps'],
        recvJitter = json['recvJitter'],
        recvLatency = json['recvLatency'],
        recvPacketLossAvg = json['recvPacketLossAvg'],
        recvPacketLossMax = json['recvPacketLossMax'],
        sendFps = json['sendFps'],
        sendFrameHeight = json['sendFrameHeight'],
        sendFrameWidth = json['sendFrameWidth'],
        sendJitter = json['sendJitter'],
        sendLatency = json['sendLatency'],
        sendPacketLossAvg = json['sendPacketLossAvg'],
        sendPacketLossMax = json['sendPacketLossMax'];

  Map<String, dynamic> toJson() => {
        'recvFps': recvFps,
        'recvFrameHeight': recvFrameHeight,
        'recvFrameWidth': recvFrameWidth,
        'recvJitter': recvJitter,
        'recvLatency': recvLatency,
        'recvPacketLossAvg': recvPacketLossAvg,
        'recvPacketLossMax': recvPacketLossMax,
        'sendFps': sendFps,
        'sendFrameHeight': sendFrameHeight,
        'sendFrameWidth': sendFrameWidth,
        'sendJitter': sendJitter,
        'sendLatency': sendLatency,
        'sendPacketLossAvg': sendPacketLossAvg,
        'sendPacketLossMax': sendPacketLossMax,
      };
}
