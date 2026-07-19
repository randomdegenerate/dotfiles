#!/bin/sh

dir="$HOME/Pictures"
mkdir -p "$dir"

file="$dir/screenshot-$(date +%Y%m%d-%H%M%S).png"

if maim -s "$file"; then
    xclip -selection clipboard -t image/png -i "$file"
    notify-send -u low -t 2000 -i "$file" "Screenshot saved"
fi
