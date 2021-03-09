#!/bin/sh

userresources=$HOME/.config/Xresources/Xresources
usermodmap=$HOME/.config/xmodmap/xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

xset b off &
setxkbmap co
xrdb /home/connor/.config/Xresources/Xresources &
xset r rate 155 75 & # this is the best if I can manage to adjust to it.
xmodmap ~/.config/xmodmap/xmodmap &
numlockx &
feh --bg-scale /home/connor/.local/share/wallpaper/circlogo.jpg &
dunst &
picom &
redshift &
keynav &
exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
export QT_STYLE_OVERRIDE=kvantum
export QT_SCALE_FACTOR=1.5 
export QT_FONT_DPI=115
# note that launching wm with dbus is necessary for flameshot to work correctly
export DISPLAY=:0

monitor_count=$(xrandr | grep connected | grep -v disconnected | wc -l)

if [ $monitor_count -eq 3 ];
then
	xrandr --output eDP --off --output HDMI-A-0 \
		--mode 1920x1080 --pos 1920x0 --rotate normal \
		--output DisplayPort-0 --primary \
		--mode 1920x1080 --pos 0x0 --rotate normal
	xinput --set-prop pointer:"HID 1bcf:08a0 Mouse" "libinput Natural Scrolling Enabled" 0
	exec dbus-launch spectrwm
else
	xrandr --output eDP --primary --mode 1920x1080 \
		--pos 0x0 --rotate normal --output HDMI-A-0 \
		--off --output DisplayPort-0 --off
	xinput --set-prop "ETPS/2 Elantech Touchpad" "libinput Accel Speed" .3 #t460 setting was .2
	xinput --set-prop "ETPS/2 Elantech TrackPoint" "libinput Accel Speed" .3 #the t460 setting was .2
	xinput --set-prop "ETPS/2 Elantech TrackPoint" "libinput Natural Scrolling Enabled" 0
	exec dbus-launch spectrwm
fi
#exec dbus-launch spectrwm
