#!/bin/sh
reattach-to-user-namespace xctool clean test OBJROOT=./Build
/opt/scripts/gcovr -r . --object-directory Build/WeatherApp.build/Coverage-iphonesimulator/WeatherApp.build/Objects-normal/i386 --exclude '.*Tests.*' --exclude '.*main.*' --xml > Build/coverage.xml