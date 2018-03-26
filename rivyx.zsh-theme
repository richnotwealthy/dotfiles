# two-line prompt with git support and some nice colors to match dracula

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

if [[ $UID -eq 0 ]]; then
    local user_host='%{$fg[red]%}%n @ %m%{$reset_color%}'
    local user_symbol='∷'
else
    local user_host='%{$fg[green]%}%n @ %m%{$reset_color%}'
    # local user_symbol='λ'
    # local user_symbol='∫'
    # local user_symbol='∑'
    # local user_symbol='∆'
    # local user_symbol='»'
    local user_symbol='∵'
fi

local current_dir='%{$terminfo[bold]$fg[blue]%}%~%{$reset_color%}'
local git_branch='$(git_prompt_info)%{$reset_color%}'

PROMPT="
╭─ ${user_host} ${current_dir} ${git_branch}
╰─ ${user_symbol} "
RPS1="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_CLEAN="› %{$fg[green]%}✔"
ZSH_THEME_GIT_PROMPT_DIRTY="› %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
