#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

trap 'echo "❌ An error occurred at line $LINENO. Aborting script."' ERR

echo "🔄 Installing essential packages..."
sudo pacman -Syu --noconfirm --needed \
    ttf-jetbrains-mono-nerd \
    ttf-font-awesome \
    slurp \
    hyprland \
    hyprpaper \
    rofi-wayland \
    waybar \
    fastfetch \
    kitty \
    wlogout \
    hyprpolkitagent \
    udiskie \
    network-manager-applet \
    pamixer \
    power-profiles-daemon \
    nwg-look

# Create necessary directories
echo "📁 Creating necessary directories..."
mkdir -p "$HOME/.config"
sudo mkdir -p /usr/share/fonts/TTF
sudo mkdir -p /usr/share/icons

# Copy configuration files (excluding some)
echo "📂 Copying configuration files..."
for item in ./*; do
    name="$(basename "$item")"
    if [[ "$name" != "fonts" && "$name" != "install.sh" && ! "$name" =~ ^README ]]; then
        if [[ -e "$item" ]]; then
            cp -r "$item" "$HOME/.config/"
        fi
    fi
done

# Copy fonts and icons if available
if [[ -d "./fonts" ]]; then
    echo "🔤 Installing custom fonts and icons..."
    for font in ./fonts/*; do
        fname="$(basename "$font")"
        if [[ -d "$font" && "$fname" == "Bibata-Modern-Classic" ]]; then
            sudo cp -r "$font" /usr/share/icons/
        elif [[ -f "$font" && "$font" == *.ttf ]]; then
            sudo cp "$font" /usr/share/fonts/TTF/
        fi
    done
fi

# Make rofi scripts executable
echo "🔧 Setting execution permissions for rofi scripts..."
chmod +x "$HOME/.config/rofi/launchers/type-6/launcher.sh" 2>/dev/null || echo "⚠️ launcher.sh not found."
chmod +x "$HOME/.config/rofi/powermenu/type-2/powermenu.sh" 2>/dev/null || echo "⚠️ powermenu.sh not found."
chmod +x "$HOME/.config/waybar/powermenu.sh" 2>/dev/null || echo "⚠️ powermenu.sh not found."
chmod +x "$HOME/.config/hypr/scripts/gamemode.sh" 2>/dev/null || echo "⚠️ gamemode.sh not found."

# Update font cache
echo "🔄 Updating font cache..."
sudo fc-cache -fv

# Configure Fastfetch
echo "⚙️ Configuring Fastfetch..."
mkdir -p "$HOME/.config/fastfetch"
if [[ -f "$HOME/.config/fastfetch/fastfetch.jsonc" ]]; then
    mv "$HOME/.config/fastfetch/fastfetch.jsonc" "$HOME/.config/fastfetch/config.jsonc"
fi

# Update .bashrc file
echo "🛠️ Configuring .bashrc..."
BASHRC="$HOME/.bashrc"

add_if_not_exists() {
    local line="$1"
    grep -qxF "$line" "$BASHRC" || echo "$line" >> "$BASHRC"
}

add_if_not_exists '[[ $- != *i* ]] && return'
add_if_not_exists 'fastfetch'  
add_if_not_exists "alias ls='ls --color=auto'"
add_if_not_exists "alias grep='grep --color=auto'"
add_if_not_exists "PS1='\\[\\e[1;32m\\]\\u\\[\\e[0m\\] \\[\\e[1;34m\\]\\w\\[\\e[0m\\] '"

echo "✅ Installation completed! Restart your PC."
