```bash
#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

trap 'echo "❌ Error at line $LINENO"' ERR

BASH_PROFILE="$HOME/.bash_profile"

# --- FLAGS ---
INSTALL_BROWSER=false
INSTALL_GAMING=false

# --- TTY1 Hyprland autostart ---
configure_tty_boot() {
    read -rp "⚡ Automatically start Hyprland from TTY1? (y/N) " answer
    case "$answer" in
        [yY]|[yY][eE][sS])
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
        *) echo "⏭️ Skipped." ;;
    esac
}

# --- Chaotic-AUR ---
setup_chaotic_aur() {
    sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key 3056513887B78AEB
    sudo pacman -U --noconfirm \
        https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst \
        https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst

    if ! grep -q "^\[chaotic-aur\]" /etc/pacman.conf; then
        sudo tee -a /etc/pacman.conf >/dev/null <<'EOF'

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF
    fi

    sudo pacman -Sy --noconfirm
}

# --- Update ---
system_update() {
    sudo pacman -Syu --noconfirm
}

# --- yay ---
install_yay() {
    if ! command -v yay &>/dev/null; then
        sudo pacman -S --noconfirm --needed git base-devel
        tmp=$(mktemp -d)
        git clone https://aur.archlinux.org/yay.git "$tmp/yay"
        (cd "$tmp/yay" && makepkg -si --noconfirm)
        rm -rf "$tmp"
    fi
}

# --- Packs ---
install_hyprland_pack() {
    sudo pacman -S --noconfirm --needed \
        hyprland hyprpaper ghostty jq fastfetch \
        slurp nwg-look hyprlock hyprsunset hypridle hyprpolkitagent \
        wlogout waybar swaync swayosd waypaper \
        xdg-user-dirs xdg-utils \
        xdg-desktop-portal-wlr xdg-desktop-portal-hyprland \
        xdg-desktop-portal-gtk nordic-darker-theme \
        nvim feh obsidian bpftune-git rofi imagemagick
}

install_system_tools_pack() {
    sudo pacman -S --noconfirm --needed udiskie pamixer pavucontrol gzip npm inotify-tools
}

install_thunar_pack() {
    sudo pacman -S --noconfirm --needed thunar thunar-volman tumbler ffmpegthumbnailer gvfs gvfs-mtp
}

install_fonts_icons_pack() {
    sudo pacman -S --noconfirm --needed ttf-jetbrains-mono-nerd ttf-font-awesome
}

install_network_pack() {
    sudo pacman -S --noconfirm --needed bluez bluez-utils rfkill networkmanager network-manager-applet blueman
    sudo systemctl enable --now bluetooth NetworkManager
}

# --- Prompts ---
ask_browser_installation() {
    read -rp "🌐 Install Zen Browser? (y/N) " r
    [[ "$r" =~ ^[yY] ]] && INSTALL_BROWSER=true
}

ask_gaming_installation() {
    read -rp "🎮 Install Gaming Pack (Heroic, Proton-GE, Gamescope, Gamemode)? (y/N) " r
    [[ "$r" =~ ^[yY] ]] && INSTALL_GAMING=true
}

# --- AUR ---
install_aur_packages() {
    local pkgs=()
    $INSTALL_BROWSER && pkgs+=(zen-browser-bin)
    [[ ${#pkgs[@]} -gt 0 ]] && yay -S --needed --noconfirm "${pkgs[@]}"
}

# --- Gaming ---
install_gaming_pack() {
    if [[ "$INSTALL_GAMING" == true ]]; then
        yay -S --needed --noconfirm \
            heroic-games-launcher-bin \
            proton-ge-custom-bin \
            gamescope \
            gamemode
    else
        echo "⏭️ Gaming Pack skipped."
    fi
}

# --- Config ---
apply_common_config() {
    mkdir -p "$HOME/.config"
    sudo mkdir -p /usr/share/fonts/TTF /usr/share/icons

    for item in ./*; do
        name="$(basename "$item")"
        [[ "$name" =~ ^(fonts|install.sh|README) ]] && continue
        cp -r "$item" "$HOME/.config/" 2>/dev/null || true
    done

    sudo fc-cache -fv

    grep -qxF 'fastfetch' ~/.bashrc || echo 'fastfetch' >> ~/.bashrc
}

# --- Main ---
main() {
    configure_tty_boot
    ask_browser_installation
    ask_gaming_installation

    setup_chaotic_aur
    system_update
    install_yay

    install_hyprland_pack
    install_system_tools_pack
    install_thunar_pack
    install_fonts_icons_pack
    install_network_pack

    install_aur_packages
    install_gaming_pack
    apply_common_config

    echo "🎉 Done."
}

main
```
