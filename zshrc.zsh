### oh-my-zsh Theme ###
# ZSH_THEME="dracula"

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
alias gitlg="git log --graph --decorate --all"
alias gitdag="git log --graph --format='format:%C(yellow)%h%C(reset) %C(blue)\"%an\" <%ae>%C(reset) %C(magenta)%ar%C(reset)%C(auto)%d%C(reset)%n%s' --date-order"

alias zshrc="vim ~/dotfiles/zshrc.zsh"
alias vimrc="vim ~/dotfiles/vimrc.vim"
alias tmuxconf="vim ~/dotfiles/tmux.conf"
