#!/bin/bash
# Script to launch or focus a web-based dictation app and hide it if it is currently focused.
# Connor Rhodes (connorrhodes.com)

#winname="docs.google.com__document_d_1o-rvkrU6t7xd40L2eGGvKD9xzY_pXbq0AKjBP6p4FXc_edit"
winname="100_Dictation - Google Docs"

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

		then 
			wmctrl -r "$winname" -b add,hidden

			# copy dictated text to clipboard and clear out dictation file
			## note that every time dictation-scratch is LOFed it will copy and
			## clear the doc, so if you want to hide and come back, use Mod4+BS
			## also, every new launch search and select Zoom:fit to fit text to
			## window width

			WORK_DIR=$HOME/.cache/google-docs-dictation
			
			# ignore times is necessary to force a sync
			rclone sync \
				--ignore-times \
				--drive-export-formats odt \
				personal_gdrive:100_Dictation.odt $WORK_DIR
			
			pandoc $WORK_DIR/100_Dictation.odt --to plain -o $WORK_DIR/output.txt
			
			cat $WORK_DIR/output.txt | xcl

			notify-send "dictation" "Copied to Clipboard"
			
			cp $WORK_DIR/blank.odt $WORK_DIR/100_Dictation.odt
			
			rclone sync \
				--ignore-times \
				--drive-export-formats odt \
				--drive-import-formats odt \
				$WORK_DIR/100_Dictation.odt personal_gdrive:

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
