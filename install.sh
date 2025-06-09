#!/bin/bash

# Installer les paquets nécessaires
echo "🔄 Installation des paquets essentiels..."
sudo pacman -S --noconfirm ttf-jetbrains-mono-nerd slurp hyprland hyprpaper rofi-wayland waybar fastfetch kitty ttf-font-awesome

# Créer les dossiers nécessaires
mkdir -p ~/.config
sudo mkdir -p /usr/share/fonts/TTF/
sudo mkdir -p /usr/share/icons/

# Copier les éléments de configuration (sauf certains)
echo "📂 Copie des fichiers de configuration..."
for item in ./*; do
    name="$(basename "$item")"
    if [[ "$name" != "fonts" && "$name" != "install.sh" && ! "$name" =~ ^README ]]; then
        cp -r "$item" ~/.config/
    fi
done

# Copier les polices et icônes
if [ -d "./fonts" ]; then
    echo "🔤 Installation des polices et icônes personnalisées..."
    for font in ./fonts/*; do
        fname="$(basename "$font")"
        if [[ -d "$font" && "$fname" == "Bibata-Modern-Classic" ]]; then
            sudo cp -r "$font" /usr/share/icons/
        elif [[ -f "$font" && "$font" == *.ttf ]]; then
            sudo cp "$font" /usr/share/fonts/TTF/
        fi
    done
fi

# Rendre les scripts rofi exécutables
chmod +x ~/.config/rofi/launchers/type-6/launcher.sh
chmod +x ~/.config/rofi/powermenu/type-2/powermenu.sh

# Mise à jour du cache de polices
echo "🔄 Mise à jour du cache des polices..."
sudo fc-cache -fv

# Modification du .bashrc
echo "🛠️ Configuration de .bashrc..."

BASHRC="$HOME/.bashrc"

add_if_not_exists() {
    local line="$1"
    grep -qxF "$line" "$BASHRC" || echo "$line" >> "$BASHRC"
}

add_if_not_exists '[[ $- != *i* ]] && return'
add_if_not_exists 'fastfetch --load-config ~/.config/fastfetch/fastfetch.jsonc'
add_if_not_exists "alias ls='ls --color=auto'"
add_if_not_exists "alias grep='grep --color=auto'"
add_if_not_exists "PS1='\\[\\e[1;32m\\]\\u\\[\\e[0m\\] \\[\\e[1;34m\\]\\w\\[\\e[0m\\] '"

echo "✅ Installation terminée ! Redémarre le terminal pour voir les changements."
