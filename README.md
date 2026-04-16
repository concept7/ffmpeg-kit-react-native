# ffmpeg-kit-react-native

React Native bridge for FFmpeg Kit, supporting both iOS and Android.

## Versions

| Platform | FFmpeg Kit | Variant   | Notes                        |
|----------|------------|-----------|------------------------------|
| iOS      | 6.0        | full-gpl  | xcframeworks via concept7/ffmpeg-kit-ios |
| Android  | 6.x      | full-gpl  | 16KB page size compatible    |

## Installation

Install directly from the GitLab repository:

```sh
npm install git+ssh://git@gitlab.concept7.nl:your-storyz/ffmpeg-react-native.git#develop
```

Or add it manually to your `package.json`:

```json
"ffmpeg-kit-react-native": "git+ssh://git@gitlab.concept7.nl:your-storyz/ffmpeg-react-native.git#develop"
```

### iOS

The xcframeworks are fetched automatically from [concept7/ffmpeg-kit-ios](https://github.com/concept7/ffmpeg-kit-ios) during `pod install`:

```sh
cd ios && pod install
```

### Android

The AAR is bundled in the package. No additional steps required.

## Usage

```js
import { FFmpegKit, FFprobeKit, FFmpegKitConfig } from 'ffmpeg-kit-react-native';

// Execute a command
const session = await FFmpegKit.execute('-i input.mp4 output.mp4');

// Execute asynchronously with callbacks
await FFmpegKit.executeAsync(
  '-i input.mp4 output.mp4',
  session => console.log('Completed:', session),
  log => console.log('Log:', log.getMessage()),
  statistics => console.log('Statistics:', statistics)
);

// Get media information
const session = await FFprobeKit.getMediaInformation('input.mp4');
const info = session.getMediaInformation();
```

## Requirements

- React Native 0.84+
- iOS 13.4+
- Android SDK 24+

## License

LGPL-3.0 — see [LICENSE](LICENSE) for details. The full-gpl variant includes GPL-licensed components.
