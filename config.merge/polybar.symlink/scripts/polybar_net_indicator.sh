#!/bin/bash
#
# Show a custom network connection indicator in polybar.
# Includes code for wifi, VPN, ZeroTier, and Hamachi.
#
# Author: machaerus
# https://gitlab.com/machaerus

source ~/.config/polybar/scripts/colors.sh

net_print() {
    WIFI_IF="$(iwconfig 2>&1 | grep ESSID | cut -d' ' -f1)"

    CONNECTED_WIFI=0
    for IF in `echo -e "$WIFI_IF"`; do
        ESSID=$(iwconfig $IF | grep ESSID | cut -d: -f2 | xargs)
        [ "$ESSID" = "off/any" ] || CONNECTED_WIFI=1
    done

	CONNECTED_VPN=$(ip link | grep tun0 | wc -l)
    CONNECTED_HAMACHI=$(comman -v hamachi 2>/dev/null && (hamachi | grep status | cut -d ':' -f 2 | xargs))
	#CONNECTED_ZEROTIER=$(zerotier-cli info | cut -d ' ' -f 5 | xargs)

    indicator="$dark0_soft["

	if [ "$CONNECTED_WIFI" -eq 1 ]; then
		indicator="$indicator ${faded_green}${RESET}"
	else
		indicator="$indicator ${dark0_soft}${RESET}"
	fi

 	if [ "$CONNECTED_VPN" -eq 1 ]; then
 		indicator="$indicator ${faded_green}${RESET}"
 	fi

 	if [ "$CONNECTED_HAMACHI" = "logged in" ]; then
 		indicator="$indicator ${faded_green}${RESET}"
 	fi

 	if [ "$CONNECTED_ZEROTIER" = "ONLINE" ]; then
 		indicator="$indicator ${faded_green}${RESET}"
 	fi

    indicator="$indicator $dark0_soft]"

	# echo "$dark2[$wifi_indicator$dark2]$dark2[$vpn_indicator$dark2]"
	# echo "$dark0_soft[ $wifi_indicator $vpn_indicator $zerotier_indicator $dark0_soft]"
	echo "$indicator"
}

net_print


