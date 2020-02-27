bootstrap:
	@carthage bootstrap --platform iOS

update:
	@carthage update --platform iOS

units:
	@xcodebuild -project WWCode_Tokyo_iOS.xcodeproj -scheme "WWCode_Tokyo_iOS" -destination "platform=iOS Simulator,OS=latest,name=iPhone 11" build test

ci: boostrap units


