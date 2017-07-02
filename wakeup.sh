#!/bin/bash
#
# wakeup.sh
# Copyright (C) 2017 cypher <cypher@Cortana>

ACPIFILE=/proc/acpi/wakeup

SIGNALS=(XHC1 LID0)

for SIGNAL in $SIGNALS
do
  grep $SIGNAL $ACPIFILE | grep enabled > /dev/null && echo $SIGNAL > $ACPIFILE
done
