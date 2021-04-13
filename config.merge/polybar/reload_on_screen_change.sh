#!/bin/bash

MONITOR_LIST="$(polybar --list-monitors)"

while true; do
    CURRENT_LIST="$(polybar --list-monitors)"
    if [[ "$CURRENT_LIST" != "$MONITOR_LIST" ]]; then
        echo "Monitor config changed!"
        $HOME/.config/polybar/launch.sh
        MONITOR_LIST="$CURRENT_LIST"
    fi
    sleep 4
done
