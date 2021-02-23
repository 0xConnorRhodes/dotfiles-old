#!/bin/bash
Xephyr -br -ac -noreset -no-host-grab -screen 1920x1080 :1 &
export DISPLAY=:1
xrdb -merge ~/.Xresources
jwm -f ~/.config/jwm/.jwmrc &
