#!/bin/zsh
# laptop version of dmenu launcher script by Connor Rhodes (connorrhodes@gmail.com)

# show all dmenu script folder contents combined into one prompt
SELECTION=$(ls \
	~/.local/dotfiles/shared/system_scripts/dmenu-scripts/term/* \
	~/.local/dotfiles/shared/system_scripts/dmenu-scripts/noterm/* \
	~/.local/dotfiles/$(hostname)/system_scripts/dmenu-scripts/term/* \
	~/.local/dotfiles/$(hostname)/system_scripts/dmenu-scripts/noterm/* | \
	xargs -n 1 basename | \
	dmenu -fn 'Hack:normal:pixelsize=32')

# get the name of the file
NAME=$(echo $SELECTION | awk '{print $1}')

ARGS=$(echo $SELECTION | awk '{sub($1 FS,"")}7')

echo $NAME
echo $ARGS

# if NAME and ARGS are equal, there are no arguments. Unset that variable
if [ "$ARGS" = "$NAME" ];then
	#unset ARGS
fi

# get the full path of the selected script for the final exec command
FULLPATH=$(ls -d \
	~/.local/dotfiles/shared/system_scripts/dmenu-scripts/term/* \
	~/.local/dotfiles/shared/system_scripts/dmenu-scripts/noterm/* \
	~/.local/dotfiles/$(hostname)/system_scripts/dmenu-scripts/term/* \
	~/.local/dotfiles/$(hostname)/system_scripts/dmenu-scripts/noterm/* \
	| grep $NAME)

# run the full path to the dmenu script with any arguments passed to it
# TODO if noterm in pathh exec else urxvt exec


case "$FULLPATH" in
	*noterm*) 	
		# the echo substitution is necessary for this to run with the args
		exec $(echo "$FULLPATH $ARGS");;
	*)		
		exec urxvtc -e "$FULLPATH" $ARGS
esac
