#!/bin/zsh
# zshrc_base.zsh - zsh専用設定ファイル
# 各ホストの .zshrc から読み込むためのzsh設定集

# =============================================================================
# インタラクティブシェルチェック
# =============================================================================

# インタラクティブシェルでない場合は何もしない
[[ $- != *i* ]] && return

# =============================================================================
# zsh基本設定
# =============================================================================

# 履歴設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS          # 重複するコマンドは履歴に保存しない
setopt HIST_IGNORE_ALL_DUPS      # 履歴中の重複行をすべて削除
setopt HIST_IGNORE_SPACE         # スペースで始まるコマンドは履歴に保存しない
setopt HIST_FIND_NO_DUPS         # 履歴検索で重複を表示しない
setopt HIST_REDUCE_BLANKS        # 余分なスペースを削除
setopt HIST_SAVE_NO_DUPS         # 履歴ファイルに重複を保存しない
setopt SHARE_HISTORY             # 履歴をプロセス間で共有
setopt APPEND_HISTORY            # 履歴を追記
setopt INC_APPEND_HISTORY        # コマンド実行時に履歴をすぐに追記

# ディレクトリ操作
setopt AUTO_CD                   # ディレクトリ名だけでcd
setopt AUTO_PUSHD                # cdでpushdを自動実行
setopt PUSHD_IGNORE_DUPS         # pushdで重複ディレクトリを無視

# 補完設定
setopt AUTO_MENU                 # TAB連打で補完候補を順次表示
setopt AUTO_LIST                 # 補完候補を一覧表示
setopt LIST_PACKED               # 補完候補をできるだけ詰めて表示
setopt LIST_TYPES                # 補完候補にファイルタイプを表示
setopt COMPLETE_IN_WORD          # 単語の途中でも補完

# その他の便利なオプション
setopt CORRECT                   # コマンドのスペルチェック
setopt NO_BEEP                   # ビープ音を無効
setopt PROMPT_SUBST              # プロンプトで変数展開
setopt EXTENDED_GLOB             # 拡張グロブ
setopt NUMERIC_GLOB_SORT         # 数値順ソート

# =============================================================================
# zsh補完システム
# =============================================================================

# 補完システムの初期化
autoload -Uz compinit
compinit

# 補完スタイル設定
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # 大文字小文字を区別しない
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}  # ファイル補完で色を使う
zstyle ':completion:*' menu select  # 補完候補をメニューで選択
zstyle ':completion:*:default' menu select=2  # 補完候補が2つ以上の場合メニュー表示

# Git補完
if [[ -f /usr/local/share/zsh/site-functions/_git ]]; then
    fpath=(/usr/local/share/zsh/site-functions $fpath)
elif [[ -f /opt/homebrew/share/zsh/site-functions/_git ]]; then
    fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
fi

# =============================================================================
# キーバインド
# =============================================================================

# Emacsキーバインド
bindkey -e

# 履歴検索
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

# 単語移動（Option + 矢印キー for macOS）
bindkey '^[[1;3C' forward-word      # Option + Right
bindkey '^[[1;3D' backward-word     # Option + Left

# =============================================================================
# lesspipe設定
# =============================================================================

# lesspipe（macOS/Linux対応）
if command -v lesspipe >/dev/null 2>&1; then
    eval "$(SHELL=/bin/sh lesspipe)"
elif command -v lesspipe.sh >/dev/null 2>&1; then
    eval "$(lesspipe.sh)"
fi

# =============================================================================
# debian_chroot設定
# =============================================================================

if [[ -z "${debian_chroot:-}" ]] && [[ -r /etc/debian_chroot ]]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# =============================================================================
# zsh固有の補完設定
# =============================================================================

# Homebrew補完（macOS）
if [[ -d "/opt/homebrew/share/zsh/site-functions" ]]; then
    fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
elif [[ -d "/usr/local/share/zsh/site-functions" ]]; then
    fpath=(/usr/local/share/zsh/site-functions $fpath)
fi

# NVM zsh補完
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    # zsh用のNVM補完を設定
    autoload -U add-zsh-hook
    load-nvmrc() {
        local node_version="$(nvm version)"
        local nvmrc_path="$(nvm_find_nvmrc)"

        if [[ -n "$nvmrc_path" ]]; then
            local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

            if [[ "$nvmrc_node_version" = "N/A" ]]; then
                nvm install
            elif [[ "$nvmrc_node_version" != "$node_version" ]]; then
                nvm use
            fi
        elif [[ "$node_version" != "$(nvm version default)" ]]; then
            echo "Reverting to nvm default version"
            nvm use default
        fi
    }
    add-zsh-hook chpwd load-nvmrc
    load-nvmrc
fi

# cargo-make zsh補完
if command -v makers >/dev/null 2>&1; then
    _cargo_make_completions() {
        local context state line
        typeset -A opt_args

        _arguments \
            '--allow-private[Allow private tasks]' \
            '--diff-steps[Show diff for each step]' \
            '--disable-check-for-updates[Disable update check]' \
            '--experimental[Enable experimental features]' \
            '(-h --help)'{-h,--help}'[Show help]' \
            '--list-all-steps[List all available steps]' \
            '--no-color[Disable colored output]' \
            '--no-on-error[Disable on-error flow]' \
            '--no-workspace[Disable workspace support]' \
            '--print-steps[Print steps]' \
            '--skip-init-end-tasks[Skip init and end tasks]' \
            '--time-summary[Show time summary]' \
            '(-v --version -V)'{-v,--version,-V}'[Show version]' \
            '--cwd[Set working directory]:directory:_directories' \
            '(-e --env)'{-e,--env}'[Set environment variable]:env:' \
            '--env-file[Load environment from file]:file:_files' \
            '(-l --loglevel)'{-l,--loglevel}'[Set log level]:(verbose info error)' \
            '--makefile[Specify makefile]:file:_files' \
            '--output-format[Set output format]:(default short-description markdown markdown-single-page markdown-sub-section autocomplete)' \
            '--output-file[Set output file]:file:_files' \
            '(-p --profile)'{-p,--profile}'[Set profile]:profile:' \
            '--skip-tasks[Skip tasks]:tasks:' \
            '(-t --task)'{-t,--task}'[Run specific task]:task:_cargo_make_tasks'

        return 0
    }

    _cargo_make_tasks() {
        local tasks
        tasks=(${(f)"$(makers --loglevel error --list-all-steps --output-format autocomplete 2>/dev/null)"})
        _describe 'tasks' tasks
    }

    compdef _cargo_make_completions makers
fi

# =============================================================================
# 共通設定の読み込み
# =============================================================================

# 共通設定ファイルの読み込み
SCRIPT_DIR="$(dirname "${(%):-%N}")"
if [[ -f "$SCRIPT_DIR/shell_common.sh" ]]; then
    source "$SCRIPT_DIR/shell_common.sh"
fi
