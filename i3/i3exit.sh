#!/bin/sh
lock() {
    ~/.config/i3/i3lock-fancy/lock -f 'Hack-regular' -t ''
}

case "$1" in
    lock)
        lock
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        lock&
        sudo pm-suspend
        ;;
    shutdown)
        shutdown 0
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|reboot|shutdown}"
        exit 2
esac
exit 0
