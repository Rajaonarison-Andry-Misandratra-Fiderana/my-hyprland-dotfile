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

# CPU mode normal (schedutil pour équilibre)
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    [ -f "$cpu" ] && echo schedutil | sudo tee "$cpu" >/dev/null 2>&1
done

# Réactiver tous les cores CPU
for cpu in /sys/devices/system/cpu/cpu*/online; do
    [ -f "$cpu" ] && echo 1 | sudo tee "$cpu" >/dev/null 2>&1
done

# Reset fréquence max CPU
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq; do
    if [ -f "$cpu" ]; then
        max_freq=$(cat "${cpu%scaling_max_freq}cpuinfo_max_freq" 2>/dev/null)
        [ -n "$max_freq" ] && echo "$max_freq" | sudo tee "$cpu" >/dev/null 2>&1
    fi
done

unset DXVK_ASYNC
unset DXVK_STATE_CACHE
unset DXVK_SHADER_PERSISTENCE
unset WINE_NTSYNC
unset PROTON_ENABLE_NVAPI
unset __GL_SHADER_DISK_CACHE
unset __GL_THREADED_OPTIMIZATIONS
unset __GL_SYNC_TO_VBLANK
unset __GL_MaxFramesAllowed
unset LFX
