#!/bin/sh
cloc --by-file --xml -out=Build/cloc.xml WeatherApp
xsltproc Scripts/sloccount.xsl Build/cloc.xml > Build/cloccount.sc