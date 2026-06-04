#!/bin/sh

dir="$HOME/Pictures"
mkdir -p "$dir"
file="$dir/screenshot-$(date +%Y%m%d-%H%M%S).png"

/usr/bin/maim -i "$(/usr/bin/xdotool getactivewindow)" "$file" &&
/usr/bin/xclip -selection clipboard -t image/png -i "$file" &&
/usr/bin/notify-send -u low -t 2000 -i "$file" "Active window screenshot saved"
