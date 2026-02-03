#!/bin/bash
set -uo pipefail 
IFS=$'\n\t'

trap 'echo "❌ Critical error at line $LINENO"' ERR

# --- INITIALIZATION ---
INSTALL_BROWSER=false
INSTALL_GAMING=false
INSTALL_NVIM=false

# --- FUNCTIONS ---

ask_prompts() {
    echo "🤔 Setup Configuration..."
    read -rp "🌐 Install Zen Browser? (y/N) " br_ans
    [[ "$br_ans" =~ ^[yY] ]] && INSTALL_BROWSER=true || true

    read -rp "🎮 Install Gaming Pack? (y/N) " gm_ans
    [[ "$gm_ans" =~ ^[yY] ]] && INSTALL_GAMING=true || true

    read -rp "📝 Install Neovim & Config? (y/N) " nv_ans
    [[ "$nv_ans" =~ ^[yY] ]] && INSTALL_NVIM=true || true
}

setup_system() {
    echo "⚙️  Configuring Chaotic-AUR..."
    
    sudo pacman-key --init
    echo "🔑 Fetching Chaotic-AUR key directly via curl to bypass keyservers..."
    curl -sL "https://repo.chaotic.cx/chaotic-keyring.gpg" | sudo pacman-key --add -
    
    sudo pacman-key --lsign-key 3056513887B78AEB

    sudo pacman -U --noconfirm \
        'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
        'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

    if ! grep -q "^\[chaotic-aur\]" /etc/pacman.conf 2>/dev/null; then
        sudo tee -a /etc/pacman.conf >/dev/null <<'EOF'

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF
    fi

    sudo pacman -Syu --noconfirm
}

install_yay() {
    if ! command -v yay &>/dev/null; then
        echo "📦 Installing yay..."
        sudo pacman -S --noconfirm --needed git base-devel
        tmp=$(mktemp -d)
        git clone https://aur.archlinux.org/yay.git "$tmp/yay"
        (cd "$tmp/yay" && makepkg -si --noconfirm)
        rm -rf "$tmp"
    fi
}

install_packages() {
    echo "🚚 Installing system packages..."
    local pkgs=(
        hyprland hyprpaper ghostty kitty jq fastfetch slurp nwg-look 
        hyprlock hyprsunset hypridle hyprpolkitagent wlogout waybar 
        swaync swayosd waypaper xdg-user-dirs xdg-utils 
        xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
        nordic-darker-theme tela-icon-theme feh obsidian rofi 
        imagemagick udiskie pamixer pavucontrol gzip npm 
        inotify-tools thunar thunar-volman tumbler ffmpegthumbnailer 
        gvfs gvfs-mtp ttf-jetbrains-mono-nerd ttf-font-awesome 
        bluez bluez-utils rfkill networkmanager network-manager-applet blueman xsettingsd
    )
    
    [[ "$INSTALL_NVIM" == true ]] && pkgs+=(nvim)
    
    sudo pacman -S --needed --noconfirm "${pkgs[@]}"
    sudo systemctl enable --now bluetooth NetworkManager
}

install_aur() {
    echo "🚀 Installing AUR packages..."
    local aur_pkgs=(wl-gammarelay-rs)
    [[ "$INSTALL_BROWSER" == true ]] && aur_pkgs+=(zen-browser-bin)
    [[ "$INSTALL_GAMING" == true ]] && aur_pkgs+=(heroic-games-launcher-bin proton-ge-custom-bin gamescope gamemode)
    
    yay -S --needed --noconfirm "${aur_pkgs[@]}"
}

apply_configs() {
    echo "🎨 Deploying dotfiles..."
    mkdir -p "$HOME/.config"

    # 1. Dotfiles copy logic (skips nvim if declined)
    if [ -d "./dotfiles" ]; then
        for item in ./dotfiles/*; do
            [ -e "$item" ] || continue
            name=$(basename "$item")
            
            if [[ "$name" == "nvim" && "$INSTALL_NVIM" == false ]]; then
                echo "⏭️  Skipping Neovim config"
                continue
            fi
            
            cp -rf "$item" "$HOME/.config/"
            echo "✅ $name -> ~/.config/"
        done
    fi

    # 2. Assets (Wallpapers/Media) -> ~/.config/Assets
    if [ -d "./assets" ]; then
        echo "🖼️  Deploying Assets to ~/.config/Assets..."
        mkdir -p "$HOME/.config/Assets"
        cp -rf ./assets/* "$HOME/.config/Assets/"
    fi

    # 3. Fonts
    if [ -d "./fonts" ]; then
        echo "🔤 Installing fonts..."
        sudo mkdir -p /usr/share/fonts/TTF
        sudo cp -rf ./fonts/* /usr/share/fonts/TTF/
        sudo fc-cache -fv
    fi

    grep -qxF 'fastfetch' ~/.bashrc 2>/dev/null || echo 'fastfetch' >> ~/.bashrc
}

main() {
    ask_prompts
    setup_system
    install_yay
    install_packages
    install_aur
    apply_configs
    echo "🎉 Installation complete. Enjoy your FullDark setup!"
}

main
