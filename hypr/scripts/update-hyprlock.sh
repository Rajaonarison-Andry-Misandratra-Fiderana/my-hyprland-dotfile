#!/bin/bash

CONFIG="$HOME/.config/waypaper/config.ini"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"

# Lire le wallpaper de waypaper (cherche dans la section [Settings])
WALLPAPER=$(grep '^wallpaper =' "$CONFIG" | cut -d'=' -f2- | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

if [ -z "$WALLPAPER" ]; then
  echo "Aucun wallpaper trouvé dans la config"
  exit 1
fi

# Développer le chemin ~ en chemin absolu
if [[ "$WALLPAPER" == ~* ]]; then
  WALLPAPER="${WALLPAPER/#\~/$HOME}"
fi

if [ ! -f "$WALLPAPER" ]; then
  echo "Wallpaper introuvable: $WALLPAPER"
  exit 1
fi

echo "Wallpaper détecté: $WALLPAPER"

# Échapper les caractères spéciaux pour sed (surtout les / et ~)
ESCAPED_WALLPAPER=$(printf '%s\n' "$WALLPAPER" | sed 's/[\/&]/\\&/g')

# Remplacer le chemin dans hyprlock.conf
if [ -f "$HYPRLOCK_CONF" ]; then
  # Créer une sauvegarde
  cp "$HYPRLOCK_CONF" "${HYPRLOCK_CONF}.bak"

  # Remplacer la ligne path dans la section background
  # Note: le wallpaper actuel a une indentation de 4 espaces
  sed -i "s|^    path = .*|    path = $ESCAPED_WALLPAPER|" "$HYPRLOCK_CONF"

  echo "Fichier hyprlock.conf mis à jour"
else
  echo "Config hyprlock introuvable: $HYPRLOCK_CONF"
  exit 1
fi
