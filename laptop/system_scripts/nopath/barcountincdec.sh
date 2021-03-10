#!/bin/bash
# script to increment or decrement bar counter and also increment or decrement completed task counter
# Connor Rhodes (connorrhodes.com)

remaining=$HOME/.cache/count.txt
done=$HOME/.cache/donecount.txt

case $1 in

  inc)
	  echo $(expr $(cat $remaining) + 1) > $remaining
	  echo $(expr $(cat $done) - 1) > $done
    ;;

  dec)
	  echo $(expr $(cat $remaining) - 1) > $remaining
	  echo $(expr $(cat $done) + 1) > $done
    ;;

esac

/home/connor/.local/dotfiles/shared/system_scripts/path/refbar
