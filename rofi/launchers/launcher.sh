dir="$HOME/.config/rofi/launchers/"
theme='style-7'

export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"

rofi \
	-show drun \
	-theme ${dir}/${theme}.rasi
