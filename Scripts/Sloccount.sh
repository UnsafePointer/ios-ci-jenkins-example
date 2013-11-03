#!/bin/sh
cloc --by-file --xml -out=Build/cloc.xml WeatherApp
xsltproc Utils/Sloccount-format.xls Build/cloc.xml > Build/cloccount.sc