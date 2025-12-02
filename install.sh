#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

trap 'echo "❌ Error at line $LINENO"' ERR

# --- Chaotic-AUR setup ---
setup_chaotic_aur() {
    echo "🌌 Setting up Chaotic-AUR repository..."
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key 3056513887B78AEB
    sudo pacman -U --noconfirm \
        'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
        'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
    if ! grep -q "^\[chaotic-aur\]" /etc/pacman.conf; then
        echo "📝 Adding [chaotic-aur] repository..."
        sudo tee -a /etc/pacman.conf >/dev/null <<'EOF'

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF
    fi
    echo "🔄 Syncing databases..."
    sudo pacman -Sy --noconfirm
}

# --- System update ---
system_update() {
    echo "🔄 Updating system..."
    sudo pacman -Syu --noconfirm
}

# --- yay installation ---
install_yay() {
    if ! command -v yay &> /dev/null; then
        echo "📦 Installing yay..."
        sudo pacman -S --noconfirm --needed git base-devel
        tmpdir=$(mktemp -d)
        git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
        cd "$tmpdir/yay" || exit
        makepkg -si --noconfirm
        cd - || exit
        rm -rf "$tmpdir"
        echo "✅ yay installed"
    else
        echo "✅ yay already installed"
    fi
}

# --- Packs installation ---
install_hyprland_pack() {
    echo "🚀 Installing Hyprland Pack..."
    sudo pacman -S --noconfirm --needed \
        hyprland hyprpaper ghostty jq fastfetch \
        slurp nwg-look hyprlock hypridle hyprpolkitagent wlogout waybar swaync swayosd waypaper \
        xdg-user-dirs xdg-utils xdg-desktop-portal-wlr xdg-desktop-portal-hyprland \
        xdg-desktop-portal-gtk nordic-darker-theme nvim
}

install_system_tools_pack() {
    echo "🛠️ Installing System Tools Pack..."
    sudo pacman -S --noconfirm --needed udiskie pamixer
}

install_thunar_pack() {
    echo "📂 Installing Thunar Pack..."
    sudo pacman -S --noconfirm --needed thunar tumbler ffmpegthumbnailer
}

install_fonts_icons_pack() {
    echo "🔤 Installing Fonts & Icons Pack..."
    sudo pacman -S --noconfirm --needed ttf-jetbrains-mono-nerd ttf-font-awesome
    [[ -d "./fonts" ]] && sudo cp -r ./fonts/* /usr/share/fonts/TTF/ || true
}

install_network_pack() {
    echo "🌐 Installing Networking Pack..."
    sudo pacman -S --noconfirm --needed bluez bluez-utils rfkill networkmanager network-manager-applet
    sudo systemctl enable --now bluetooth.service
    sudo systemctl enable --now NetworkManager.service
}

# --- Chrome installation prompt ---
ask_chrome_installation() {
    read -rp "🌐 Install Google Chrome? (y/N) " response
    case $response in
        [yY]|[yY][eE][sS]) INSTALL_CHROME=true ;;
        *) INSTALL_CHROME=false ;;
    esac
}

# --- AUR installation ---
install_aur_packages() {
    echo "📦 Installing AUR packages..."
    local aur_packages=("walker-bin" "elephant-bin" "elephant-providerlist-bin" "elephant-desktopapplications-bin")
    $INSTALL_CHROME && aur_packages+=("google-chrome")
    yay -S --needed --noconfirm "${aur_packages[@]}"
}

# --- Common configuration ---
apply_common_config() {
    echo "📁 Applying configuration..."
    mkdir -p "$HOME/.config"
    sudo mkdir -p /usr/share/fonts/TTF /usr/share/icons

    # Copy configs except install.sh, fonts, readme
    for item in ./*; do
        name="$(basename "$item")"
        if [[ "$name" != "fonts" && "$name" != "install.sh" && ! "$name" =~ ^[Rr][Ee][Aa][Dd][Mm][Ee] ]]; then
            [[ -e "$item" ]] && cp -r "$item" "$HOME/.config/"
        fi
    done

    # Fonts/icons
    if [[ -d "./fonts" ]]; then
        for font in ./fonts/*; do
            fname="$(basename "$font")"
            if [[ -d "$font" && "$fname" == "Bibata-Modern-Classic" ]]; then
                sudo cp -r "$font" /usr/share/icons/
            elif [[ -f "$font" && "$font" == *.ttf ]]; then
                sudo cp "$font" /usr/share/fonts/TTF/
            fi
        done
    fi

    # Make scripts executable
    chmod +x "$HOME/.config/rofi/launchers/type-6/launcher.sh" 2>/dev/null || true
    chmod +x "$HOME/.config/rofi/powermenu/type-2/powermenu.sh" 2>/dev/null || true
    chmod +x "$HOME/.config/waybar/powermenu.sh" 2>/dev/null || true
    if [[ -d "$HOME/.config/hypr/scripts" ]]; then
        shopt -s nullglob
        for script in "$HOME/.config/hypr/scripts/"*.sh; do
            [[ -f "$script" && "$(basename "$script")" != "gamemode.sh" ]] && chmod +x "$script"
        done
        shopt -u nullglob
    fi

    sudo fc-cache -fv

    # Fastfetch
    mkdir -p "$HOME/.config/fastfetch"
    [[ -f "$HOME/.config/fastfetch/fastfetch.jsonc" ]] && mv "$HOME/.config/fastfetch/fastfetch.jsonc" "$HOME/.config/fastfetch/config.jsonc"

    # Bashrc
    BASHRC="$HOME/.bashrc"
    grep -qxF '[[ $- != *i* ]] && return' "$BASHRC" || echo '[[ $- != *i* ]] && return' >> "$BASHRC"
    grep -qxF 'fastfetch' "$BASHRC" || echo 'fastfetch' >> "$BASHRC"
    grep -qxF "alias ls='ls --color=auto'" "$BASHRC" || echo "alias ls='ls --color=auto'" >> "$BASHRC"
    grep -qxF "alias grep='grep --color=auto'" "$BASHRC" || echo "alias grep='grep --color=auto'" >> "$BASHRC"
    grep -qxF "PS1='\\[\\e[1;32m\\]\\u\\[\\e[0m\\] \\[\\e[1;34m\\]\\w\\[\\e[0m\\] '" "$BASHRC" || \
        echo "PS1='\\[\\e[1;32m\\]\\u\\[\\e[0m\\] \\[\\e[1;34m\\]\\w\\[\\e[0m\\] '" >> "$BASHRC"

    echo "✅ Configuration applied!"
}

# --- Main ---
main() {
    echo "🚀 Starting installation..."
    ask_chrome_installation
    setup_chaotic_aur
    system_update
    install_yay

    install_hyprland_pack
    install_system_tools_pack
    install_thunar_pack
    install_fonts_icons_pack
    install_network_pack
    install_aur_packages
    apply_common_config

    echo "🎉 Installation complete!"
    [[ "$INSTALL_CHROME" = false ]] && echo "📝 Google Chrome not installed; use: yay -S google-chrome"
}

main
