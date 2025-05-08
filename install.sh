#!/bin/bash

# Script to copy configuration files
# - Everything in ./ goes to ~/.config/
# - ./fonts goes to ~/.local/share/fonts

set -e

# Define source and target directories
SRC_DIR="$(pwd)"
CONFIG_TARGET="$HOME/.config"
FONTS_TARGET="$HOME/.local/share/fonts"

echo "📁 Copying configuration files to $CONFIG_TARGET..."
rsync -av --exclude "fonts" "$SRC_DIR/" "$CONFIG_TARGET/"

echo "🔤 Copying fonts to $FONTS_TARGET..."
mkdir -p "$FONTS_TARGET"
rsync -av "$SRC_DIR/fonts/" "$FONTS_TARGET/"

echo "✅ All files copied successfully."
