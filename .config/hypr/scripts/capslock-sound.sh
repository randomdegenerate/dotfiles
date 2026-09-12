#!/usr/bin/env bash


KEYBOARD="/dev/input/by-id/usb-Beken_2.4G_Wireless_Device-event-kbd"

ON_SOUND="$HOME/Music/sounds/capslock.mp3"
OFF_SOUND="$HOME/Music/sounds/capslockoff.mp3"

sudo evtest "$KEYBOARD" 2>/dev/null |
while read -r line; do
    if [[ "$line" == *"value 1"* ]]; then
        pw-play "$ON_SOUND" &
    elif [[ "$line" == *"value 0"* ]]; then
        pw-play "$OFF_SOUND" &
    fi
done
