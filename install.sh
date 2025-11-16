#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

trap 'echo "❌ Error at line $LINENO"' ERR

# --- Add Chaotic-AUR repository ---
setup_chaotic_aur() {
    echo "🌌 Setting up Chaotic-AUR repository..."

    # Import and locally sign the Chaotic-AUR key
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key 3056513887B78AEB

    # Install Chaotic-AUR keyring and mirrorlist
    sudo pacman -U --noconfirm \
        'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
        'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

    # Add repository if not already present
    if ! grep -q "^\[chaotic-aur\]" /etc/pacman.conf; then
        echo "📝 Adding [chaotic-aur] repository to /etc/pacman.conf..."
        sudo tee -a /etc/pacman.conf >/dev/null <<'EOF'

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF
    else
        echo "✅ [chaotic-aur] repository already present."
    fi

    echo "🔄 Syncing package databases..."
    sudo pacman -Sy --noconfirm
}

# --- Update system once ---
system_update() {
    echo "🔄 Updating system before installations..."
    sudo pacman -Syu --noconfirm
}

# --- Install yay if not present ---
install_yay() {
    if ! command -v yay &> /dev/null; then
        echo "📦 Installing yay..."
        sudo pacman -S --noconfirm --needed git base-devel
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay
        makepkg -si --noconfirm
        cd -
        echo "✅ yay installed successfully"
    else
        echo "✅ yay already installed"
    fi
}

# --- Packs installation ---
install_hyprland_pack() {
    echo "🚀 Installing Hyprland Pack..."
    sudo pacman -S --noconfirm --needed \
        hyprland hyprpaper kitty jq fastfetch \
        slurp nwg-look hyprlock hypridle hyprpolkitagent wlogout waybar swaync swayosd \
        xdg-user-dirs xdg-utils xdg-desktop-portal-wlr xdg-desktop-portal-hyprland \
        xdg-desktop-portal-gtk xdg-desktop-portal nordic-darker-theme
}

install_system_tools_pack() {
    echo "🛠️ Installing System Tools Pack..."
    sudo pacman -S --noconfirm --needed \
        udiskie pamixer
}

install_thunar_pack() {
    echo "📂 Installing Thunar Pack..."
    sudo pacman -S --noconfirm --needed \
        thunar tumbler ffmpegthumbnailer
}

install_fonts_icons_pack() {
    echo "🔤 Installing Fonts & Icons Pack..."
    sudo pacman -S --noconfirm --needed \
        ttf-jetbrains-mono-nerd ttf-font-awesome
    [[ -d "./fonts" ]] && sudo cp -r ./fonts/* /usr/share/fonts/TTF/ || true
}

install_network_pack() {
    echo "🌐 Installing Networking Pack (WiFi, Bluetooth, NetworkManager)..."
    sudo pacman -S --noconfirm --needed \
        bluez bluez-utils rfkill networkmanager network-manager-applet
    sudo systemctl enable --now bluetooth.service
    sudo systemctl enable --now NetworkManager.service
}

# --- Install AUR packages ---
install_aur_packages() {
    echo "📦 Installing AUR packages..."
    yay -S walker-bin elephant-bin --noconfirm
}

# --- Common config (applied after installs) ---
apply_common_config() {
    echo "📁 Creating necessary directories..."
    mkdir -p "$HOME/.config"
    sudo mkdir -p /usr/share/fonts/TTF
    sudo mkdir -p /usr/share/icons

    echo "📂 Copying configuration files..."
    for item in ./*; do
        name="$(basename "$item")"
        if [[ "$name" != "fonts" && "$name" != "install.sh" && ! "$name" =~ ^[Rr][Ee][Aa][Dd][Mm][Ee] ]]; then
            [[ -e "$item" ]] && cp -r "$item" "$HOME/.config/"
        fi
    done

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

    echo "🔧 Setting execution permissions for rofi scripts..."
    chmod +x "$HOME/.config/rofi/launchers/type-6/launcher.sh" 2>/dev/null || echo "⚠️ launcher.sh not found."
    chmod +x "$HOME/.config/rofi/powermenu/type-2/powermenu.sh" 2>/dev/null || echo "⚠️ powermenu.sh not found."
    chmod +x "$HOME/.config/waybar/powermenu.sh" 2>/dev/null || echo "⚠️ powermenu.sh not found."

    echo "🔧 Setting execution permissions for Hypr scripts..."
    if [[ -d "$HOME/.config/hypr/scripts" ]]; then
        shopt -s nullglob
        for script in "$HOME/.config/hypr/scripts/"*.sh; do
            [[ -f "$script" && "$(basename "$script")" != "gamemode.sh" ]] && chmod +x "$script" && echo "✅ Made executable: $(basename "$script")"
        done
        shopt -u nullglob
    else
        echo "⚠️ Directory ~/.config/hypr/scripts not found."
    fi

    echo "🔄 Updating font cache..."
    sudo fc-cache -fv

    echo "⚙️ Configuring Fastfetch..."
    mkdir -p "$HOME/.config/fastfetch"
    if [[ -f "$HOME/.config/fastfetch/fastfetch.jsonc" ]]; then
        mv "$HOME/.config/fastfetch/fastfetch.jsonc" "$HOME/.config/fastfetch/config.jsonc"
    fi

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

    echo "✅ Configuration applied!"
}

# --- Main installation process ---
main() {
    echo "🚀 Starting complete Hyprland installation..."
    
    setup_chaotic_aur
    system_update
    install_yay
    
    echo "📦 Installing all packages..."
    install_hyprland_pack
    install_system_tools_pack
    install_thunar_pack
    install_fonts_icons_pack
    install_network_pack
    install_aur_packages
    apply_common_config
}

# --- Start the installation ---
main
