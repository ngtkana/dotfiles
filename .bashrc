case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
if [ -f ~/.git-completion.sh ]; then
    source ~/.git-completion.sh
fi
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
fi
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
. "$HOME/.cargo/env"

eval "$(starship init bash)"
eval "$(direnv hook bash)"
export EDITOR=vim

# bashでディレクトリ移動を便利にする - Qiita
# https://qiita.com/k-takata/items/092f70f66d545cb9db7c
function cd_func () {
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
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

# # xserver
# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# rustup
source "$HOME/.cargo/env"

# cargo make
_cargo_make_completions()
{
    if [ "${#COMP_WORDS[@]}" != "2" ]; then
        return
    fi

    # add cli options
    ALL_WORDS="--allow-private --diff-steps --disable-check-for-updates --experimental -h --help --list-all-steps --no-color --no-on-error --no-workspace --print-steps -skip-init-end-tasks --time-summary -v --version -V --version --cwd -e --env --env-file -l --loglevel verbose info error --makefile --output-format default short-description markdown markdown-single-page markdown-sub-section autocomplete --output-file -p --profile --skip-tasks -t --task "

    # add task names
    ALL_WORDS=("${ALL_WORDS}$(makers --loglevel error --list-all-steps --output-format autocomplete)")

    COMPREPLY=($(compgen -W "$ALL_WORDS" -- "${COMP_WORDS[1]}"))
}

complete -F _cargo_make_completions makers

# ac-adapter-rs のドキュメントを開く
PATH_TO_AC_ADAPTER_RS=$HOME/repos/ac-adapter-rs
function updateac () {
  orig_path="${PWD}"
  cd "${PATH_TO_AC_ADAPTER_RS}"
  cargo doc
  cd "${orig_path}"
}
function openac () {
  updateac
  path_to_ac_adapter_doc=$PATH_TO_AC_ADAPTER_RS/target/doc/ac_adapter_rs/index.html
  google-chrome "${path_to_ac_adapter_doc}"
}

if [ -f "${HOME}/.bash_aliases" ]; then . "${HOME}/.bash_aliases"; fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/kana/google-cloud-sdk/path.bash.inc' ]; then . '/home/kana/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/kana/google-cloud-sdk/completion.bash.inc' ]; then . '/home/kana/google-cloud-sdk/completion.bash.inc'; fi

# xset
xset r rate 135 35

export PATH=$PATH:$HOME/.local/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# WSL
export BROWSER=wslview

# Rye
source "$HOME/.rye/env"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
. "$HOME/.cargo/env"
eval "$(pyenv virtualenv-init -)"

# deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin

# texlive
export PATH=$PATH:/usr/local/texlive/2023/bin/x86_64-linux/

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

