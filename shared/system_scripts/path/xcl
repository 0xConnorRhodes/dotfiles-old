#!/bin/bash
# script to allow my to pipe text into all X11 clipboards simultaneously
# Connor Rhodes (connorrhodes.com)

[[ -p /dev/stdin ]] && { mapfile -t; set -- "${MAPFILE[@]}"; }

for i in "$@"; do
    echo "$i" | xclip -selection primary
    echo "$i" | xclip -selection secondary
    echo "$i" | xclip -selection clipboard
done
