#!/bin/bash

huburl='http://localhost:4444/grid/register'

java -jar lib/selenium-server-standalone*.jar -role webdriver -hub ${huburl} -port 5556 \
-browser browserName=firefox,version=3.6,firefox_binary=/opt/browsers/firefox36/firefox,maxInstances=1,platform=linux \
-browser browserName=firefox,version=4,firefox_binary=/opt/browsers/firefox4/firefox,maxInstances=1,platform=linux \
-browser browserName=firefox,version=6,firefox_binary=/opt/browsers/firefox6/firefox,maxInstances=1,platform=linux
-browser browserName=chrome,
