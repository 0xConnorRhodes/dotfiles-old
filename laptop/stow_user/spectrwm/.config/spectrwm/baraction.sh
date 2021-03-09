#!/bin/bash
# baraction.sh script for spectrwm status bar

## DISK
hdd() {
  hdd="$(df -h | grep nvme0n1p2 | awk '{print $4}')"
  echo -e "$hdd"
}

### VOLUME
#vol() {
#    vol=`amixer get Master | awk -F'[][]' 'END{ print $4":"$2 }' | sed 's/on:/ /g' | sed 's/off:/ /g'`
#    echo -e "$vol"
#}

## BATTERY
bat() {
    cap1="$(cat /sys/class/power_supply/BAT0/capacity)"
    acstatus=$(cat /sys/class/power_supply/AC/online)
    chargestatus=$(upower -d | grep -m 1 "state:" | awk '{ print $2 }')
    if [ "$chargestatus" == "fully-charged" ] && [ "$acstatus" == 1 ]
    then
	    cap1="100" 
    fi
    echo "$cap1"
}

## COUNTER
#counter() {
# tk
#}

## INTERNET
#int() {
#    grep -q "down" /sys/class/net/w*/operstate && wifiicon="📡" ||
#    	wifiicon="$(grep "^\s*w" /proc/net/wireless | awk '{ print "", int($3 * 100 / 70) "%" }')"
#    
#    lukecmd= printf "%s %s\n" "$wifiicon" "$(sed "s/down/❎/;s/up/🌐/" /sys/class/net/e*/operstate)" | awk '{print $1}'
#    
#    echo $lukecmd
#}


## BLUETOOTH
#btooth() {
#    blt=$(bluetoothctl info | grep "Connected" | sed "s/Connected: yes//")
#    echo $blt
#}

## WEATHER
#wtr() {
#	wtr2=$()
#	echo $wtr2
#}


## work email
#wmail() {
#	wmail2=$(~/.config/mailnotifications/workmailnotifications.sh)
#	echo $wmail2
#}

## personal email
#pmail() {
#	pmail2=$(~/.config/mailnotifications/personalmailnotifications.sh)
#	echo $pmail2
#}

# pomodoro time
ptime() {
	[ -z "$(pgrep pomo)" ] && echo "" > /home/connor/.cache/pomodoro-time.txt
	pomtime=$(cat /home/connor/.cache/pomodoro-time.txt)
	echo "$pomtime"
}


SLEEP_SEC=60
#loops forever outputting a line every SLEEP_SEC secs

# It seems that we are limited to how many characters can be displayed via
# the baraction script output. And the the markup tags count in that limit.
# So I would love to add more functions to this script but it makes the 
# echo output too long to display correctly.
while :; do
	#echo "+@fg=1;  $(pmail) | +@fg=0;  $(hdd) | +@fg=0;  +@fn=0; $(vol) +@fg=0; |   $(bat)% |  $(btooth) |  $(int) |"
	echo "+@fg=1;$(ptime) +@fg=0;  $(hdd) | +@fg=0;+@fn=0; $(bat)% |"
	sleep $SLEEP_SEC
done
