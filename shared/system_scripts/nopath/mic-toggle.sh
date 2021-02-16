#!/bin/bash
amixer -D pulse sset Capture toggle
dunstify -r 19987 -t 2000 "mic" "$(amixer get Capture | awk 'NR==5' | awk '{ print $NF }')"
