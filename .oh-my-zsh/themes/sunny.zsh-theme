#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# ZSH prompt theme:
# – made with solarized theme in mind
# – vcs information in right prompt

# prerequisites
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

# Add hook for calling vcs_info before each command.
add-zsh-hook precmd vcs_info

function () {
    local -a p_line p_elem

    # first line
    p_elem+=$'\n'
    p_elem+='%F{006}[%F{default}'
    if [[ -n "$SSH_TTY" ]]; then
        p_elem+='%F{003}%n%F{default}%F{006}@%F{default}%F{003}%m%F{default}'
    else
        p_elem+='%F{014}%n%F{default}%F{006}@%F{default}%F{014}%m%F{default}'
    fi
    p_elem+='%F{006}]%F{default}'
    p_elem+=' '
    p_elem+='%F{006}[%F{default}%F{014}%6~%F{default}%F{006}]%F{default}'
    p_line+=${(j::)p_elem}

    # second line
    p_line+='%(0?.%F{034}▶%F{default}.%F{160}◀%F{default})(%y)%(!.#.») '

    # prompt
    PROMPT=${(F)p_line}
    RPROMPT='%F{242}${vcs_info_msg_1_}%F{default}'
}

