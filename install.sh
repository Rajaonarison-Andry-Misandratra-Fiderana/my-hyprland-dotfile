#!/bin/bash

# Ensure required directories exist
mkdir -p ~/.config
sudo mkdir -p /usr/share/fonts/TTF/
sudo mkdir -p /usr/share/icons/

# Copy all items except install.sh, README*, and "fonts" folder to ~/.config
for item in ./*; do
    name="$(basename "$item")"
    if [[ "$name" != "fonts" && "$name" != "install.sh" && ! "$name" =~ ^README ]]; then
        cp -r "$item" ~/.config/
    fi
done

# Handle fonts directory separately
if [ -d "./fonts" ]; then
    for font in ./fonts/*; do
        fname="$(basename "$font")"
        if [[ -d "$font" && "$fname" == "Bibata-Modern-Classic" ]]; then
            sudo cp -r "$font" /usr/share/icons/
        elif [[ -f "$font" && "$font" == *.ttf ]]; then
            sudo cp "$font" /usr/share/fonts/TTF/
        fi
    done
fi

chmod +x ~/.config/rofi/powermenu/type-2/powermenu.sh

echo "🔄 Updating font cache..."
sudo fc-cache -fv

echo "✅ Installation complete!"
