#!/bin/bash
# Acript to toggle the floating a webcam. If it is hidden or not on the current 
# desktop, unhide it and move it to the current desktop. Otherwise, hide it and 
# move it to my unused desktop.
# 
# Author: Connor Rhodes (https://connor.engineer)


winname="Windowed Projector (Scene) - fullscreen_camera"

winid=$(wmctrl -l | grep "$winname" | awk '{ print $1 }')


if [[ -z $(xprop -id $winid | grep "HIDDEN") ]]; #triggers if it is not hidden
# if it is running and if it is not hidden...

then

	if [[ $(wmctrl -l | grep "$winname" | awk '{ print $2 }') == $(wmctrl -d | grep \* | awk '{ print $1 }') ]];
	# the first command is what workspace is it on, the second is what is the current workspace. if they are equal, then this triggers.
	# if it is running, and if it is not hidden and if it is on the current workspace

	then 
		wmctrl -r "$winname" -t 9
		wmctrl -r "$winname" -b add,hidden


	else 
		wmctrl -r "$winname" -t $(wmctrl -d | grep \* | awk '{ print $1 }') 
		#move it to the current workspace


	fi

else
#if it is running, and if it is hidden...
	wmctrl -r "$winname" -b remove,hidden
	wmctrl -r "$winname" -t $(wmctrl -d | grep \* | awk '{ print $1 }')

fi
