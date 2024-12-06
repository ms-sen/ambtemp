#!/bin/sh

### BEGIN INIT INFO
# Provides:          ambtemp
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: mshefkiu-ambtemp
# Description:       Measure Temperature.
### END INIT INFO
. /etc/init.d/functions

DESC="Ambient temperature sensing system."
NAME=ambtemp-bin
DAEMON=/usr/bin/$NAME
DAEMON_ARGS=""
PIDFILE=/var/run/$NAME.pid
SCRIPTNAME=/etc/init.d/$NAME

start() {
    pid=`pidof -x ambtemp-bin` 
       if [ -n "$pid" ]; then 
           return 1 
       else 
           start-stop-daemon --start --background --quiet --make-pidfile --pidfile $PIDFILE --exec $DAEMON -- \
               $DAEMON_ARGS \
               || return 2
       fi
}
   
stop() {
    start-stop-daemon --stop --quiet --retry=TERM/30/KILL/5 --name $NAME
    RETVAL="$?"
    [ "$RETVAL" = 2 ] && return 2
    rm -f $PIDFILE
    return "$RETVAL"
}
   
case "$1" in 
    start)
       echo -n "Starting $DESC.."
       start
       case "$?" in
          0) success && echo -e "" ;;
          1) warning && echo -e "\nAlready running!" ;;
          2) failure && echo -e "" ;;
       esac
       ;;
    stop)
       echo -n "Stopping $DESC.."
       stop
       case "$?" in
          0) success && echo -e "" ;;
          1) warning && echo -e "\nAlready stopped!" ;;
          2) failure && echo -e "" ;;
       esac
       ;;
    restart)
       echo "Restarting $DESC.."
       stop
       case "$?" in
          0|1) start ;;
          *) failure ;;
       esac
       ;;
    status)
       pid=`pidof -x ambtemp-bin`
       if [ -n "$pid" ]; then
           echo "AmbTemp service is runnning."
       else
           echo "AmbTemp service is not running."
       fi
       ;;
    *)
       echo "Usage: $0 {start|stop|status|restart}"
esac
   
exit 0 
