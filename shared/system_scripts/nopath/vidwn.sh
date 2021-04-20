#!/bin/sh

notify-send "newsboat" "downloading" &
youtube-dl -o '/home/connor/vid/dwn/%(title)s-%(id)s.%(ext)s' "$1" >/dev/null 2>&1
notify-send "newboat" "done" 
