#!/bin/sh

thisday=$(date +%Y-%m-%d)

notes_number=$(fd --base-directory ~/dox/notes/tech --type file --changed-within 1d --exclude rice --exclude cheat | wc -l)

note_lines=$(fd --base-directory ~/dox/notes/tech --type file --changed-within 1d --exclude rice --exclude cheat -X cat | grep "\S" | wc -l)

printf "$thisday,$notes_number,$note_lines" >> ~/dox/logs/daily_atomic_notes.csv
