#!/bin/bash

BATTERY_PATH="/org/freedesktop/UPower/devices/battery_BAT0"
STATE_FILE="/tmp/battery_state_prev"

# Lire infos batterie
INFO=$(upower -i $BATTERY_PATH | grep -E "state|percentage")
STATE=$(echo "$INFO" | grep state | awk '{print $2}')
PERCENT=$(echo "$INFO" | grep percentage | awk '{print $2}' | tr -d '%')

# Lire l'état précédent pour détecter changement
PREV_STATE=""
if [ -f "$STATE_FILE" ]; then
    PREV_STATE=$(cat $STATE_FILE)
fi

# Enregistrer l'état actuel
echo "$STATE" > $STATE_FILE

# Déterminer icône + couleur
if [[ $STATE == "charging" ]]; then
    ICON=""
    COLOR="#00FF00"
    TOOLTIP="Charging"
else
    if [ "$PERCENT" -le 20 ]; then
        ICON=""; COLOR="#FF5555"
    elif [ "$PERCENT" -le 40 ]; then
        ICON=""; COLOR="#FFAA00"
    elif [ "$PERCENT" -le 60 ]; then
        ICON=""; COLOR="#FFFF55"
    elif [ "$PERCENT" -le 80 ]; then
        ICON=""; COLOR="#55FF55"
    else
        ICON=""; COLOR="#00FF00"
    fi
    TOOLTIP="Battery: $PERCENT%"
fi

# JSON pour Waybar avec couleur et tooltip
echo "$ICON $PERCENT%"
