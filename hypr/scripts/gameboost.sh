#!/usr/bin/env sh

if [ "$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')" = 1 ]; then
  hyprctl --batch "\
        dispatch toggleperformance;\
        keyword animations:enabled 0;\
        keyword decoration:shadow:enabled 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0"
fi

export DXVK_STATE_CACHE=1
export DXVK_ASYNC=1
export DXVK_SHADER_PERSISTENCE=1
export WINEFSYNC=0
export WINEESYNC=0
export WINE_NTSYNC=1
