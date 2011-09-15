kill -9 `ps -ef |grep webdriver|grep -v grep|awk '{print $2}'`
