### Setup ###
export DOTFILES="$HOME/dotfiles"

### Theme ###
source "$DOTFILES/rivyx.zsh-theme"

### oh-my-zsh Plugins ###
# plugins=(
#     history-substring-search
#     colored-man-pages
#     vi-mode
#     tmux
# )

### Functions ###
# ls whenever cd
cd() {
    builtin cd $@
    ls
}

# Git add all and commit with message
gaacm() {
    command git add -A && git commit -m "$1"
}

# Search all history
histag() {
    builtin history 0 | ag $@
}

### Aliases ###
# git
alias gitlg="git log --graph --decorate --all"
alias gitdag="git log --graph --format='format:%C(yellow)%h%C(reset) %C(blue)\"%an\" <%ae>%C(reset) %C(magenta)%ar%C(reset)%C(auto)%d%C(reset)%n%s' --date-order"

# dotfiles
alias zshrc="vim $DOTFILES/zshrc.zsh"
alias vimrc="vim $DOTFILES/vimrc.vim"
alias tmuxconf="vim $DOTFILES/tmux.conf"
