#!/bin/zsh
# laptop version of dmenu launcher script by Connor Rhodes (connorrhodes@gmail.com)

# show all dmenu script folder contents combined into one prompt
SELECTION=$(ls \
	~/.local/dotfiles/shared/system_scripts/dmenu-scripts/* \
	~/.local/dotfiles/laptop/system_scripts/dmenu-scripts | \
	xargs -n 1 basename | \
	dmenu -fn 'Hack:normal:pixelsize=32')

# get the name of the file
NAME=$(echo $SELECTION | awk '{print $1}')

ARGS=$(echo $SELECTION | awk '{sub($1 FS,"")}7')


# if NAME and ARGS are equal, there are no arguments. Unset that variable
if [ "$ARGS" = "$NAME" ];then
	unset ARGS
fi

# get the full path of the selected script for the final exec command
FULLPATH=$(ls -d \
	~/.local/dotfiles/shared/system_scripts/dmenu-scripts/* \
	~/.local/dotfiles/laptop/system_scripts/dmenu-scripts/* \
	| grep $NAME)

# run the full path to the dmenu script with any arguments passed to it
exec urxvtc -e "$FULLPATH" "$ARGS"
