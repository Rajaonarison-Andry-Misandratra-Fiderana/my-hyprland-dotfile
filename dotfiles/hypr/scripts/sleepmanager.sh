#!/bin/bash

IDLE_DELAY=30

check_inactivity() {
  if hyprctl clients -j | jq -e 'any(.[]; .fullscreen == true)' >/dev/null; then
    return 1
  fi

  local idle_time
  idle_time=$(hyprctl idle 2>/dev/null | grep -o '[0-9]*' | head -1)
  idle_time=${idle_time:-0}

  if [ "$idle_time" -lt 60000 ]; then
    return 1
  fi

  return 0
}

while true; do
  if check_inactivity; then
    sleep $IDLE_DELAY
    if check_inactivity; then
      hyprctl dispatch forceidle 1
      hypridle
    fi
  else
    hyprctl dispatch forceidle 0
  fi

  sleep 5
done
