#!/bin/zsh
# Script presents an fzf list of my favorite directories and opens pcmanfm in the selected directory
# new directories can be added to the favorites list with dmenu-scripts/add-foldopen
# Connor Rhodes (connorrhodes.io)

devour pcmanfm $(cat ~/.config/foldopen/foldopen_dirs.txt | fzf)
exit
