xcodebuild \
  -project VIPER-SWIFT.xcodeproj \
  -scheme VIPER-SWIFT \
  -destination 'platform=iOS Simulator,name=iPhone 6,OS=9.3' \
  build 2> /dev/null | grep 'error:\|warning:' 
