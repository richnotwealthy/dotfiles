# Machine defaults (prefer .zshrc.defaults, fall back to .bashrc.defaults)
if [ -f "$HOME/.zshrc.defaults" ]; then
    source "$HOME/.zshrc.defaults"
elif [ -f "$HOME/.bashrc.defaults" ]; then
    _source_bash_defaults() {
        emulate -L sh
        shopt()    { :; }
        complete() { :; }
        bind()     { :; }
        source "$HOME/.bashrc.defaults" 2>/dev/null
    }
    _source_bash_defaults
    unfunction _source_bash_defaults
fi

export PATH=$HOME/.local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

### Setup ###
export dotfiles="$HOME/dotfiles"

### Theme ###
source "$dotfiles/theme.zsh"

### oh-my-zsh ###
COMPLETION_WAITING_DOTS="true"

plugins=(
    git
    history-substring-search
    colored-man-pages
    tmux
    colorize
    zsh-navigation-tools
)

source "$ZSH/oh-my-zsh.sh"

### Functions ###

# Git add all and commit with message
gaacm() {
    command git add -A && git commit -m "$1"
}

# Search all history
histag() {
    builtin history 0 | ag "$@"
}

### Aliases ###
# git
alias gitlg="git log --graph --decorate --all"
alias gitdag="git log --graph --format='format:%C(yellow)%h%C(reset) %C(blue)\"%an\" <%ae>%C(reset) %C(magenta)%ar%C(reset)%C(auto)%d%C(reset)%n%s' --date-order"

# dotfiles
alias zshrc="vim $dotfiles/zshrc.zsh"
alias vimrc="vim $dotfiles/vimrc.vim"
alias tmuxconf="vim $dotfiles/tmux.conf"
alias themezsh="vim $dotfiles/theme.zsh"
alias lzshrc='vim ~/.zshrc.local'

### Plugin Settings ###
# history-substring-search bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# zsh-navigation-tools display settings
znt_list_bold=0
znt_list_colorpair="15/235"
znt_list_border=1

### Startup ###
source "$dotfiles/scripts/banner.zsh"

# Local overrides (not tracked by dotfiles)
if [ -f "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi