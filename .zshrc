export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

# rbenv
export PATH="$HOME/.rbenv/shims:$PATH"

# go
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/go"

# node
export PATH="$HOME/.nodebrew/current/bin:$PATH"

# starship prompt
eval "$(starship init zsh)"

# ---------------------
# history
# ---------------------
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks

# ---------------------
# alias
# ---------------------
alias zshconfig="vim ~/.zshrc"
alias zshsource="source ~/.zshrc"
alias d="docker"
alias dc="docker compose"
alias dcr="docker compose run --rm"
alias dcra="docker compose run --rm app"
alias dce="docker compose exec"
alias dcea="docker compose exec app"
alias be="bundle exec"

# git: checkout default branch
gdb() {
    git branch -r | grep 'origin/HEAD' | awk '{print $NF}' | sed -e 's/origin\///g' | xargs git co
}

# ---------------------
# peco integrations
# ---------------------

# history search
function peco-history-selection() {
    BUFFER=$(history -n 1 | tail -r | awk '!a[$0]++' | peco)
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

# cdr (recent directories)
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

function peco-cdr() {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle accept-line
}
zle -N peco-cdr
bindkey '^T' peco-cdr

# git branch
function peco-git-recent-branches() {
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

# ghq
function peco-src() {
    local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# ---------------------
# local overrides (env-specific settings, tokens, etc.)
# ---------------------
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
