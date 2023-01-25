_conf.d() {
    echo ${XDG_CONFIG_HOME:-~/.config}
}

_local.d() {
    echo ${XDG_LOCAL_DIR:-~/.local}
}

(){
    # Path to your oh-my-zsh configuration.
    export ZSH="$(_local.d)/share/oh-my-zsh"

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
    plugins=(
        direnv
        pyenv
        vi-mode
        mosh
        colorize
        git-flow-avh
        history-substring-search
        virtualenv
        bash_completion
    )

    path_components=(
    ~/.cargo/bin
    ~/.pyenv/{bin,shims}
    /home/linuxbrew/.linuxbrew/{s,}bin
    /usr/local/{s,}bin
    /{s,}bin
    /usr/{s,}bin
    /usr/games
    ~/bin ~/.local/bin ~/.local/share/git
    )

    # functions
    cleanup_path() {
        local dir
        local -a path
        for dir in "$@"; do
            if [[ -d "${dir}" ]]; then
                path+="${dir}"
            fi
        done
        echo "${(j.:.)path}"
    }
    export PATH="$(cleanup_path ${path_components[@]})"

    # apply my preferences:

    # environment variables
    export HISTFILE=~/.zsh_history
    export HISTSIZE=100000
    export SAVEHIST=100000

    export FORTUNES=~/.fortunes/common
    export ONELINERS=~/.fortunes/one-liners
    export SIGFIXED=~/.signatures/sigfixed

    export VISUAL=vim
    export EDITOR=vim

    export MC_SKIN=~/.config/mc/solarized.ini
    export WORKON_HOME=~/.virtualenvs

    export HOMEBREW_NO_ANALYTICS=1

    # get the oh-my-zsh baseline
    if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
        source "$ZSH/oh-my-zsh.sh"
    fi

    # options
    # history management
    setopt APPEND_HISTORY
    setopt HIST_EXPIRE_DUPS_FIRST
    setopt HIST_IGNORE_DUPS
    setopt HIST_IGNORE_SPACE
    setopt NO_HIST_REDUCE_BLANKS
    setopt HIST_FCNTL_LOCK
    setopt HIST_VERIFY
    setopt HIST_FIND_NO_DUPS
    setopt INC_APPEND_HISTORY
    setopt SHARE_HISTORY
    # varia
    setopt AUTO_CD
    setopt COMBINING_CHARS
    setopt COMPLETE_IN_WORD
    setopt NO_CORRECT_ALL
    setopt EXTENDED_GLOB
    setopt NOMATCH
    setopt NOTIFY

    # keybindings
    bindkey "^R" history-incremental-search-backward
    bindkey "^H" backward-delete-char
    bindkey "^A" vi-beginning-of-line
    bindkey "^E" vi-end-of-line

    # aliases
    if [[ -x /usr/bin/dircolors ]]; then
        test -r ~/.dircolors && eval "$(dircolors ~/.dircolors)" || eval "$(dircolors)"
        alias ls='ls --color=auto'
        alias dir='dir --color=auto'
        alias vdir='vdir --color=auto'

        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi

    alias rx="exec \$SHELL"

    # pager settings
    which lesspipe >/dev/null 2>&1 && eval $(lesspipe)
    export LESS="-R -F -X"

    # just in case nothing else in the execution order did this…
    autoload -U add-zsh-hook

    # desk awareness
    [ -n "$DESK_ENV" ] && source "$DESK_ENV" || true

    # personality requirements
    what=$(what-am-i); machine_file="$(_local.d)/lib/dotfiles/${what}/machine"
    if [[ -f "${machine_file}" ]]; then
        source "${machine_file}"
    fi

    # and local changes
    if [[ -f ~/.zshrc.local ]]; then
        source ~/.zshrc.local
    fi
}
