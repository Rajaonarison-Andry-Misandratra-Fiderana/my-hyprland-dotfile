#!/usr/bin/env bash

hyprctl --batch "\
    keyword animations:enabled 1;\
    keyword decoration:shadow:enabled 0;\
    keyword decoration:blur:enabled 1;\
    keyword general:gaps_in 2;\
    keyword general:gaps_out 8;\
    keyword decoration:rounding 15;\
"
