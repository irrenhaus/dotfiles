#!/bin/sh
echo "cleaning " $1 " :: usage: cleanmqtt <host>"
mosquitto_sub -h $1 -t "#" -v | while read line; do mosquitto_pub -h $1 -t "${line% *}" -r -n; done
