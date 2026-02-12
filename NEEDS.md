# Video POC Needs / TODO

## Critical (blocking for real calls)
- Zoom Video SDK Key + Secret (from Zoom SDK portal)
- Backend JWT endpoint (HTTPS) that returns short-lived Video SDK token
- Base API URL for token endpoint

## Native SDK setup
- Android: Zoom Video SDK dependency configured in Gradle
- iOS: Zoom Video SDK Pod added to `ios/Podfile`
- Replace placeholder native bridge with real Zoom SDK session + video binding
- Android permissions: INTERNET, CAMERA, RECORD_AUDIO, MODIFY_AUDIO_SETTINGS
- iOS permissions: NSCameraUsageDescription, NSMicrophoneUsageDescription

## Flutter integration
- MethodChannel contract finalized (methods + events)
- PlatformView IDs for local/remote video
- Call state enum + ViewModel lifecycle
- UI for call controls (mute, camera, end)
- Configure `VIDEO_POC_API_URL` (dart-define) for physical devices

## Backend details
- JWT payload format confirmed against Zoom docs
- Include `version: 1` in the Video SDK JWT payload (required by Zoom examples; avoids join/auth issues)
- Token TTL policy (short-lived)
- Basic logging and rate limiting
- Backend project created at `/Users/mofolasayo-osikoya/video_poc_backend` (set env + deploy)
- Public HTTPS URL for remote testers (tunnel or deployment)
 - Render URL: https://video-poc-backend.onrender.com (release default)

## Product flow items (can stub now)
- Session name generation strategy
- “User B” call accept/decline flow (push/notification or in-app)
- Error handling and failed call UX
 - App distribution for remote testers (TestFlight / APK)

## Optional (can defer)
- Wakelock handling during calls
- Analytics (join time, call duration)
