#!/bin/bash
cd /home/connor/dox/notes/engineers_notes
FILE=$(fzf)

nvim "$FILE"
