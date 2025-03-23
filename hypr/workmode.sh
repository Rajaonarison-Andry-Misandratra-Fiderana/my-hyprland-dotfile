#!/usr/bin/env sh
HYPRWORKMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRWORKMODE" = 1 ] ; then
    hyprctl --batch "\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
	keyword general:active-opacity 0;\    
exit
fi
hyprctl reload
