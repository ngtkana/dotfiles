# lsd
alias ls="lsd -1"

# git
alias glogar="git log --oneline --graph --all --remotes"
alias gc="git checkout"
alias gb="git branch"
alias gni="git"

# man
export MANPAGER="vim -M +MANPAGER -"

# oj
alias ote='oj t -c main/main.o'

function dl() {
    if [[ -d test ]]; then
        rm -r test
    fi
    oj download $1
}

# prevent ^S
stty stop undef

# cxx
export CXX='g++'

# rust
RUST_BACKTRACE=1
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src/

# bat
export BAT_THEME="Monokai Extended Light"

# fast-syntax-highlighting
source ~/path/to/fsh/fast-syntax-highlighting.plugin.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/ngtkana/.sdkman"
[[ -s "/home/ngtkana/.sdkman/bin/sdkman-init.sh" ]] && source "/home/ngtkana/.sdkman/bin/sdkman-init.sh"

# starship
eval "$(starship init zsh)"

# renv
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"

# go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin

# PATH
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH=$PATH:$GOBIN

# <C-w>
WORDCHARS="*?_-.[]~=&!#$%^(){}<>"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ngtkana/google-cloud-sdk/path.zsh.inc' ]; then . '/home/ngtkana/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ngtkana/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/ngtkana/google-cloud-sdk/completion.zsh.inc'; fi

# 初回シェル時のみ tmux実行
if [ $SHLVL = 1 ]; then tmux; fi

# tmux を 256 色に
export TERM=xterm-256color

# dot
 export DOT_REPO="https://github.com/your_username/dotfiles.git"
 export DOT_DIR="$HOME/.dotfiles"
# fpath=($HOME/.zsh/dot $fpath)  # <- for completion
 source $HOME/.zsh/dot/dot.sh
