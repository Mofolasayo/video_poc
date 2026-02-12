# Product Requirements Document (PRD)
Product: Video Call POC – Dating Application
Version: 1.0 (Proof of Concept)

## 1. Purpose
Build a proof-of-concept (POC) mobile feature that enables secure 1–1 video calls between matched users in a Flutter-based dating application using the Zoom Video SDK. The goal is to validate technical feasibility, call stability, and user experience before full production rollout.

## 2. Objectives
- Validate successful integration of Zoom Video SDK with Flutter (via native bridge).
- Enable real-time 1–1 video calls between two authenticated users.
- Ensure secure token-based session access.
- Confirm stable audio/video performance under normal network conditions.
- Success is defined as two users completing a video call without crashes or major latency issues.

## 3. Scope
### In Scope
- 1–1 video calls only
- Secure backend-generated Zoom SDK JWT
- Join / Leave session
- Mute / Unmute audio
- Enable / Disable camera
- Basic call UI
- Call state handling (Calling → Connected → Ended)

### Out of Scope (For POC)
- Group calls
- Recording
- Screen sharing
- Monetization logic
- Advanced moderation tools

## 4. User Flow
1. User A taps “Start Video Call” on a matched profile.
2. Backend generates Zoom session + JWT token.
3. User B receives in-app notification.
4. User B accepts call.
5. Both users join the same Zoom session.
6. Call begins (audio/video active).
7. Either user can mute, disable camera, or leave call.

## 5. Functional Requirements
### Call Setup
- Generate unique session name per call.
- Backend securely generates short-lived Zoom Video SDK JWT.
- Both users join using valid token.

### In-Call Controls
- Toggle microphone.
- Toggle camera.
- End call.
- Display remote participant video.
- Display local video preview.

### State Management
Call states:
- Idle
- Calling
- Connected
- Ended
- Failed

## 6. Technical Requirements
### Frontend (Flutter)
- Video call UI screen
- MethodChannel integration
- PlatformView for rendering native video
- State management for call lifecycle

### Native Layer (Android & iOS)
- Zoom Video SDK integration
- Session initialization
- Audio/video stream management
- Event callbacks to Flutter

### Backend
- Secure JWT generation endpoint
- No SDK secret exposed client-side
- HTTPS enforced

## 7. Non-Functional Requirements
- Call join time < 3 seconds (target)
- Stable call for at least 10 minutes
- No app crashes during normal usage
- Secure token expiration handling

## 8. Risks
- Native SDK integration complexity
- Token misconfiguration
- Platform-specific camera/mic permission issues
- Background app restrictions (especially iOS)

## 9. Deliverables
- Working Flutter POC (Android & iOS)
- Backend JWT service
- Demonstration of successful 1–1 video call
- Basic integration documentation
