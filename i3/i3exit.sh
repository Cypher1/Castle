#!/bin/sh
lock() {
  i3lock -c "#000000" -d -e -f
}

case "$1" in
    lock)
        lock
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        lock && sudo pm-suspend
        ;;
    shutdown)
        shutdown 0
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|reboot|shutdown}"
        exit 2
esac
exit 0
