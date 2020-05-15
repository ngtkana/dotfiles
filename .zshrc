# git
alias glogar="git log --oneline --graph --all --remotes"
alias gc="git checkout"
alias gb="git branch"
alias gni="git"

# cargo
alias cct="cargo clippy && cargo test"
alias cc="cargo clippy"
alias ct="cargo test"
alias cr="cargo run"

# make
alias mr="make run"
alias mb="make build"
alias mp="make paste"
alias mc="make clip"
alias mte="make test"

# cxx
export CXX='g++'

# rust
RUST_BACKTRACE=1
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src/

# bat
export BAT_THEME="Monokai Extended Light"

# fast-syntax-highlighting
source ~/path/to/fsh/fast-syntax-highlighting.plugin.zsh

# PATH
export PATH="$HOME/.rbenv/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/ngtkana/.sdkman"
[[ -s "/home/ngtkana/.sdkman/bin/sdkman-init.sh" ]] && source "/home/ngtkana/.sdkman/bin/sdkman-init.sh"

# starship
eval "$(starship init zsh)"

# renv
eval "$(rbenv init -)"


# <C-w>
WORDCHARS="*?_-.[]~=&!#$%^(){}<>"
