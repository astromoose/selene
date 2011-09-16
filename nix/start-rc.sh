#!/bin/bash

huburl='http://scalzi.is.localnet:4444/grid/register'

java -jar ../lib/selenium-server-standalone*.jar \
-Dwebdriver.chrome.driver=../lib/chromedrivers/nix64/chromedriver \
-role webdriver -hub ${huburl} -port 5555 \
-browser "browserName=firefox,version=6.0.2,maxInstances=3,platform=LINUX" \
-browser "browserName=chrome,maxInstances=3,platform=LINUX" \
