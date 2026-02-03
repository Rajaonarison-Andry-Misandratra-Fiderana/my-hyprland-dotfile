#!/bin/bash

CONFIG="$HOME/.config/waypaper/config.ini"
TMP_IMG="/tmp/rofi_wallpaper.png"

inotifywait -m -e close_write,move,create "$CONFIG" | while read -r; do
  WALLPAPER=$(awk -F= '/^wallpaper[[:space:]]*=/{gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2}' "$CONFIG")
  WALLPAPER="${WALLPAPER/#\~/$HOME}"

  [ ! -f "$WALLPAPER" ] && exit 0

  magick "$WALLPAPER" \
    -filter Lanczos \
    -resize 750x \
    "$TMP_IMG"

done
