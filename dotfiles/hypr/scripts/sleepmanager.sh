#!/bin/bash

is_fullscreen=$(hyprctl clients -j | jq -e 'any(.[]; .fullscreen == true)')

if [ "$is_fullscreen" = "true" ]; then
	exit 1
else
	exec "$@"
fi
