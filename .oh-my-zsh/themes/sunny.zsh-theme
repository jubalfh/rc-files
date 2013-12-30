#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# ZSH prompt theme
# • two lines
# • vcs info on the right prompt
# • clearly signals when run in remote shell
# • clearly indicates exit status of previous command
# • made with solarized theme in mind
#

_prompt_vcs_systems=(hg git svn)
_prompt_vcs_info="$FG[242]"
_prompt_success="$FG[034]▍$FX[reset]"
_prompt_failure="$FG[160]▍$FX[reset]"
_prompt_lbracket="$FG[006][$FX[reset]"
_prompt_rbracket="$FG[006]]$FX[reset]"
_prompt_local="$FG[014]"
_prompt_remote="$FG[003]"
_prompt_at="$FG[006]@$FX[reset]"
_prompt_path="$FG[014]%6~$FX[reset]"

if [ -n "$SSH_TTY" ]; then
    _prompt_userhost="${_prompt_remote}%n${FX[reset]}${_prompt_at}${_prompt_remote}%m${FX[reset]}"
else
    _prompt_userhost="${_prompt_local}%n${FX[reset]}${_prompt_at}${_prompt_local}%m${FX[reset]}"
fi

# Set required options.
setopt promptsubst

# Load required modules.
autoload -U add-zsh-hook
autoload -Uz vcs_info

# Add hook for calling vcs_info before each command.
add-zsh-hook precmd vcs_info

# Set vcs_info parameters.
zstyle ':vcs_info:*' enable ${_prompt_vcs_systems}
zstyle ':vcs_info:*:*' check-for-changes true # Can be slow on big repos.
zstyle ':vcs_info:*:*' unstagedstr '⁎'
zstyle ':vcs_info:*:*' stagedstr '⁑'
zstyle ':vcs_info:hg:*' get-mq true
zstyle ':vcs_info:hg:*' get-bookmarks true
zstyle ':vcs_info:*:*' actionformats "%S" "(%s)/%r at %b %u%c (%a)"
zstyle ':vcs_info:*:*' formats "%S" "(%s)/%r at %b %u%c"
zstyle ':vcs_info:*:*' nvcsformats "%~" ""

# Define prompts.
PROMPT=$'${_prompt_lbracket}${_prompt_userhost}${_prompt_rbracket} ${_prompt_lbracket}${_prompt_path}${_prompt_rbracket}\n%(0?.${_prompt_success}.${_prompt_failure})(%y)%(!.#.») '
RPROMPT="%{${_prompt_vcs_info}%}"'$vcs_info_msg_1_'"%{$FX[reset]%}"
