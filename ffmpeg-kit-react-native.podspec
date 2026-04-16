require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "ffmpeg-kit-react-native"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platform          = :ios
  s.requires_arc      = true
  s.static_framework  = true

  s.source = { :git => "https://github.com/concept7/ffmpeg-kit-react-native.git", :tag => "#{s.version}" }

  s.dependency "React-Core"

  # iOS uses ffmpeg-kit 6.0 (full-gpl) xcframeworks from concept7/ffmpeg-kit-ios.
  # Android uses ffmpeg-kit 6.1.1 (full-gpl, 16KB page size compatible) — see android/build.gradle.
  s.prepare_command = <<-CMD
    rm -rf ios/Frameworks
    git clone --depth 1 --branch 6.0 https://github.com/concept7/ffmpeg-kit-ios.git ios/Frameworks
  CMD

  s.default_subspec = 'full-gpl'

  s.subspec 'full-gpl' do |ss|
    ss.source_files      = '**/FFmpegKitReactNativeModule.m',
                           '**/FFmpegKitReactNativeModule.h'
    ss.ios.deployment_target = '13.4'
    ss.vendored_frameworks   = 'ios/Frameworks/ffmpegkit.xcframework',
                               'ios/Frameworks/libavcodec.xcframework',
                               'ios/Frameworks/libavdevice.xcframework',
                               'ios/Frameworks/libavfilter.xcframework',
                               'ios/Frameworks/libavformat.xcframework',
                               'ios/Frameworks/libavutil.xcframework',
                               'ios/Frameworks/libswresample.xcframework',
                               'ios/Frameworks/libswscale.xcframework'
    ss.frameworks = 'AudioToolbox', 'AVFoundation', 'CoreFoundation', 'CoreMedia', 'CoreVideo', 'VideoToolbox'
    ss.libraries  = 'iconv', 'bz2', 'z'
  end
end
