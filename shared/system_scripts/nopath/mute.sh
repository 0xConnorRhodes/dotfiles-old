#!/bin/sh

#amixer -q sset Master toggle;refbar # legacy alsa command
pactl set-sink-mute @DEFAULT_SINK@ toggle
kill $(pstree -lp | grep -- -baraction.sh | sed "s/.*sleep//" | sed "s/(//" | sed "s/)//")
