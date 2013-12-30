# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Theme settings. Optionally, if you set this to "random",
# it'll load a random theme each time that oh-my-zsh is
# loaded.
ZSH_THEME="sunny"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting
# terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be
# displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found
# in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git mercurial svn vi-mode python)

source $ZSH/oh-my-zsh.sh

path_components=(/usr/local/{s,}bin /{s,}bin /usr/{s,}bin /usr/games "${HOME}/bin")

# functions
cleanup_path() {
    local pathcomp
    local path
    for pathcomp in "$@"; do
        if [[ -d "$pathcomp" ]]; then
            path="${path}${path:+:}${pathcomp}"
        fi
    done
    echo "$path"
}

update_session_environment() {
    local var
    local value
    if [[ -n "$TMUX" ]]; then
        while IFS="=" read var value; do
            if [[ -n "${var/-*/}" ]]; then
                export $var="$value"
            fi
        done < <(tmux show-environment)
    fi
}

# hooks
add-zsh-hook precmd update_session_environment

# environment variables

export PATH="$(cleanup_path ${path_components[@]})"

export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

export FORTUNES=$HOME/.fortunes/common
export ONELINERS=$HOME/.fortunes/one-liners
export SIGFIXED=$HOME/.signatures/sigfixed

export IRCNICK="Jubal"
export IRCNAME="when it rains, it pours..."
export IRCSERVER="polska.irc.pl"
export IRCUMODE="+iw-s"

export VISUAL=vim
export EDITOR=vim

# shell settings
setopt appendhistory
setopt autocd
setopt completeinword
setopt nocorrectall
setopt extendedglob
setopt histexpiredupsfirst
setopt histignoredups
setopt histverify
setopt incappendhistory
setopt nohistfindnodups
setopt nomatch
setopt notify
setopt sharehistory

# keybindings
bindkey "[A" up-line-or-history
bindkey "[B" down-line-or-history
bindkey "[C" forward-char
bindkey "[D" backward-char
bindkey "[3~" vi-delete-char
bindkey "^R" history-incremental-search-backward
bindkey "^H" backward-delete-char
bindkey "" vi-beginning-of-line 
bindkey "" vi-end-of-line 

# aliases

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors ~/.dircolors)" || eval "$(dircolors)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

which lesspipe > /dev/null && eval $(lesspipe)
