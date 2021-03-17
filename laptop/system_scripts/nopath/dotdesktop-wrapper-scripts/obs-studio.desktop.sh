#!/bin/bash
# Script to change settings for a screencast, launch OBS
# and revert to non-screencast settings after OBS exits
# 
# OBS_dotdesktop_name: com.obsproject.Studio.desktop
# Author: Connor Rhodes (connorrhodes.com)

killall unclutter
sleep 1
hhpc -i 1 &
sleep 1

obs

sleep 1
killall hhpc
sleep 1
#nohup unclutter --timeout 1 --jitter 5 --ignore-scrolling >/dev/null 2>&1
#sleep 1
unclutter --timeout 1 --jitter 5 --ignore-scrolling
