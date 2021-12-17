#!/bin/bash

LOCKFILE="/tmp/`basename $0`"

. $HOME/.bin/locking.sh

exlock_now || exit 1

killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 0.5; done

outputs=$(xrandr --query | grep " connected" | cut -d" " -f1)
tray_output="$(polybar --list-monitors | grep primary | cut -d" " -f1 | cut -d":" -f1)"

for m in $outputs; do
  export MONITOR=$m
  export TRAY_POSITION=none
  if [[ $m == $tray_output ]]; then
    TRAY_POSITION=right
  fi

  polybar --reload main -c ~/.config/polybar/config.ini </dev/null >/var/tmp/polybar-$m.log 2>&1 200>&- &
  polybar --reload main -c ~/.config/polybar/config_bottom.ini </dev/null >/var/tmp/polybar-$m.log 2>&1 200>&- &
done
