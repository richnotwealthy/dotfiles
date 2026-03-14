# two-line prompt with git/hg support and some nice colors to match dracula

# enable colors
autoload -U colors && colors

# allow command substitution in prompts
setopt PROMPT_SUBST

VERSIONING_PROMPT_CLEAN=" %{$fg[green]%}✔"
VERSIONING_PROMPT_DIRTY=" %{$fg[yellow]%}✗"
VERSIONING_PROMPT_PREFIX="%{$fg[cyan]%}\ue0a0"
VERSIONING_PROMPT_SUFFIX="%{$reset_color%}"

# check if inside a git repo
function in_git() {
    command git rev-parse --is-inside-work-tree &> /dev/null
}

# show git branch/tag, or name-rev if on detached head
function parse_git_branch() {
    (command git symbolic-ref -q HEAD || command git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# check for dirty or untracked files
function parse_git_dirty() {
    if [[ -z "$(command git status --porcelain 2> /dev/null)" ]]; then
        echo "$VERSIONING_PROMPT_CLEAN"
    else
        echo "$VERSIONING_PROMPT_DIRTY"
    fi
}

# if in a git repo, show dirty indicator + git branch
function git_status_info() {
    in_git || return
    local git_where="$(parse_git_branch)"
    git_where="${git_where#(refs/heads/|tags/)}"
    echo "$VERSIONING_PROMPT_PREFIX${git_where}$(parse_git_dirty)$VERSIONING_PROMPT_SUFFIX"
}

# check if inside a mercurial repo
function in_hg() {
    command hg root &> /dev/null
}

function hg_get_branch_name() {
    command hg identify -i 2> /dev/null
}

function hg_dirty() {
    if command hg status 2> /dev/null | command grep -Eq '^\s*[ACDIM!?L]'; then
        echo "$VERSIONING_PROMPT_DIRTY"
    else
        echo "$VERSIONING_PROMPT_CLEAN"
    fi
}

function hg_prompt_info() {
    in_hg || return
    local _DISPLAY="$(hg_get_branch_name)"
    echo "$VERSIONING_PROMPT_PREFIX${_DISPLAY}$(hg_dirty)$VERSIONING_PROMPT_SUFFIX"
}

function virtualenv_prompt_info(){
    [[ -n ${VIRTUAL_ENV} ]] || return
    echo "(${VIRTUAL_ENV:t}) "
}

# disables prompt mangling in virtual_env/bin/activate
export VIRTUAL_ENV_DISABLE_PROMPT=1

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]] || [[ -n "$SSH_CONNECTION" ]]; then
    local at_symbol="%{$fg[yellow]%}@%{$reset_color%}"
else
    local at_symbol="%{$fg[green]%}@%{$reset_color%}"
fi

if [[ $UID -eq 0 ]]; then
    local user_host="%{$fg[red]%}%n ${at_symbol} %{$fg[red]%}%m%{$reset_color%}"
    local user_symbol="∷"
else
    local user_host="%{$fg[green]%}%n ${at_symbol} %{$fg[green]%}%m%{$reset_color%}"
    local user_symbol="∵"
fi

local current_dir="%{$fg_bold[blue]%}%-20<…<%~%<<%{$reset_color%}"
local git_info='$(git_status_info)$(hg_prompt_info)%{$reset_color%}'
local venv_info='%{$fg[yellow]%}$(virtualenv_prompt_info)%{$reset_color%}'

RPS1="%B${return_code}%b"

PROMPT="
╭─ ${user_host} ${venv_info}${current_dir} ${git_info}
╰─ ${user_symbol} "
