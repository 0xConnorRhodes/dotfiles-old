#!/bin/bash
cd ~/dox/notes
SEARCH=$(rg . | fzf | cut -d : -f 1 | awk -F/ '{ print $NF }')
nvim "$(find "$(pwd -P)" -name "$SEARCH")"
# add a command using vim +9 etc to go to line 9 to go to the line of the string I searched for