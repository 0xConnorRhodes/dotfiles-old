#!/bin/zsh
# script to take screenshot and open it for editin in ksnip
# gets around problem of multi-monitor screenshots in flameshot and 
# Author: Connor Rhodes (connorrhodes.com)

CACHEDIR=$HOME/.cache/screenshot-annotate

trash-put $CACHEDIR/*

killall unclutter ; killall hhpc

import $CACHEDIR/$(date +"%Y-%m-%d_%H-%M-%S").png

unclutter --timeout 1 --jitter 5 --ignore-scrolling &

ksnip -e $CACHEDIR/*

xclip -selection clipboard -target image/png -i $CACHEDIR/*
