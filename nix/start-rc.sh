#!/bin/bash

huburl='http://scalzi.is.localnet:4444/grid/register'

java -jar ../lib/selenium-server-standalone*.jar \
-Dwebdriver.chrome.driver=../lib/chromedrivers/nix32/chromedriver \
-role webdriver -hub ${huburl} -port 5555 \
-browser "browserName=firefox,version=6.0.2,maxInstances=3,platform=LINUX" \
-browser "browserName=firefox,version=3.6,firefox_binary=/opt/ff3/firefox,maxInstances=3,platform=LINUX" \
-browser "browserName=firefox,version=7.0,firefox_binary=/opt/ff7/firefox,maxInstances=3,platform=LINUX" \
-browser "browserName=chrome,maxInstances=3,platform=LINUX" \
-browser "browserName=opera,version=11.51,maxInstances=3,platform=LINUX"
