# flutter-zoom-video-sdk

Video SDK for Flutter

## Getting started

To make it easy for you to get started with Flutter Video SDK, here's a list of recommended next steps.

Not yet download the Flutter? [Download FLutter](https://docs.flutter.dev/get-started/install)

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Usage

The SDK initialize configuration needs to be fill in `main.dart`

```dart
InitConfig initConfig = InitConfig(
  domain: "zoom.us",
  enableLog: true,
);
```

Get the Video SDK instance.

```dart
var zoom = ZoomVideoSdk();
```

Open the event channel and listen to native SDK event

```dart
var eventListener = ZoomVideoSdkEventListener();
```

Generate an [SDK JWT Token](https://developers.zoom.us/docs/video-sdk/auth/).

Then, join a session.

```dart
Map<String, bool> SDKaudioOptions = {
  "connect": true, 
  "mute": true
};
Map<String, bool> SDKvideoOptions = {
  "localVideoOn": true,
};
JoinSessionConfig joinSession = JoinSessionConfig(
  sessionName:"sessionName",
  sessionPassword: "sessionPwd",
  token: "JWT token",
  userName: "displayName",
  audioOptions: SDKaudioOptions,
  videoOptions: SDKvideoOptions,
  sessionIdleTimeoutMins: "time out minutes",
);
await zoom.joinSession(joinSession);
```

## Sample App

Checkout the Zoom Flutter Video SDK Sample App in the `example` directory.

## Documentation
Please visit [Video SDK for Flutter](https://developers.zoom.us/docs/video-sdk/flutter) to learn how to use the SDK wrapper and run the sample application.

For the full list of APIs and Event Listeners, see the [Reference](https://marketplacefront.zoom.us/sdk/custom/flutter/index.html).

## Need help?

If you're looking for help, try [Developer Support](https://devsupport.zoom.us/) or our [Developer Forum](https://devforum.zoom.us). Priority support is also available with [Premier Developer Support plans](https://zoom.us/docs/en-us/developer-support-plans.html).

## Changelog

For the changelog, see [Video SDK for Flutter](https://developers.zoom.us/changelog/video-sdk/flutter/).

## License

Use of this SDK is subject to our [License and Terms of Use](https://explore.zoom.us/en/video-sdk-terms/);

## Open Source Software Source Code

Some licenses for OSS contained in our products give you the right to access the source code under said license. You may obtain a copy of source code for the relevant OSS via the following link: https://zoom.us/opensource/source. Please obtain independent legal advice or counsel to determine your responsibility to make source code available under any specific OSS project.

Please see [oss_attribution.txt](oss_attribution.txt) for more information.

---
Copyright ©2023 Zoom Video Communications, Inc. All rights reserved.

***

