#!/bin/sh
xctool -reporter json-compilation-database:compile_commands.json clean build
oclint-json-compilation-database -e Pods/** -- -max-priority-1 1000 -max-priority-2 1000 -max-priority-3 1000 -report-type pmd -o Build/oclint.xml