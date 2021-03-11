#!/bin/bash
# Script to launch or focus a web-based dictation app and hide it if it is currently focused.
# Connor Rhodes (connorrhodes.com)

winname="docs.google.com__document_d_1o-rvkrU6t7xd40L2eGGvKD9xzY_pXbq0AKjBP6p4FXc_edit"

if [ -z "$(wmctrl -l | grep "$winname")" ]
# -z triggers if it is empty. so this is, if it is not running...

then exec chromium --app=https://docs.google.com/document/d/1o-rvkrU6t7xd40L2eGGvKD9xzY_pXbq0AKjBP6p4FXc/edit &>/dev/null & #this syntax is necessary for output to go to /dev/null
# then run it

sleep 3 #might require some fiddling. It's the time it takes to launch google chrome

winid=$(wmctrl -l | grep "$winname" | awk '{ print $1 }')

exec ~/bin/set_wm_class $winid dynamic-scratchpad dictationIO
# set custom class and window names

else 
        winid=$(wmctrl -l | grep "$winname" | awk '{ print $1 }')

	if [[ -z $(xprop -id $winid | grep "HIDDEN") ]]; #triggers if it is not hidden
	# if it is running and if it is not hidden...

	then

		if [[ $(wmctrl -l | grep "$winname" | awk '{ print $2 }') == $(wmctrl -d | grep \* | awk '{ print $1 }') ]];
		# the first command is what workspace is it on, the second is what is the current workspace. if they are equal, this triggers
		# if it is running, and if it is not hidden and if it is on the current workspace

		then wmctrl -r "$winname" -b add,hidden

		else 
			wmctrl -r "$winname" -t $(wmctrl -d | grep \* | awk '{ print $1 }') 
			#move it to the current workspace


		fi

	else
	#if it is running, and if it is hidden...
		wmctrl -r "$winname" -b remove,hidden
		wmctrl -r "$winname" -t $(wmctrl -d | grep \* | awk '{ print $1 }')

	fi

fi
