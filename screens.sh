#!/bin/bash

screens="$(xrandr --prop | grep ".* connected" | sed "s/\([^ ]*\) .*/\1/")"

declare -A config
config=(
    ["eDP1"]="--dpi 300 --primary --scale 1x1"
  )

for screen in "${screens[@]}"
do
  screen_config="${config[$screen]}"
  if [ "$screen_config" = "" ]
  then
    screen_config="--auto"
  fi
  cmd="xrandr --output $screen $screen_config"
  #echo "Setting up: $cmd"
  result="$($cmd)"
  if [ "$result" != "" ]
  then
    echo "$result"
  fi
done
