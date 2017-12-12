#!/usr/bin/env zsh

# sunny - simple zsh theme with solarized in mind and vcs_info support

# (c) 2014-2015 Miroslaw Baran <miroslaw+p+varia@makabra.org>
# this script is free software under 3-clause BSD licence

setopt promptsubst
autoload -U add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable hg svn git
zstyle ':vcs_info:*:*' check-for-changes true
zstyle ':vcs_info:*:*' unstagedstr '△'
zstyle ':vcs_info:*:*' stagedstr '▲'
zstyle ':vcs_info:hg:*' get-mq true
zstyle ':vcs_info:hg:*' get-bookmarks true
zstyle ':vcs_info:*:*' actionformats "%S" "(%s)/%r at %b %u%c (%a)"
zstyle ':vcs_info:*:*' formats "%S" "(%s)/%r at %b %u%c"
zstyle ':vcs_info:*:*' nvcsformats "%~" ""

add-zsh-hook precmd vcs_info

function () {
    local -a p_line p_elem uhost_color ttyinfo rc_indicator

    if [[ -n "${SSH_TTY}" ]]; then
        uhost_color="003"
    else
        uhost_color="014"
    fi

    if [[ -n "${DESK_NAME}" ]]; then
        ttyinfo='◲ (${DESK_NAME})'
    else
        ttyinfo='%y'
    fi

    rc_indicator='%(0?.%F{034}%(!.#.»)%F{default}.%F{160}%(!.#.»)%F{default})'

    # first line
    p_elem+=$'\n'
    p_elem+='%F{006}[%F{default}%F{'${uhost_color}'}%n%F{default}%F{006}@%F{default}%F{'${uhost_color}'}%m%F{default}%F{006}]%F{default}'
    p_elem+=' '
    p_elem+='%F{006}[%F{default}%F{014}${PWD/#$HOME/~}%F{default}%F{006}]%F{default}'
    p_line+=${(j::)p_elem}

    # second line
    p_line+="${ttyinfo}${rc_indicator} "

    # prompts
    PROMPT=${(F)p_line}
    RPROMPT='%F{242}${vcs_info_msg_1_}%F{default}'
}
