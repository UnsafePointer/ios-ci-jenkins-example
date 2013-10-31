#!/bin/sh
xcodebuild -workspace WeatherApp.xcworkspace -scheme WeatherApp clean build | tee xcodebuild.log
oclint-xcodebuild
oclint-json-compilation-database -e Pods/** -- -report-type pmd -o Build/oclint.xml