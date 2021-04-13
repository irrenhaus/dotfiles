#!/bin/bash
#
# Custom network download/upload speed indicator for polybar.
#
# Author: machaerus
# https://gitlab.com/machaerus

source ~/.config/polybar/scripts/colors.sh

net_speed() {
    IF="$1"
    ICON="$2"
	UP_NETSPEED=$(awk '{if(l1){printf "%6.1f", ($10-l2)/1024} else{l1=$2; l2=$10;}}' <(grep $IF /proc/net/dev) <(sleep 1; grep $IF /proc/net/dev))
	DOWN_NETSPEED=$(awk '{if(l1){printf "%6.1f", ($2-l1)/1024} else{l1=$2; l2=$10;}}' <(grep $IF /proc/net/dev) <(sleep 1; grep $IF /proc/net/dev))

    UP_NETSPEED="$(echo $UP_NETSPEED | xargs echo -n)"
    DOWN_NETSPEED="$(echo $DOWN_NETSPEED | xargs echo -n)"

	# echo "$dark0_soft [ $faded_aqua $UP_NETSPEED KB/s$RESET  $faded_green↓ $DOWN_NETSPEED KB/s$RESET $dark0_soft]"
	echo -n "$dark0_soft $faded_aqua $ICON  $UP_NETSPEED KB/s$RESET$faded_green  $DOWN_NETSPEED KB/s$RESET $dark0_soft"
}

ESSID=$(iwconfig wlp61s0 | grep ESSID | cut -d: -f2 | xargs)
[ "$ESSID" = "off/any" ] && CONNECTED_WIFI=0 || CONNECTED_WIFI=1

if [ $CONNECTED_WIFI -eq 1 ]; then
    net_speed wlp61s0 ""
    echo -n "   "
fi

net_speed enp60s0 ""

echo ""
