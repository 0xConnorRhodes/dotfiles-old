#!/bin/sh

userresources=$HOME/.config/Xresources/Xresources
usermodmap=$HOME/.config/xmodmap/xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

xset b off &
setxkbmap co
xrdb /home/connor/.config/Xresources/Xresources &
xmodmap ~/.config/xmodmap/xmodmap &
numlockx &
export QT_STYLE_OVERRIDE=kvantum
export QT_SCALE_FACTOR=1.5 
export QT_FONT_DPI=115
# note that launching wm with dbus is necessary for flameshot to work correctly
export DISPLAY=:0
exec dbus-launch spectrwm
