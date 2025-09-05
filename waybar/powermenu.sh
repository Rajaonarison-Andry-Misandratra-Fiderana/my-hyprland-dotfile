#!/bin/bash
BATTERY_PATH="/org/freedesktop/UPower/devices/battery_BAT0"

INFO=$(upower -i $BATTERY_PATH | grep -E "state|time to empty|percentage")
STATE=$(echo "$INFO" | grep state | awk '{print $2}')
PERCENT=$(echo "$INFO" | grep percentage | awk '{print $2}' | tr -d '%')
TIME=$(echo "$INFO" | grep -E "time to" | awk -F: '{print $2}' | xargs)

# Déterminer icône + couleur selon le pourcentage
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

# Tooltip
if [[ $STATE == "discharging" ]]; then
    TOOLTIP="Remaining time: $TIME"
elif [[ $STATE == "charging" ]]; then
    TOOLTIP="Time to full charge: $TIME"
else
    TOOLTIP="Battery state: $STATE"
fi

# JSON pour Waybar avec icône et pourcentage de même couleur
echo "{\"text\": \"<span color='$COLOR'>$ICON $PERCENT%</span>\", \"tooltip\": \"$TOOLTIP\"}"
