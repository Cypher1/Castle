#!/bin/sh
lock() {
    i3lock -c 000000 -e -f
    # -i (display image)
    # -c (colour)
    # -t (tiling)
    # -e ignore empty password
    # -f (show fails)
}

case "$1" in
    lock)
        lock
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        lock && systemctl suspend
        ;;
    shutdown)
        systemctl poweroff
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
        exit 2
esac
exit 0
