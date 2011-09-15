SET huburl="http://scalzi.is.localnet:4444/grid/register"

java -jar ..\lib\selenium-server-standalone*.jar -role webdriver -hub %huburl% -port 5556 -browser “browserName=internet_explorer,version=7,maxInstances=3, platform=WINDOWS”
