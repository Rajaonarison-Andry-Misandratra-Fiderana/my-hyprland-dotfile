#!/bin/bash

check_inactivity() {

    if hyprctl clients -j | jq -e 'any(.[]; .fullscreen == true)' >/dev/null; then
        return 1
    fi

    if [ $(hyprctl idle) -lt 60000 ]; then
        return 1
    fi

    return 0
}

while true; do
    if check_inactivity; then
        hypridle
    fi
    sleep 5
done