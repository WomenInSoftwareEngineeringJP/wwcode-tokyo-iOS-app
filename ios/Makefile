bootstrap:
	@carthage bootstrap --use-xcframeworks --platform iOS --no-use-binaries --cache-builds

update:
	@carthage update --use-xcframeworks --platform iOS --no-use-binaries --cache-builds

units:
	@xcodebuild -project WWCode_Tokyo_iOS.xcodeproj -scheme "WWCode_Tokyo_iOS" -destination "platform=iOS Simulator,OS=latest,name=iPhone 12" build test

ci: bootstrap units


