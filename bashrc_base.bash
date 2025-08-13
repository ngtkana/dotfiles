#!/bin/bash
# bashrc_base.bash - 共通bash設定ファイル
# 各ホストの .bashrc から読み込むための安全な設定集

# =============================================================================
# 基本設定（どの環境でも安全）
# =============================================================================

# インタラクティブシェルでない場合は何もしない
case $- in
*i*) ;;
*) return ;;
esac

# 履歴設定
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# エディタ設定
export EDITOR=vim

# =============================================================================
# GUI環境依存の設定
# =============================================================================

# X11環境でのキーリピート設定（GUI環境でのみ実行）
if [ -n "$DISPLAY" ] && command -v xset >/dev/null 2>&1; then
    xset r rate 135 35 2>/dev/null || true
fi

# =============================================================================
# システム補完とプロンプト設定
# =============================================================================

# lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# debian_chroot
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Git補完とプロンプト
if [ -f ~/.git-completion.sh ]; then
    source ~/.git-completion.sh
fi
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
    # Git プロンプト設定
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWUPSTREAM=auto
fi

# bash補完
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# =============================================================================
# 開発ツール設定（存在チェック付き）
# =============================================================================

# Rust/Cargo環境
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi

# Starship プロンプト
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

# direnv
if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook bash)"
fi

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    \. "$NVM_DIR/nvm.sh"
fi
if [ -s "$NVM_DIR/bash_completion" ]; then
    \. "$NVM_DIR/bash_completion"
fi

# Pyenv
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv >/dev/null 2>&1; then
        eval "$(pyenv init --path)"
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    fi
fi

# =============================================================================
# パス設定（存在チェック付き）
# =============================================================================

# Deno
if [ -d "$HOME/.deno" ]; then
    export DENO_INSTALL="$HOME/.deno"
    export PATH="$DENO_INSTALL/bin:$PATH"
fi

# Go
if [ -d "/usr/local/go/bin" ]; then
    export PATH="$PATH:/usr/local/go/bin"
fi
if [ -d "$HOME/go/bin" ]; then
    export PATH="$PATH:$HOME/go/bin"
fi

# TeX Live（複数のバージョンに対応）
for texlive_year in 2024 2023 2022; do
    texlive_path="/usr/local/texlive/${texlive_year}/bin/x86_64-linux"
    if [ -d "$texlive_path" ]; then
        export PATH="$PATH:$texlive_path"
        break
    fi
done

# ローカルインストール用パス
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.local/lib" ]; then
    export LD_LIBRARY_PATH="$HOME/.local/lib:$HOME/.local/lib64:${LD_LIBRARY_PATH}"
    export CMAKE_PREFIX_PATH="$HOME/.local:$CMAKE_PREFIX_PATH"
    export PKG_CONFIG_PATH="$HOME/.local/lib/pkgconfig:$HOME/.local/lib64/pkgconfig:$PKG_CONFIG_PATH"
fi

# Google Cloud SDK（柔軟なパス検索）
for gcloud_path in \
    "$HOME/google-cloud-sdk" \
    "$HOME/repos/*/google-cloud-sdk" \
    "/opt/google-cloud-sdk"; do
    if [ -f "${gcloud_path}/path.bash.inc" ]; then
        source "${gcloud_path}/path.bash.inc"
        break
    fi
done

for gcloud_path in \
    "$HOME/google-cloud-sdk" \
    "$HOME/repos/*/google-cloud-sdk" \
    "/opt/google-cloud-sdk"; do
    if [ -f "${gcloud_path}/completion.bash.inc" ]; then
        source "${gcloud_path}/completion.bash.inc"
        break
    fi
done

# =============================================================================
# カスタム関数とエイリアス
# =============================================================================

# 拡張cd関数（ディレクトリスタック管理）
# 参考: https://qiita.com/k-takata/items/092f70f66d545cb9db7c
function cd_func() {
    local x2 the_new_dir adir index
    local -i cnt

    if [[ $1 == "--" ]]; then
        dirs -v
        return 0
    fi

    the_new_dir=$1
    [[ -z $1 ]] && the_new_dir=$HOME

    if [[ ${the_new_dir:0:1} == '-' ]]; then
        # Extract dir N from dirs
        index=${the_new_dir:1}
        [[ -z $index ]] && index=1
        adir=$(dirs +$index)
        [[ -z $adir ]] && return 1
        the_new_dir=$adir
    fi

    # '~' has to be substituted by ${HOME}
    [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

    # Now change to the new dir and add to the top of the stack
    pushd "${the_new_dir}" >/dev/null
    [[ $? -ne 0 ]] && return 1
    the_new_dir=$(pwd)

    # Trim down everything beyond 11th entry
    popd -n +11 2>/dev/null 1>/dev/null

    # Remove any other occurence of this dir, skipping the top of the stack
    for ((cnt = 1; cnt <= 10; cnt++)); do
        x2=$(dirs +${cnt} 2>/dev/null)
        [[ $? -ne 0 ]] && return 0
        [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
        if [[ "${x2}" == "${the_new_dir}" ]]; then
            popd -n +$cnt 2>/dev/null 1>/dev/null
            cnt=cnt-1
        fi
    done

    return 0
}
alias cd=cd_func

# =============================================================================
# ツール固有の設定
# =============================================================================

# cargo-make補完（cargo-makeがインストールされている場合のみ）
if command -v makers >/dev/null 2>&1; then
    _cargo_make_completions() {
        if [ "${#COMP_WORDS[@]}" != "2" ]; then
            return
        fi

        # add cli options
        ALL_WORDS="--allow-private --diff-steps --disable-check-for-updates --experimental -h --help --list-all-steps --no-color --no-on-error --no-workspace --print-steps -skip-init-end-tasks --time-summary -v --version -V --version --cwd -e --env --env-file -l --loglevel verbose info error --makefile --output-format default short-description markdown markdown-single-page markdown-sub-section autocomplete --output-file -p --profile --skip-tasks -t --task "

        # add task names
        ALL_WORDS=("${ALL_WORDS}$(makers --loglevel error --list-all-steps --output-format autocomplete 2>/dev/null)")

        COMPREPLY=($(compgen -W "$ALL_WORDS" -- "${COMP_WORDS[1]}"))
    }

    complete -F _cargo_make_completions makers

    # ローカルMakefileを使用するエイリアス
    makersl() {
        makers --makefile Makefile.local.toml "$@"
    }
fi
