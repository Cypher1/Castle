#!/bin/bash
cd
CONFIG=".config/i3/config"
spaces="$(grep "set \$workspace.*" $CONFIG | sed "s/.*workspace[0-9]* \(.*\)/\1/" )"

spaces=$(echo "$spaces" | sed "s/\"//g")
from=$1
to=$2

echo $spaces
if [ "$from" = "" ]
then
  from="$(echo "$spaces" | dmenu -p "Switch from: ")"
fi

if [ "$to" = "" ]
then
  to="$(echo "$spaces" | grep -v "$from" | dmenu -p "Switch to: ")"
fi

IFS=$'\n'
for space in $spaces
do
  num="$(echo $space | grep -o "[0-9]*" || echo $space)"
  echo "NUM: $num, NAME: $space"
  if [ "$num" = "$from" ]
  then
    from=$space
  fi
  if [ "$num" = "$to" ]
  then
    to=$space
  fi
done

echo "SWAPPING $from and $to"

tmp="\"!tmp!\"" #we might want to use tmp as a workspace
i3-msg "rename workspace $from to $tmp
       ;rename workspace $to to $from
       ;rename workspace $tmp to $to
       "
