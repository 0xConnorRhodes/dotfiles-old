#!/bin/bash
# Screen Lock script by Connor Rhodes (connorrhodes@gmail.com) 2021-02-15

xset dpms force off
sleep .5
xset dpms force off
xset s 5 5
pkill obsidian #kills obsidian, so I can edit dayplanner on phone without sync conflict
lockargs="--timepos=x+105:h-70 --timestr=%H:%M" betterlockscreen -l
xset s 300 300
# refresh top bar
kill $(pstree -lp | grep -- -baraction.sh | sed "s/.*sleep//" | sed "s/(//" | sed "s/)//")
obsidian &!
