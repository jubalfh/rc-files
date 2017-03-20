# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

ttyname() {
    tty | cut -d/ -f3-
}

export HISTCONTROL=ignoreboth
export HISTFILE=~/.bash_history
export PROMPT_DIRTRIM=6

shopt -s checkwinsize
shopt -s extglob
shopt -s histappend

if [[ $BASH_VERSION =~ ^4 ]]; then
    shopt -s globstar
fi

export PROMPT_FMT='[\u@\h] [\w]\n ($(ttyname))$ '
case "$TERM" in
xterm*|rxvt*|screen*)
    PROMPT_FMT="\[\033]0;[\u@\h \w]\007\]${PROMPT_FMT}"
    ;;
*)
    ;;
esac

export PROMPT_COMMAND='PS1="${PROMPT_FMT}"'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors ~/.dircolors)" || eval "$(dircolors)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -f ~/.environment ]; then
    . ~/.environment
fi

which lesspipe >/dev/null 2>&1 && eval "$(lesspipe)"
