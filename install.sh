#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

trap 'echo "❌ Error at line $LINENO"' ERR

BASH_PROFILE="$HOME/.bash_profile"

# --- TTY1 Hyprland autostart ---
configure_tty_boot() {
    read -rp "⚡ Automatically start Hyprland from TTY1? (y/N) " answer
    case "$answer" in
        [yY]|[yY][eE][sS])
            echo "📝 Adding block to ~/.bash_profile..."

            BLOCK='

# --- Auto start Hyprland on TTY1 ---
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    rm -f /run/user/1000/wayland-1.lock
    exec hyprland >/dev/null 2>&1
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
'

            if ! grep -q "Auto start Hyprland on TTY1" "$BASH_PROFILE" 2>/dev/null; then
                echo "$BLOCK" >> "$BASH_PROFILE"
                echo "✅ Added to ~/.bash_profile"
            else
                echo "ℹ️ Entry already exists, skipping."
            fi
            ;;
        *)
            echo "⏭️ Skipped, ~/.bash_profile unchanged."
            ;;
    esac
}

# --- Chaotic-AUR setup ---
setup_chaotic_aur() {
    echo "🌌 Setting up Chaotic-AUR repository..."
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key 3056513887B78AEB
    sudo pacman -U --noconfirm \
        'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
        'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

    if ! grep -q "^\[chaotic-aur\]" /etc/pacman.conf; then
        echo "📝 Adding [chaotic-aur] to pacman.conf..."
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
        cd "$tmpdir/yay"
        makepkg -si --noconfirm
        rm -rf "$tmpdir"
        echo "✅ yay installed"
    else
        echo "✅ yay already installed"
    fi
}

# --- Package packs ---
install_hyprland_pack() {
    echo "🚀 Installing Hyprland Pack..."
    sudo pacman -S --noconfirm --needed \
        hyprland hyprpaper ghostty jq fastfetch \
        slurp nwg-look hyprlock hypridle hyprpolkitagent wlogout waybar swaync swayosd waypaper \
        xdg-user-dirs xdg-utils xdg-desktop-portal-wlr xdg-desktop-portal-hyprland \
        xdg-desktop-portal-gtk nordic-darker-theme nvim feh
}

install_system_tools_pack() {
    echo "🛠️ Installing System Tools Pack..."
    sudo pacman -S --noconfirm --needed udiskie pamixer
}

install_thunar_pack() {
    echo "📂 Installing Thunar Pack..."
    sudo pacman -S --noconfirm --needed thunar tumbler ffmpegthumbnailer gvfs gvfs-mtp
}

install_fonts_icons_pack() {
    echo "🔤 Installing Fonts & Icons Pack..."
    sudo pacman -S --noconfirm --needed ttf-jetbrains-mono-nerd ttf-font-awesome
    [[ -d "./fonts" ]] && sudo cp -r ./fonts/* /usr/share/fonts/TTF/ || true
}

install_network_pack() {
    echo "🌐 Installing Networking Pack..."
    sudo pacman -S --noconfirm --needed bluez bluez-utils rfkill networkmanager network-manager-applet blueman
    sudo systemctl enable --now bluetooth.service
    sudo systemctl enable --now NetworkManager.service
}

# --- Browser install prompt ---
ask_browser_installation() {
    read -rp "🌐 Install zen browser? (y/N) " response
    case $response in
        [yY]|[yY][eE][sS]) INSTALL_BROWSER=true ;;
        *) INSTALL_BROWSER=false ;;
    esac
}

# --- AUR installation ---
install_aur_packages() {
    echo "📦 Installing AUR packages..."
    local aur_packages=("walker-bin" "elephant-bin" "elephant-providerlist-bin" "elephant-desktopapplications-bin")
    $INSTALL_BROWSER && aur_packages+=("zen-browser-bin")
    yay -S --needed --noconfirm "${aur_packages[@]}"
}

# --- Config ---
apply_common_config() {
    echo "📁 Applying configuration..."

    mkdir -p "$HOME/.config"
    sudo mkdir -p /usr/share/fonts/TTF /usr/share/icons

    for item in ./*; do
        name="$(basename "$item")"
        if [[ "$name" != "fonts" && "$name" != "install.sh" && ! "$name" =~ ^[Rr][Ee][Aa][Dd][Mm][Ee] ]]; then
            [[ -e "$item" ]] && cp -r "$item" "$HOME/.config/"
        fi
    done

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

    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

    chmod +x "$HOME/.config/waybar/powermenu.sh" 2>/dev/null || true

    if [[ -d "$HOME/.config/hypr/scripts" ]]; then
        for script in "$HOME/.config/hypr/scripts/"*.sh; do
            [[ -f "$script" && "$(basename "$script")" != "gamemode.sh" ]] && chmod +x "$script"
        done
    fi

    sudo fc-cache -fv

    mkdir -p "$HOME/.config/fastfetch"
    [[ -f "$HOME/.config/fastfetch/fastfetch.jsonc" ]] &&
        mv "$HOME/.config/fastfetch/fastfetch.jsonc" "$HOME/.config/fastfetch/config.jsonc"

    BASHRC="$HOME/.bashrc"
    grep -qxF '[[ $- != *i* ]] && return' "$BASHRC" || echo '[[ $- != *i* ]] && return' >> "$BASHRC"
    grep -qxF 'fastfetch' "$BASHRC" || echo 'fastfetch' >> "$BASHRC"
    grep -qxF "alias ls='ls --color=auto'" "$BASHRC" || echo "alias ls='ls --color=auto'" >> "$BASHRC"
    grep -qxF "alias grep='grep --color=auto'" "$BASHRC" || echo "alias grep='grep --color=auto'" >> "$BASHRC"

    echo "✅ Configuration applied!"
}

# --- Main ---
main() {
    echo "🚀 Starting installation..."

    configure_tty_boot
    ask_browser_installation
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
    [[ "$INSTALL_BROWSER" = false ]] && echo "📝 Zen browser was not installed."
}

main
