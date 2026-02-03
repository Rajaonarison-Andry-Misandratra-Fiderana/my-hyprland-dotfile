#!/bin/bash
set -euo pipefail

mkdir -p dotfiles assets/backgrounds fonts

# Liste exhaustive des dossiers à déplacer dans dotfiles/
CONFIG_DIRS=(
    "hypr" "waybar" "ghostty" "kitty" "nvim" "rofi" "swaync" 
    "swayosd" "waypaper" "wlogout" "fastfetch" "Thunar" 
    "gtk-3.0" "gtk-4.0" "nwg-look" "xsettingsd"
)

for dir in "${CONFIG_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo "📦 Déplacement de $dir vers dotfiles/"
        mv "$dir" dotfiles/
    fi
done

# Déplacement des images
if [ -d "Assets" ]; then
    mv Assets/* assets/backgrounds/ 2>/dev/null || true
    rmdir Assets
fi

echo "✅ Structure prête."
