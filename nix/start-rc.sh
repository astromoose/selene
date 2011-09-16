#!/bin/bash

huburl='http://scalzi.is.localnet:4444/grid/register'

java -jar ../lib/selenium-server-standalone*.jar -role webdriver -hub ${huburl} -port 5555 \
-browser "browserName=firefox, version=6.0.2, maxInstances=3, platform=linux" \
-browser "browserName=chrome, maxInstances=3, platform=linux" \
-Dwebdriver.chrome.driver=../lib/nix64/chromedriver
