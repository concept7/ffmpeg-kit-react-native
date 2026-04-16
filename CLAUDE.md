# ffmpeg-kit-react-native

## Project structure

- `src/index.js` — JS bridge (sourced from concept7/ffmpeg-kit-react-native@0.2)
- `src/index.d.ts` — TypeScript type definitions
- `ios/` — iOS native module (Objective-C)
- `android/` — Android native module (Java)
- `android/libs/ffmpeg-kit-6.1.1.aar` — Android FFmpeg Kit binary (16KB page size compatible)
- `ios/Frameworks/` — iOS xcframeworks, cloned at `pod install` from concept7/ffmpeg-kit-ios (gitignored)

## Dependencies

### iOS
- ffmpeg-kit 6.0 full-gpl xcframeworks from [concept7/ffmpeg-kit-ios](https://github.com/concept7/ffmpeg-kit-ios), branch `6.0`
- Fetched automatically via `prepare_command` in the podspec — no manual steps needed

### Android
- ffmpeg-kit 6.1.1 full-gpl AAR from [moizhassankh/ffmpeg-kit-android-16KB](https://github.com/moizhassankh/ffmpeg-kit-android-16KB)
- Committed to `android/libs/ffmpeg-kit-6.1.1.aar`
- Built with 16KB memory page size support (required for Google Play API 35+)

## Updating binaries

### iOS xcframeworks
Update the `--branch` tag in the `prepare_command` in `ffmpeg-kit-react-native.podspec` to point to the new branch/tag in concept7/ffmpeg-kit-ios.

### Android AAR
Replace `android/libs/ffmpeg-kit-6.1.1.aar` with the new AAR and update the filename referenced in `android/build.gradle`.

## React Native compatibility

- Requires React Native 0.84+
- Android: `minSdkVersion 24`, `compileSdkVersion 36`, Java 17
- iOS: deployment target 13.4
