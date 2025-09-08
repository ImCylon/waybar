#!/usr/bin/env bash

OUTPUT_DIR="$HOME/.cache/waybar"
OUTPUT_WORLD="$HOME/.cache/waybar/emerge-world.txt"

[ ! -d "$OUTPUT_DIR" ] && mkdir -p "$OUTPUT_DIR"

  # Pacotes no World
# sudo emaint sync -A > /dev/null 2>&1 && \
# sudo eix-sync -a > /dev/null 2>&1 && \
rm $OUTPUT_WORLD
touch $OUTPUT_WORLD
sudo emerge --sync > /dev/null 2>&1 && \
sudo emerge -uDNp @world 2>/dev/null \
  | grep "\[ebuild" | \
  sed -E 's/\[ebuild\s+(\w+)\s+\]\s+\S+\/(.*)\-([0-9].*)[ []+(.*[a-zA-Z0-9.=\"]+).*$/\1  \2 \4 -> \3/g' \
    > "$OUTPUT_WORLD"

# Envia notificação

if [[ -s "$OUTPUT_WORLD" ]]; then
    notify-send "UPDATE:" "$(cat "$OUTPUT_WORLD")"
else
    notify-send "UPDATE:" "Sem novas atualizações!"
fi

exit 0
