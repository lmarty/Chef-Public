#!/bin/bash
#description: Starts xvfb on display 99

case "$1" in
start)
    echo -n "Starting virtual X frame buffer: Xvfb"
    /usr/bin/Xvfb :99 -screen 0 1280x1024x24 &
;;

stop)
    echo -n "Stopping virtual X frame buffer: Xvfb"
    killall Xvfb
;;

restart)
    $0 stop
    $0 start
;;

*)
  echo "`basename $0` {start|stop|restart}"
  exit 1
esac
exit 0

#chkconfig: 345 95 50
