#!/bin/bash

source ~/.config/polybar/scripts/colors.sh

TRACKING="$(timew | grep 'no active')"
TOTAL_TIME="$(timew | grep Total | awk '{print $2}')"

if [ -n "$TRACKING" ]; then
    echo "$dark0_soft start$RESET"
else
    echo "$bright_blue $TOTAL_TIME$RESET"
fi

# clock end 
# clock start 
# clock 
