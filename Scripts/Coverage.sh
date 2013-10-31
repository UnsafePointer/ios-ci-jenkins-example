#!/bin/sh
xcodebuild -workspace WeatherApp.xcworkspace -scheme WeatherApp -sdk iphonesimulator clean test OBJROOT=./Build
gcovr -r . --object-directory Build/WeatherApp.build/Coverage-iphonesimulator/WeatherApp.build/Objects-normal/i386 --exclude '.*Tests.*' --exclude '.*main.*' --xml > Build/coverage.xml