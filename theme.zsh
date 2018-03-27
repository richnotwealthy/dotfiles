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
in_git() {
    command git rev-parse --is-inside-work-tree &> /dev/null
}

# show git branch/tag, or name-rev if on detached head
parse_git_branch() {
    (command git symbolic-ref -q HEAD || command git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# check for dirty branch
parse_git_dirty() {
    if command git diff-index --quiet HEAD 2> /dev/null; then
        echo "$VERSIONING_PROMPT_CLEAN"
    else
        echo "$VERSIONING_PROMPT_DIRTY"
    fi
}

# if in a git repo, show dirty indicator + git branch
git_status_info() {
    local git_where="$(parse_git_branch)"
    if in_git; then
        git_where="${git_where#(refs/heads/|tags/)}"
        echo "$VERSIONING_PROMPT_PREFIX${git_where}$(parse_git_dirty)$VERSIONING_PROMPT_SUFFIX"
    fi
}

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

if [[ $UID -eq 0 ]]; then
local user_host="%{$fg[red]%}%n @ %m%{$reset_color%}"
    local user_symbol="∷"
else
    local user_host="%{$fg[green]%}%n @ %m%{$reset_color%}"
    local user_symbol="∵"
fi

local current_dir="%{$fg_bold[blue]%}%~%{$reset_color%}"
local git_info='$(git_status_info)%{$reset_color%}'

RPS1="%B${return_code}%b"

PROMPT="
╭─ ${user_host} ${current_dir} ${git_info}
╰─ ${user_symbol} "
