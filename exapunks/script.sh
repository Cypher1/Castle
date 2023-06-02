#!/bin/sh
SCRIPT="$(readlink -f "$0")"
BASEDIR="$(dirname "$SCRIPT")"
echo "$BASEDIR"
date
INDEX="$(date +"%-H")" # Index by the hour.
echo "$INDEX"
BACKGROUND="${BASEDIR}/hour_${INDEX}.jpg"
echo "$BACKGROUND"
DBUS="unix:path=/run/user/$UID/bus"
echo "$DBUS"
function in_display() {
  DBUS_SESSION_BUS_ADDRESS="$DBUS" DISPLAY=":0.0" $@
}

in_display "gsettings set org.gnome.desktop.background picture-uri file://${BACKGROUND}"
in_display "gsettings set org.gnome.desktop.background picture-uri-dark file://${BACKGROUND}"
for XPATH in $(in_display "xfconf-query -c xfce4-desktop -l" | grep 'last-image'); do
  echo "Setting $XPATH"
  in_display "xfconf-query -c xfce4-desktop -p $XPATH -s ${BACKGROUND}"
done
