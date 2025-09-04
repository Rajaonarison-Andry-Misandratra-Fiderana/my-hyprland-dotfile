#!/usr/bin/env bash
set -euo pipefail

# cleanup on exit
cleanup() {
  [[ -n "${CAVAPID:-}" ]] && kill "$CAVAPID" 2>/dev/null || true
  exit 0
}
trap cleanup INT TERM EXIT

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# créer dictionnaire de remplacement pour cava -> barres
i=0
while [ $i -lt ${#bar} ]; do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i + 1))
done

# fichier de config cava temporaire (utilise PulseAudio)
config_file="/tmp/waybar_cava_config"
cat > "$config_file" <<'EOF'
[general]
bars = 35

[input]
# Forcer l'utilisation de PulseAudio pour écouter la sortie (monitor)
method = pulse
source = auto
sample_rate = 44100
channels = 2

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

# Fonction utilitaire : nombre de sink-inputs Pulse
audio_count() {
  # retourne le nombre de flux de lecture (sink-inputs)
  pactl list short sink-inputs 2>/dev/null | wc -l
}

# Boucle principale (long-running) : affiche "No audio" si rien, sinon lance cava
while true; do
  if [ "$(audio_count)" -gt 0 ]; then
    # Démarre cava comme coprocess et récupère son PID
    coproc CAVAPROC { cava -p "$config_file" 2>/dev/null; }
    CAVAPID=$!

    # Lit la sortie ligne par ligne
    while IFS= read -r line <&"${CAVAPROC[0]}"; do
      # Si l'audio a disparu, arrête cava et repars dans la boucle principale
      if [ "$(audio_count)" -eq 0 ]; then
        kill "$CAVAPID" 2>/dev/null || true
        wait "$CAVAPID" 2>/dev/null || true
        break
      fi

      # transforme la ligne ascii de cava en barres et affiche
      echo "$line" | sed "$dict"
    done

    # ferme FD du coprocess si besoin
    exec {CAVAPROC[0]}<&- 2>/dev/null || true

    # petite pause avant de rescanner
    sleep 0.2
  else
    # Pas d'audio -> affiche un indicateur (modifiable)
    echo "No audio"
    sleep 1
  fi
done
