#!/bin/sh
reattach-to-user-namespace xctool -reporter junit:Build/junit.xml clean test