SET huburl="http://scalzi.is.localnet:4444/grid/register"

java -jar ..\lib\selenium-server-standalone*.jar -role webdriver -hub %huburl% -port 5556 -browser "browserName=internet explorer, version=8, maxInstances=3, platform=WINDOWS" -browser "browserName=firefox, version=6.0.2, maxInstances=3, platform=WINDOWS" -Dwebdriver.chrome.driver=../lib/win/chromedriver.exe
