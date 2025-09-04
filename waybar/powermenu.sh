#!/bin/bash
mode=$(echo -e "Gaming\nNormal\nUltra Minimal" | wofi --dmenu --prompt "Mode d'alimentation")

case "$mode" in
    "Gaming") powerprofilesctl set performance ;;
    "Normal") powerprofilesctl set balanced ;;
    "Ultra Minimal") powerprofilesctl set power-saver ;;
esac

[ -n "$mode" ] && notify-send "⚡ Mode " "$mode"
