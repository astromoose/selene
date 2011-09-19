SET huburl="http://scalzi.is.localnet:4444/grid/register"

java -jar ..\lib\selenium-server-standalone*.jar -Dwebdriver.chrome.driver=..\lib\chromedrivers\win\chromedriver.exe -role webdriver -hub %huburl% -port 5556 -browser "browserName=internet explorer,version=9,maxInstances=3,platform=WINDOWS" -browser "browserName=firefox,version=6.0.2,maxInstances=3,platform=WINDOWS" -browser "browserName=chrome,maxInstances=3,platform=WINDOWS"
