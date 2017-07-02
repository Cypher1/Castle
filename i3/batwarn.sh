#!/bin/bash
# This is a simple battery warning script
# using i3's nagbar to display warnings.
# @author agribu

# set energy limit in percent, where warning should be displayed
LIMIT="10"

# set error message
MESSAGE="Battery is low."

# set Battery
BATTERY=$(ls /sys/class/power_supply/ | grep '^BAT')

# set full path
ACPI_PATH="/sys/class/power_supply/$BATTERY"

# get battery status
STAT=$(cat $ACPI_PATH/status)

# get remaining and full energy value
REM=`grep "POWER_SUPPLY_\(CHARGE\|ENERGY\)_NOW" $ACPI_PATH/uevent | cut -d= -f2`
FULL=`grep "POWER_SUPPLY_\(CHARGE\|ENERGY\)_FULL_DESIGN" $ACPI_PATH/uevent | cut -d= -f2`

# get current energy value in percent
PERCENT=`echo $(( $REM * 100 / $FULL ))`
echo "$PERCENT%"

# show warning if energy limit in percent is less then user set limit and
# if battery is discharging
if [ $PERCENT -le "$(echo $LIMIT)" ] && [ "$STAT" == "Discharging" ]; then
    DISPLAY=:0.0 /usr/bin/i3-nagbar -m "$(echo $MESSAGE)" -b "Suspend?" "~/.config/i3/i3exit.sh suspend && pkill i3-nagbar"
fi
