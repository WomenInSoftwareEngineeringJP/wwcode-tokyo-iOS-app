push:
	./gradlew clean test assemble && cf push wwcode-tokyo-server -b java_buildpack -p build/libs/web-0.0.1-SNAPSHOT.jar

run:
	./gradlew bootRun

test:
	./gradlew clean test
