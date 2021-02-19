#!/bin/bash

CHOICE=$(xcolor)

echo $CHOICE | xclip -selection primary
echo $CHOICE | xclip -selection secondary
echo $CHOICE | xclip -selection clipboard

notify-send $CHOICE
