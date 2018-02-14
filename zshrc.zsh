# Theme to load
# ZSH_THEME="dracula"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(
#    git
#)

#source $ZSH/oh-my-zsh.sh

# Functions
# ls whenever cd
cdcustom() {
    cd $1;
    ls;
}
alias cd="cdcustom"

# Git add all and commit with message
gaacm() {
	git add -A && git commit -m "$1"
}

alias zshrc="vim ~/dotfiles/zshrc.zsh"
alias vimrc="vim ~/dotfiles/vimrc.vim"
alias tmuxconf="vim ~/dotfiles/tmux.conf"
