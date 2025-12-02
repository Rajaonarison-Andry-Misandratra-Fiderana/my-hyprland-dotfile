#!/bin/bash

check_interval=0.1
idle_interval=0.5

# Vérifie si une fenêtre est active
active_window_exists() {
  local output
  output=$(hyprctl activewindow -j 2>/dev/null) || return 1
  [ -z "$output" ] && return 1
  echo "$output" | jq -e '.class != null' >/dev/null 2>&1
  return $?
}

# Kill Waybar et tous ses enfants
kill_waybar_tree() {
  local pids
  pids=$(pgrep -x waybar)
  if [ -n "$pids" ]; then
    # On kill les enfants d'abord
    for pid in $pids; do
      pkill -P "$pid" >/dev/null 2>&1 || true
    done
    # Puis le parent
    pkill -x waybar >/dev/null 2>&1 || true
  fi
}

current_state="unknown"

while true; do
  if active_window_exists; then
    if [ "$current_state" != "active" ]; then
      kill_waybar_tree
      current_state="active"
    fi
    sleep $check_interval
  else
    if [ "$current_state" != "no_window" ]; then
      kill_waybar_tree
      nohup waybar >/dev/null 2>&1 &
      current_state="no_window"
    fi
    sleep $idle_interval
  fi
done
