#!/bin/bash

source ~/.config/polybar/scripts/colors.sh

OP="$1"

DEFAULTS="$(ponymix --short)"
SINKS="$(ponymix --short -t sink list)"
SOURCES="$(ponymix --short -t source list | grep -v Monitor)"

#ROFI="rofi -theme $HOME/.config/rofi/themes/appsmenu.rasi"
ROFI_THEME="${ROFI_THEME:-/usr/share/rofi/themes/Arc-Dark.rasi}"
ROFI="rofi -theme $ROFI_THEME"

function get_type() {
    local PONYMIX_LINE="$1"
    echo -e "$PONYMIX_LINE" | cut -f1
}

function get_id() {
    local PONYMIX_LINE="$1"
    echo -e "$PONYMIX_LINE" | cut -f3
}

function get_name() {
    local PONYMIX_LINE="$1"
    echo -e "$PONYMIX_LINE" | cut -f4
}

function select_entry() {
    local PONYMIX_OUT="$1"
    local TYPE="$2"
    echo -e "$PONYMIX_OUT" | cut -f4 | $ROFI -dmenu -p "Select default $TYPE"
}

function get_id_for_name() {
    local PONYMIX_OUT="$1"
    local NAME="$2"

    while IFS= read -r line; do
        I=$(get_id "$line")
        N=$(get_name "$line")
        if [ "$N" == "$NAME" ]; then
            echo $I
            return 0
        fi
    done <<< "$PONYMIX_OUT"
}

DEFAULT_SOURCE="-"
DEFAULT_SINK="-"

while IFS= read -r line; do
    T=$(get_type "$line")
    N=$(get_name "$line")
    if [ "$T" == "source" ]; then
        DEFAULT_SOURCE="$N"
    fi
    if [ "$T" == "sink" ]; then
        DEFAULT_SINK="$N"
    fi
done <<< "$DEFAULTS"

if [ "$OP" == "sink" ]; then
    TEXT="$(echo -n "$DEFAULT_SINK" | cut -c1-10)..."
    echo "$dark0_soft $faded_green $TEXT$RESET $dark0_soft"
elif [ "$OP" == "source" ]; then
    TEXT="$(echo -n "$DEFAULT_SOURCE" | cut -c1-10)..."
    echo "$dark0_soft $faded_aqua $TEXT$RESET $dark0_soft"
elif [ "$OP" == "select-sinks" ]; then
    SELECTED=$(select_entry "$SINKS" "sink")
    ID=$(get_id_for_name "$SINKS" "$SELECTED")
    ponymix -t sink -d "$ID" set-default
elif [ "$OP" == "select-sources" ]; then
    SELECTED=$(select_entry "$SOURCES" "source")
    ID=$(get_id_for_name "$SOURCES" "$SELECTED")
    ponymix -t source -d "$ID" set-default
else
    echo "$dark0_soft $faded_aqua ${DEFAULT_SOURCE}$RESET $faded_green ${DEFAULT_SINK}$RESET $dark0_soft"
fi