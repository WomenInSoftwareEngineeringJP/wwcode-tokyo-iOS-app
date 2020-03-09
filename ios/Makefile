bootstrap:
	@carthage bootstrap --platform iOS --no-use-binaries --cache-builds

update:
	@carthage update --platform iOS --no-use-binaries --cache-builds

units:
	@xcodebuild -project WWCode_Tokyo_iOS.xcodeproj -scheme "WWCode_Tokyo_iOS" -destination "platform=iOS Simulator,OS=latest,name=iPhone 11" build test

ci: bootstrap units


