export PATH=$HOME/.rbenv/shims:$PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

# go
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/project/product"
# export GOPATH=$HOME/go↲
# export PATH=$GOPATH/bin:$PATH↲
# export GO111MODULE=on↲

# node
export PATH="$HOME/.nodebrew/current/bin:$PATH"

eval "$(starship init zsh)"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# history

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# source $ZSH/oh-my-zsh.sh

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_DISABLE_RPROMPT=true

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# alias
#
alias zshconfig="vim ~/.zshrc"
alias zshsource="source ~/.zshrc"
alias d="docker"
alias dc="docker-compose"
alias dcr="docker-compose run --rm"
alias dcra="docker-compose run --rm app"
alias dce="docker-compose exec"
alias dcea="docker-compose exec app"
alias be="bundle exec"
gdb() {
    git branch -r | grep 'origin/HEAD' | awk '{print $NF}' | sed -e 's/origin\///g' | xargs git co
}

# history search * peco
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# cdr * peco
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

function peco-cdr () {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle accept-line
}
zle -N peco-cdr
bindkey '^T' peco-cdr

# git branch * peco
function peco-git-recent-branches () {
    local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | \
        perl -pne 's{^refs/heads/}{}' | \
        peco)
    if [ -n "$selected_branch" ]; then
        BUFFER="git checkout ${selected_branch}"
        zle accept-line
    fi
    zle accept-line
}
zle -N peco-git-recent-branches
bindkey "^b" peco-git-recent-branches

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# ghq * peco
function peco-src () {
    local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src
