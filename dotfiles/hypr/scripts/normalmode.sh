#!/usr/bin/env bash

# Restaure les paramètres Hyprland normaux selon ta config
hyprctl --batch "\
    keyword animations:enabled 1;\
    keyword decoration:shadow:enabled 0;\
    keyword decoration:blur:enabled 1;\
    keyword general:gaps_in 2;\
    keyword general:gaps_out 4;\
    keyword decoration:rounding 0;\
    keyword misc:vfr false"

unset DXVK_ASYNC
unset DXVK_STATE_CACHE
unset DXVK_SHADER_PERSISTENCE
unset WINE_NTSYNC
