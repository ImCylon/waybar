#!/usr/bin/env bash

OUTPUT_DIR="$HOME/.cache/waybar"
OUTPUT_WORLD="$HOME/.cache/waybar/emerge-world.txt"

[ ! -d "$OUTPUT_DIR" ] && mkdir -p "$OUTPUT_DIR"

  # Pacotes no World
sudo emerge -uDNp @world 2>/dev/null \
  | grep "\[ebuild" | \
  sed -E 's/\[ebuild\s+(\w+)\s+\]\s+\S+\/(.*)\-([0-9].*)[ []+(.*[a-zA-Z0-9.=\"]+).*$/\1  \2 \4 -> \3/g' \
    > "$OUTPUT_WORLD"

  exit 0
