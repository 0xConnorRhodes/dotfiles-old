# Zsh config for Connor Rhodes (connorrhodes.com)

zmodload zsh/zprof

autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Load aliases and shortcuts if existent.
source "/home/connor/.config/zsh/.zsh_aliases"

# History in cache directory:
HISTSIZE=999999999999999999
SAVEHIST=999999999999999999
HISTFILE=~/.cache/zsh/history

autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist

for dump in ~/.config/zsh/.zcompdump(N.mh+24); do
  compinit
done

compinit -C

#fasd
fasd_cache="$HOME/.config/fasd/.fasd-init-zsh"
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
      fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
    fi
    source "$fasd_cache"
    unset fasd_cache



# Include hidden files in autocomplete:
_comp_options+=(globdots)

# Use vim keys in tab complete menu: bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey '^H' backward-kill-word
bindkey '^[[33~' kill-word #urxvt sends this fake f19 key with ctrl backspace, this sequence is the only way zsh will accept f19 in the config (note, this doesn't work for alacritty, but another sequence might

export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
# for cursor echo options, see https://unix.stackexchange.com/a/614203
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q' #solid cursors

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[6 q"
}
zle -N zle-line-init

# custom fzf cd function
cdz () {

	dir="$(fd --one-file-system \
		--ignore-file /home/connor/.config/fd/folder-jump-ignore \
		-H -d 6 -t d . | fzf)"

	cd "$dir"
}
zle -N cdz
bindkey -s '^g' 'cdz\n'

lflaunch () {
	lf
}
zle -N lflaunch
bindkey -s '^f' 'lflaunch\n'

# Use beam shape cursor on startup.
echo -ne '\e[6 q'
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[6 q' ;}

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

bindkey -s '^o' 'lfcd\n'  # zsh

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

setopt autocd

# exports
export EDITOR=nvim

# colors in the pager like man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# zsh history search keybinds
# makes arrow keys go up to previous instances of typed command
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# python-argcomplete utt
autoload bashcompinit
bashcompinit
source ~/.config/utt/.utt_bash_autocomplete

# nnn
source ~/.config/nnn/nnn.zshrc

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
#eval "$(starship init zsh)"
