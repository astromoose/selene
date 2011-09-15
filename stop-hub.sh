kill -9 `ps -ef |grep "role hub"|grep -v grep|awk '{print $2}'`
