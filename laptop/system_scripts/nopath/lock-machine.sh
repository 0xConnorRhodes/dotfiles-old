#!/bin/bash
# Screen Lock script by Connor Rhodes (connorrhodes@gmail.com) 2021-02-15

xset dpms force off
sleep .5
xset dpms force off
sleep 3.5
xset dpmd force off
xinput --set-prop 14 "Device Enabled" "0" # this disables the mouse
xinput --set-prop 13 "Device Enabled" "0" # this disables the trackpoint
pkill obsidian #kills obsidian, so I can edit dayplanner on phone without sync conflict
betterlockscreen --lock
xinput --set-prop 14 "Device Enabled" "1"
xinput --set-prop 13 "Device Enabled" "1"
