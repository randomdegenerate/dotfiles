#!/usr/bin/env bash

ORIENTATION="$1"

case "$ORIENTATION" in
    left)
        xrandr --output HDMI-1 --mode 1920x1080 --rate 60 --rotate left
        DIR="$HOME/Pictures/Wallpapers/portrait-left"
        ;;
    right)
        xrandr --output HDMI-1 --mode 1920x1080 --rate 60 --rotate right
        DIR="$HOME/Pictures/Wallpapers/portrait-right"
        ;;
    normal)
        xrandr --output HDMI-1 --mode 1920x1080 --rate 60 --rotate normal
        DIR="$HOME/Pictures/Wallpapers/landscape"
        ;;
    *)
        echo "Usage: $0 {left|right|normal}"
        exit 1
        ;;
esac

sleep 0.2

STATE="$HOME/.cache/i3-wallpaper-index"
mkdir -p "$(dirname "$STATE")"

mapfile -t WALLPAPERS < <(find "$DIR" -maxdepth 1 -type f | sort)

[[ ${#WALLPAPERS[@]} -eq 0 ]] && exit 1

INDEX=0
[[ -f "$STATE" ]] && INDEX=$(cat "$STATE")

INDEX=$(( (INDEX + 1) % ${#WALLPAPERS[@]} ))
echo "$INDEX" > "$STATE"

feh --bg-fill "${WALLPAPERS[$INDEX]}"
