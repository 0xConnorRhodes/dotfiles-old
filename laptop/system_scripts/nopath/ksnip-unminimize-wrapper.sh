#!/bin/bash
# Wrapper script to unminimize Ksnip if it starts minimized
# Connor Rhodes (connorrhodes.com)

# start Ksnip and fork into the background
# $1 allows user to pass ksnip args to this script
ksnip $1 &

# sleep so wmctrl runs after ksnip has been assigned window ID
sleep .5

# get Ksnip window id
KSNIPID=$(wmctrl -l | grep ksnip | awk '{print $1}')

# Unminimize ksnip window by id
wmctrl -ia $KSNIPID
