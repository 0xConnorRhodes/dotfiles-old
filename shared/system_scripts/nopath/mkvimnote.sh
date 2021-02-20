#!/bin/bash
# if desired, can convert to a case statement per mkvimnote.sh and create spreadsheets etc in the same directory

FOLDER=$(find /home/connor/dox/notes -type d | fzf)
read -p "enter filename.ext: " FNAME

if [[ $FNAME == *".org"* ]];
then
	emacsclient -c -n $(echo $FOLDER)/$(echo $FNAME | sed 's/ /_/g')
else
	#nvim $(echo $FOLDER)/$(echo $FNAME | sed 's/ /_/g').md
	nvim "$FOLDER/$FNAME.md"
fi
