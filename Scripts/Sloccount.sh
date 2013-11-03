#!/bin/sh
cloc --by-file --xml -out=Build/cloc.xml WeatherApp
xsltproc Utils/Sloccount.xsl Build/cloc.xml > Build/cloccount.sc