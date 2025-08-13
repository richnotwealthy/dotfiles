# copy this via
# cp init-local-zshrc.zsh ~/.zshrc

source "$HOME/dotfiles/zshrc.zsh"
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

### oh-my-zsh Plugins ###
plugins=(
    git
    history-substring-search
    colored-man-pages
    vi-mode
    tmux
    macos
    colorize
    mercurial
    zsh-navigation-tools
)

znt_list_bold=0
znt_list_colorpair="15/235"
znt_list_border=1
