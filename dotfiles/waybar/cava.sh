#!/bin/bash

# Tue toute instance cava existante
pkill -x cava 2>/dev/null

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# Construire le dictionnaire sed
for ((i = 0; i < ${#bar}; i++)); do
  dict="${dict}s/$i/${bar:$i:1}/g;"
done

config_file="/tmp/polybar_cava_config"

cat >"$config_file" <<EOF
[general]
bars = 30

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

# Lance cava ET arrête le script dès que cava s’arrête
cava -p "$config_file" | while read -r line; do
  # si plus de line -> cava est arrêté -> on stop tout
  [ -z "$line" ] && exit 0

  echo "$line" | sed "$dict"
done
