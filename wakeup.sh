#! /bin/sh -e
#
# wakeup.sh
# Copyright (C) 2017 cypher <cypher@Cortana>
#
echo LID0 > /proc/acpi/wakeup
echo XHC1 > /proc/acpi/wakeup
exit 0
