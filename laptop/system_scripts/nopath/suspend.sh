#!/bin/bash
bluetoothctl block 38:18:4C:4B:EB:64
bluetoothctl block 9A:BC:03:02:41:1F
lockargs="--timepos=x+105:h-70 --timestr=%H:%M" betterlockscreen -s
