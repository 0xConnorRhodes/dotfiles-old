#!/bin/bash
# from https://gist.github.com/andreafortuna/6eea255e1846c894d46c4b7d8b813878
# modified for use with Lenovo ThinkPad e15 by Connor Rhodes (connorrhodes.com)

# Simple script to modify screen brightness
# USAGE:
# brightness.sh +20 (Increase brightness by 20%)

handler="/sys/class/backlight/amdgpu_bl0/"

# current brightness
old_brightness=$(cat $handler"brightness")

# max brightness
max_brightness=$(cat $handler"max_brightness")

# current %
#old_brightness_p=$(( 100 * $old_brightness / $max_brightness ))
old_brightness_p=$(( 100 * $old_brightness / $max_brightness ))

# new % 
new_brightness_p=$(($old_brightness_p $1))

# new brightness value
new_brightness=$(( $max_brightness * $new_brightness_p / 100 ))

# echo the suplied brightness amount, unless the script fails (because the interval is wrong) in that case echo max brightness

# if $1 has a minus, echo down the new brightness unless there's an error, then echo minimum brightness
# this is necessary because the script will error out if you try to lower the brightness below the minimum supported amount
if [[ $1 == *'-'* ]]; then

  echo $new_brightness > $handler"brightness" || echo 1 > $handler"brightness"

# same as above but for positive brightness
else

  echo $new_brightness > $handler"brightness" || echo 255 > $handler"brightness"

fi

