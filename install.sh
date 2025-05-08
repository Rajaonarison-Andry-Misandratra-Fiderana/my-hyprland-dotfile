#!/bin/bash

# Ensure required directories exist
mkdir -p ~/.config
mkdir -p ~/.local/share/fonts
sudo mkdir -p /usr/share/icons/

# Copy all items except the "fonts" folder to ~/.config
for item in ./*; do
    if [[ "$(basename "$item")" != "fonts" ]]; then
        cp -r "$item" ~/.config/
    fi
done

# Handle fonts directory separately
if [ -d "./fonts" ]; then
    for font in ./fonts/*; do
        if [[ "$(basename "$font")" == "locolor" ]]; then
            sudo cp -r "$font" /usr/share/icons/
        else
            cp -r "$font" ~/.local/share/fonts/
        fi
    done
fi

# Make sure Rofi scripts are executable
chmod +x ~/.config/rofi/launchers/type-7/launcher.sh
chmod +x ~/.config/rofi/powermenu/type-2/powermenu.sh

echo "🔄 Updating font cache..."
fc-cache -fv

echo "✅ Installation complete!"
