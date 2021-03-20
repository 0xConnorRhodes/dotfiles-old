#!/bin/zsh
# script to take screenshot and open it for editin in ksnip
# gets around problem of multi-monitor screenshots in flameshot and 
# Author: Connor Rhodes (connorrhodes.com)

killall unclutter

CACHEDIR

trash-put /home/connor/.cache/tesseract-ocr/*
rm /home/connor/.local/share/nvim/swap//%home%connor%.cache%tesseract-ocr%ocr.txt.swp

import ~/.cache/tesseract-ocr/$(date +"%Y-%m-%d_%H-%M-%S").png

#flameshot gui -p ~/.cache/tesseract-ocr/

unclutter --timeout 1 --jitter 5 --ignore-scrolling &

#read NEWFILE < <(ls -t /home/connor/.cache/tesseract-ocr/*.png)

cd /home/connor/.cache/tesseract-ocr

/usr/bin/tesseract * ocr

sed -i 's/\o14//g' ocr.txt

sed -i '/^$/d' ocr.txt

rm /home/connor/.local/share/nvim/swap//%home%connor%.cache%tesseract-ocr%ocr.txt.swp

urxvtc -e nvim /home/connor/.cache/tesseract-ocr/ocr.txt

xclip -r -selection clipboard -i /home/connor/.cache/tesseract-ocr/ocr.txt
xclip -r -selection primary -i /home/connor/.cache/tesseract-ocr/ocr.txt
