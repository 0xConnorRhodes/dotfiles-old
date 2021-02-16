#!/usr/bin/env sh
# markdown notes sync script. 
# Inspired by https://gist.github.com/tallguyjenks/ca3339b8b5353159f631836268e3f791#file-zk_sync-sh
# modified by Connor Rhodes (connorrhodes.com)

NOTES_PATH="/home/connor/dox/notes"

cd "$NOTES_PATH"

git pull

CHANGES_EXIST="$(git status --porcelain | wc -l)"
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ we are assigning
# a value to the variable `CHANGES_EXIST`, the value is the output
# of `git add --porcelain` which outputs a simple list of just the
# changed files and then the output is piped into the `wc` utility
# which is "word count" but with the `-l` flag it will count lines.
# basically, it says how many total files have been modified.
# if there are no changes the output is 0

if [ "$CHANGES_EXIST" -eq 0 ]; then
	exit 0
fi
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The whole if block is saying
# in plain english: if there are no changes (CHANGES_EXIST = 0)
# then exit with no error code `exit 0` if there are changes,
# then continue on with the script

git pull

git add .

git commit -q -m "Last Sync: $(date +"%Y-%m-%d %H:%M:%S")"

git push -q
