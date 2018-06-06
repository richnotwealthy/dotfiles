# two-line prompt with git support and some nice colors to match dracula

# enable colors
autoload -U colors && colors

# single-quote functionality
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

# check for dirty branch
function parse_git_dirty() {
    if command git diff-index --quiet HEAD 2> /dev/null; then
        echo "$VERSIONING_PROMPT_CLEAN"
    else
        echo "$VERSIONING_PROMPT_DIRTY"
    fi
}

# if in a git repo, show dirty indicator + git branch
function git_status_info() {
    local git_where="$(parse_git_branch)"
    if in_git; then
        git_where="${git_where#(refs/heads/|tags/)}"
        echo "$VERSIONING_PROMPT_PREFIX${git_where}$(parse_git_dirty)$VERSIONING_PROMPT_SUFFIX"
    fi
}

function in_hg() {
  if [[ -d .hg ]] || $(hg summary > /dev/null 2>&1); then
      echo 1
  fi
}

function hg_get_branch_name() {
    if [ $(in_hg) ]; then
        echo $(hg branch)
    fi
}

function hg_prompt_info {
    if [ $(in_hg) ]; then
        _DISPLAY=$(hg_get_branch_name)
        echo "$ZSH_PROMPT_BASE_COLOR$VERSIONING_PROMPT_PREFIX\
$ZSH_THEME_REPO_NAME_COLOR$_DISPLAY$ZSH_PROMPT_BASE_COLOR\
$ZSH_PROMPT_BASE_COLOR$(hg_dirty)$VERSIONING_PROMPT_SUFFIX$ZSH_PROMPT_BASE_COLOR"
        unset _DISPLAY
    fi
}

function hg_dirty_choose {
    if [ $(in_hg) ]; then
        hg status 2> /dev/null | command grep -Eq '^\s*[ACDIM!?L]'
        if [ $pipestatus[-1] -eq 0 ]; then
            # Grep exits with 0 when "One or more lines were selected", return "dirty".
            echo $1
        else
            # Otherwise, no lines were found, or an error occurred. Return clean.
            echo $2
        fi
    fi
}

function hg_dirty {
    hg_dirty_choose $VERSIONING_PROMPT_DIRTY $VERSIONING_PROMPT_CLEAN
}

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]] || [[ -n "$SSH_CLIENT" ]]; then
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

RPS1="%B${return_code}%b"

PROMPT="
╭─ ${user_host} ${current_dir} ${git_info}
╰─ ${user_symbol} "
