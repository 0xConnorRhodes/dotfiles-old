# note that .zprofile is only run whenever you log in with zsh. not when you run it in a terminal. 
# **Anything you need in all zsh sessions should go in .zshenv**

if [[ "$(tty)" = "/dev/tty1" ]]; then
	# exec startx always runs startx when quit back to tty.
	# startx without exec only runs startx once
	exec startx
fi
emulate sh -c '. ~/.profile'
