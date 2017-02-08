jenkins发布spring boot jar包到服务端启动脚本

#! /bin/sh
echo $1
echo $2
echo $3
case "$1" in
  start)
  echo "Start $2... "
  java -Dspring.profiles.active=prod -jar $2 > $3_`date +%Y%m%d%H%M%S`.log 2>&1 &
  exit 0
  ;;

  stop)
  echo "Stop $2... "
  ps -ef|grep $2|awk '{print $2}'|while read pid
  do
  kill -9 $pid
  done
  exit 0
  ;;

  restart)

  echo "Stop $2... "
  ##grep -v manager 是为了排除掉本身进程，否则本身进程会被杀掉
  pid=`ps -ef|grep  $2 |grep -v grep|grep -v manager|awk 'NR==1{print $2}'`
  if [ ! -z "$pid" ]
  then
     echo "target process id==$pid"
     kill -9 $pid
  fi
  echo "Start $2... "
  java -Dspring.profiles.active=prod -jar $2 > $3_`date +%Y%m%d%H%M%S`.log 2>&1 &
  exit 0
  ;;

  *)
  echo -n "Usage:"
  echo -n $0
  echo " {start|stop|restart} XXXX.jar XXX"
  exit 0
  ;;

esac
~
