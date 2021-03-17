#!/bin/bash
# Script to change settings for a screencast, launch OBS
# and revert to non-screencast settings after OBS exits
# 
# OBS_dotdesktop_name: com.obsproject.Studio.desktop
# Author: Connor Rhodes (connorrhodes.com)

killall unclutter
hhpc -i 1 &

obs

killall hhpc
nohup unclutter --timeout 1 --jitter 5 --ignore-scrolling >/dev/null 2>&1
