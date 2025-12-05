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

# NVIDIA mode normal
nvidia-settings -a '[gpu:0]/GPUPowerMizerMode=0' 2>/dev/null

unset DXVK_ASYNC
unset DXVK_STATE_CACHE
unset DXVK_SHADER_PERSISTENCE
unset WINE_NTSYNC
unset PROTON_ENABLE_NVAPI
unset __GL_SHADER_DISK_CACHE
unset __GL_THREADED_OPTIMIZATIONS
unset __GL_SYNC_TO_VBLANK
unset __GL_MaxFramesAllowed
