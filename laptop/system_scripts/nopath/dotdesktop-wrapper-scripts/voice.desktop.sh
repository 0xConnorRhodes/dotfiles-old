#!/bin/bash
# Script to launch or focus Firefox and hide it if it is currently focused.
# Connor Rhodes (connorrhodes.com)


winname="Voice - Calls — Mozilla Firefox"

winid=$(wmctrl -l | grep "$winname" | awk '{ print $1 }')

if [ -z "$(wmctrl -l | grep "$winname")" ]
# -z triggers if it is empty. so this is, if it is not running...


then 
	exec env GTK_THEME="Redmond97 Firefox Solaris" \
		/usr/lib/firefox/firefox -P App \
		--new-window https://voice.google.com/u/0/calls &
	sleep 3 #might require some fiddling. It's the time it takes to launch google chrome

	winid=$(wmctrl -l | grep "$winname" | awk '{ print $1 }')
	wmctrl -r "$winname" -t $(wmctrl -d | grep \* | awk '{ print $1 }') 
else 

	wmctrl -r "$winname" -b remove,hidden
        winid=$(wmctrl -l | grep "$winname" | awk '{ print $1 }')

	wmctrl -r "$winname" -t $(wmctrl -d | grep \* | awk '{ print $1 }') 
fi

