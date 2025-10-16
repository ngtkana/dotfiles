#!/bin/bash
# bashrc_base.bash - bash専用設定ファイル
# 各ホストの .bashrc から読み込むためのbash設定集

# =============================================================================
# インタラクティブシェルチェック
# =============================================================================

# インタラクティブシェルでない場合は何もしない
case $- in
*i*) ;;
*) return ;;
esac

# =============================================================================
# bash基本設定
# =============================================================================

# 履歴設定
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=20000

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
# bash固有の補完設定
# =============================================================================

# cargo-make bash補完（cargo-makeがインストールされている場合のみ）
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
fi

# =============================================================================
# 共通設定の読み込み
# =============================================================================

# 共通設定ファイルの読み込み
SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
if [ -f "$SCRIPT_DIR/shell_common.sh" ]; then
    source "$SCRIPT_DIR/shell_common.sh"
fi
