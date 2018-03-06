#!/usr/bin/env zsh

# sunny - simple zsh theme with solarized in mind and vcs_info support

# (c) 2014-2018 Miroslaw Baran <miroslaw+p+varia@makabra.org>
# this script, if at all copyrightable, is free software under
# 3-clause BSD licence

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

() {
    # prompt component containers
    local -a _line _elem
    # colours
    local -A c
    # prompt building bricks
    local _rc _uidp _uhost _tty _lbracket _rbracket _at


    # prepare the bricks
    # c[local]='%F{003}'
    c[local]="%F{green}"
    c[remote]="%F{014}"
    c[path]="%F{014}"
    c[ok]="%F{034}"
    c[nok]="%F{red}"
    c[deco]="%F{cyan}"

    _lbracket="${c[deco]}[%f"
    _rbracket="${c[deco]}]%f"
    _at="${c[deco]}@%f"

    _uidp='%(!.#.»)' # am I root?

    _uhost=${c[local]}
    test -n "${SSH_TTY}" && _uhost=${c[remote]} # LOCAL is not REMOTE

    _tty="%y"
    test -n "${DESK_NAME}" && _tty="◲ (${DESK_NAME})" # desk is useful; use desk

    _rc="%(0?.${c[ok]}${_uidp}%f.${c[nok]}${_uidp}%f)"


    # construct the prompts

    # first line
    _elem+=$'\n'
    _elem+="${_lbracket}${_uhost}%n${_at}${_uhost}%m${_rbracket}"
    _elem+=" "
    _elem+="${_lbracket}${c[path]}"'${PWD/#$HOME/~}'"${_rbracket}"
    _line+=${(j::)_elem}

    # second line
    _line+="${_tty}${_rc} "

    # and, finally:
    PROMPT=${(F)_line}
    RPROMPT='%F{242}${vcs_info_msg_1_}%f'
}
