#!/bin/bash

set -e

echo "🔧 Starting dotfiles installation..."

# Créer les répertoires si nécessaires
mkdir -p ~/.config
mkdir -p ~/.local/share/fonts
sudo mkdir -p /usr/share/icons

# Copier tout sauf le dossier 'fonts' dans ~/.config
echo "📁 Copying configs to ~/.config..."
shopt -s extglob
cp -r !(fonts|install.sh) ~/.config/

# Copier les polices (sauf 'locolor') vers ~/.local/share/fonts
echo "🔤 Installing fonts..."
find ./fonts -mindepth 1 -maxdepth 1 ! -name "locolor" -exec cp -r {} ~/.local/share/fonts/ \;

# Copier le dossier 'locolor' dans /usr/share/icons
echo "🎨 Installing 'locolor' cursor theme..."
sudo cp -r ./fonts/locolor /usr/share/icons/

# Mise à jour du cache des polices
echo "🔄 Updating font cache..."
fc-cache -fv

echo "✅ Installation complete!"
