# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

# ffmpeg-kit-react-native

## Commands

```bash
npm test          # Run Jest test suite
npm run lint      # ESLint (JS/TS/TSX)
```

No build step — `src/index.js` is the entry point, consumed directly by Metro.

## Project structure

- `src/index.js` — JS bridge (sourced from concept7/ffmpeg-kit-react-native@0.2)
- `src/index.d.ts` — TypeScript type definitions
- `ios/` — iOS native module (Objective-C)
- `android/` — Android native module (Java)
- `android/libs/ffmpeg-kit-6.x.aar` — Android FFmpeg Kit binary (16KB page size compatible)
- `ios/Frameworks/` — iOS xcframeworks, cloned at `pod install` from concept7/ffmpeg-kit-ios (gitignored)

## Architecture

This is a React Native native module. The flow is:

```
JS (src/index.js) ↔ NativeEventEmitter ↔ iOS (Objective-C) / Android (Java) ↔ FFmpeg Kit C library
```

**JS bridge (`src/index.js`):**
- `FFmpegKit` — execute FFmpeg commands (sync and async)
- `FFprobeKit` — run FFprobe / retrieve media information
- `FFmpegKitConfig` — global config: log levels, session history, font management, SAF integration
- Session classes: `FFmpegSession`, `FFprobeSession`, `MediaInformationSession`, `AbstractSession`
- Data classes: `Log`, `Statistics`, `MediaInformation`, `StreamInformation`, `ReturnCode`
- Enums: `LogRedirectionStrategy`, `SessionState`, `Signal`, `Level`

**Event-driven callback bridge:**  
Native code emits three event types (`FFmpegKitLogCallbackEvent`, `FFmpegKitStatisticsCallbackEvent`, `FFmpegKitCompleteCallbackEvent`). The JS side maintains callback maps keyed by sessionId and dispatches to user-supplied closures. Fallback polling is used when native events are unavailable.

**Android specifics:**  
- `FFmpegKitReactNativeModule.java` — main module; ExecutorService capped at 10 concurrent sessions
- Task classes per operation type: `FFmpegSessionExecuteTask`, `FFprobeSessionExecuteTask`, `MediaInformationSessionExecuteTask`, `WriteToPipeTask`
- SAF (Storage Access Framework) integration for file picker / document access

**iOS specifics:**  
- `FFmpegKitReactNativeModule.m` — implements `RCTEventEmitter<RCTBridgeModule>`
- Global async dispatch queue for background execution

## Dependencies

### iOS
- ffmpeg-kit 6.0 full-gpl xcframeworks from [concept7/ffmpeg-kit-ios](https://github.com/concept7/ffmpeg-kit-ios), branch `6.0`
- Fetched automatically via `prepare_command` in the podspec — no manual steps needed

### Android
- ffmpeg-kit 6.0 full-gpl AAR from [concept7/ffmpeg-kit-android](https://github.com/concept7/ffmpeg-kit-android), release `v6.0.0`
- Committed to `android/libs/ffmpeg-kit-6.x.aar`

## Updating binaries

### iOS xcframeworks
Update the `--branch` tag in the `prepare_command` in `ffmpeg-kit-react-native.podspec` to point to the new branch/tag in concept7/ffmpeg-kit-ios.

### Android AAR
Download the new AAR from [concept7/ffmpeg-kit-android](https://github.com/concept7/ffmpeg-kit-android) releases, replace `android/libs/ffmpeg-kit-6.x.aar`, and update the version references in `android/build.gradle` and `CLAUDE.md`.

## React Native compatibility

- Requires React Native 0.84+
- Android: `minSdkVersion 24`, `compileSdkVersion 36`, Java 17
- iOS: deployment target 13.4
