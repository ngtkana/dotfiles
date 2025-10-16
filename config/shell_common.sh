#!/bin/sh
# shell_common.sh - bash/zsh共通設定ファイル
# 各シェルの設定ファイルから読み込むための共通設定集

# =============================================================================
# 基本設定
# =============================================================================

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
# 開発ツール設定（存在チェック付き）
# =============================================================================

# Rust/Cargo環境
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# Starship プロンプト（シェル判定付き）
if command -v starship >/dev/null 2>&1; then
    if [ -n "$ZSH_VERSION" ]; then
        eval "$(starship init zsh)"
    elif [ -n "$BASH_VERSION" ]; then
        eval "$(starship init bash)"
    fi
fi

# direnv（シェル判定付き）
if command -v direnv >/dev/null 2>&1; then
    if [ -n "$ZSH_VERSION" ]; then
        eval "$(direnv hook zsh)"
    elif [ -n "$BASH_VERSION" ]; then
        eval "$(direnv hook bash)"
    fi
fi

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    \. "$NVM_DIR/nvm.sh"
fi
# NVM補完（シェル別）
if [ -s "$NVM_DIR/bash_completion" ] && [ -n "$BASH_VERSION" ]; then
    \. "$NVM_DIR/bash_completion"
fi

# Pyenv
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv >/dev/null 2>&1; then
        eval "$(pyenv init --path)"
        if [ -n "$ZSH_VERSION" ]; then
            eval "$(pyenv init -)"
            eval "$(pyenv virtualenv-init -)"
        elif [ -n "$BASH_VERSION" ]; then
            eval "$(pyenv init -)"
            eval "$(pyenv virtualenv-init -)"
        fi
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
    # macOS用パス
    texlive_path_mac="/usr/local/texlive/${texlive_year}/bin/universal-darwin"
    # Linux用パス
    texlive_path_linux="/usr/local/texlive/${texlive_year}/bin/x86_64-linux"
    
    if [ -d "$texlive_path_mac" ]; then
        export PATH="$PATH:$texlive_path_mac"
        break
    elif [ -d "$texlive_path_linux" ]; then
        export PATH="$PATH:$texlive_path_linux"
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

# Homebrew（macOS）
if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f "/usr/local/bin/brew" ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Google Cloud SDK（柔軟なパス検索）
for gcloud_path in \
    "$HOME/google-cloud-sdk" \
    "$HOME/repos/*/google-cloud-sdk" \
    "/opt/google-cloud-sdk"; do
    if [ -f "${gcloud_path}/path.bash.inc" ]; then
        . "${gcloud_path}/path.bash.inc"
        break
    fi
done

for gcloud_path in \
    "$HOME/google-cloud-sdk" \
    "$HOME/repos/*/google-cloud-sdk" \
    "/opt/google-cloud-sdk"; do
    if [ -f "${gcloud_path}/completion.bash.inc" ] && [ -n "$BASH_VERSION" ]; then
        . "${gcloud_path}/completion.bash.inc"
        break
    fi
done

# =============================================================================
# カスタム関数
# =============================================================================

# 拡張cd関数（ディレクトリスタック管理）
# 参考: https://qiita.com/k-takata/items/092f70f66d545cb9db7c
cd_func() {
    local x2 the_new_dir adir index
    local cnt

    if [ "$1" = "--" ]; then
        dirs -v
        return 0
    fi

    the_new_dir=$1
    [ -z "$1" ] && the_new_dir=$HOME

    if [ "${the_new_dir#-}" != "$the_new_dir" ]; then
        # Extract dir N from dirs
        index=${the_new_dir#-}
        [ -z "$index" ] && index=1
        adir=$(dirs +$index 2>/dev/null)
        [ -z "$adir" ] && return 1
        the_new_dir=$adir
    fi

    # '~' has to be substituted by ${HOME}
    [ "${the_new_dir#\~}" != "$the_new_dir" ] && the_new_dir="${HOME}${the_new_dir#\~}"

    # Now change to the new dir and add to the top of the stack
    pushd "${the_new_dir}" >/dev/null || return 1
    the_new_dir=$(pwd)

    # Trim down everything beyond 11th entry
    popd -n +11 2>/dev/null >/dev/null || true

    # Remove any other occurence of this dir, skipping the top of the stack
    cnt=1
    while [ $cnt -le 10 ]; do
        x2=$(dirs +${cnt} 2>/dev/null)
        [ $? -ne 0 ] && return 0
        [ "${x2#\~}" != "$x2" ] && x2="${HOME}${x2#\~}"
        if [ "${x2}" = "${the_new_dir}" ]; then
            popd -n +$cnt 2>/dev/null >/dev/null || true
            cnt=$((cnt-1))
        fi
        cnt=$((cnt+1))
    done

    return 0
}

# cdエイリアス
alias cd=cd_func

# =============================================================================
# ツール固有の設定
# =============================================================================

# cargo-make補完（cargo-makeがインストールされている場合のみ）
if command -v makers >/dev/null 2>&1; then
    # ローカルMakefileを使用するエイリアス
    makersl() {
        makers --makefile Makefile.local.toml "$@"
    }
fi
