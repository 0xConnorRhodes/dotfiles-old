#!/bin/bash
cd /home/connor/dox/notes/Engineers_Notes
FILE=$(fzf)

nvim "$FILE"
