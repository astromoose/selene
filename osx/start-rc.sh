huburl='http://scalzi.is.localnet:4444/grid/register'

java -jar ../lib/selenium-server-standalone*.jar \
-Dwebdriver.chrome.driver=../lib/chromedrivers/osx/chromedriver \
-role webdriver -hub ${huburl} -port 5555 \
-browser "browserName=safari,maxInstances=3,platform=MAC" \
-browser "browserName=firefox,maxInstances=3,platform=MAC" \
-browser "browserName=chrome,maxInstances=3,platform=MAC" \
