#!/bin/bash

# Récupérer le wallpaper actuel de Hyprpaper
WALLPAPER=$(grep '^wallpaper' ~/.config/hypr/hyprpaper.conf | cut -d'=' -f2 | tr -d ' ,')

# Mettre à jour hyprlock.conf
sed -i "s|^\s*path = .*|    path = $WALLPAPER|" ~/.config/hypr/hyprlock.conf

# Lancer hyprlock
hyprlock
