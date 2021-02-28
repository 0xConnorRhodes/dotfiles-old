#!/bin/bash
# Toggle active pulse microphone and create a (self-replacing) notification to show the microphone status.
# Connor Rhodes (connorrhodes.com)

amixer -D pulse sset Capture toggle
dunstify -r 19987 -t 2000 "mic" "$(amixer get Capture | awk 'NR==5' | awk '{ print $NF }')"
