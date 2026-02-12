#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_zoom_videosdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_zoom_videosdk'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'zoom' => 'http://example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/*.h'
  s.dependency 'Flutter'
  s.dependency "ZoomVideoSDK/ZoomVideoSDK", '2.4.12'
  s.dependency 'ZoomVideoSDK/zoomcml', '2.4.12'
  s.dependency 'ZoomVideoSDK/CptShare', '2.4.12'
  s.dependency 'ZoomVideoSDK/zm_annoter_dynamic', '2.4.12'
  s.dependency 'ZoomVideoSDK/ZoomTask', '2.4.12'
  s.dependency 'ZoomVideoSDK/Whiteboard', '2.4.12'
  s.platform = :ios, '15.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 arm64' }

  s.preserve_paths = 'ZoomVideoSDK.xcframework/**/*'
end