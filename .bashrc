# Starship
eval "$(starship init bash)"

# ちょっとうまく動かないのでコメントアウトで……
# # tmux 自動起動
# # https://qiita.com/ssh-1/items/a9956a74bff8254a606a
# if [[ ! -n $TMUX && $- == *l* ]]; then
#   # get the IDs
#   ID="`tmux list-sessions`"
#   if [[ -z "$ID" ]]; then
#     tmux new-session
#   fi
#   create_new_session="Create New Session"
#   ID="$ID\n${create_new_session}:"
#   ID="`echo $ID | $PERCOL | cut -d: -f1`"
#   if [[ "$ID" = "${create_new_session}" ]]; then
#     tmux new-session
#   elif [[ -n "$ID" ]]; then
#     tmux attach-session -t "$ID"
#   else
#     :  # Start terminal normally
#   fi
# fi

# ble.sh 自動起動前半
# https://github.com/akinomyoga/ble.sh
# Add this lines at the top of .bashrc:
[[ $- == *i* ]] && source $HOME/.local/share/blesh/ble.sh --noattach

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

  # Execute `lsd` (Kana added)
  lsd --almost-all

  #
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

# ac-adapter-rs のドキュメントを開く
PATH_TO_AC_ADAPTER_RS=$HOME/procon/ac-adapter-rs
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

# xset
xset r rate 135 35

# Aliases
alias ls='lsd'
alias ll='ls --long'
alias la='ls --all'
alias lla='ls --long --all'
alias lt='ls --tree'


# ble.sh 自動起動後半
# Add this line at the end of .bashrc:
[[ ${BLE_VERSION-} ]] && ble-attach
