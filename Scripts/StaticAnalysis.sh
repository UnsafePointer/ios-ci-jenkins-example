#!/bin/sh
xcodebuild -workspace WeatherApp.xcworkspace -scheme WeatherApp clean build CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO | tee xcodebuild.log
oclint-xcodebuild
oclint-json-compilation-database -e Pods/** -- -max-priority-1 1000 -max-priority-2 1000 -max-priority-3 1000 -report-type pmd -o Build/oclint.xml