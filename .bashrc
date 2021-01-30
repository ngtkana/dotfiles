# Starship
eval "$(starship init bash)"

# tmux 自動起動
# https://qiita.com/ssh-1/items/a9956a74bff8254a606a
if [[ ! -n $TMUX && $- == *l* ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | $PERCOL | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
    :  # Start terminal normally
  fi
fi

# ble.sh 自動起動前半
# https://github.com/akinomyoga/ble.sh
# Add this lines at the top of .bashrc:
[[ $- == *i* ]] && source $HOME/.local/share/blesh/ble.sh --noattach

# auto lsd
# https://qiita.com/b4b4r07/items/8cf5d1c8b3fbfcf01a5d
auto_cdls() {
  if [ "$OLDPWD" != "$PWD" ]; then
    lsd --long
    OLDPWD="$PWD"
  fi
}
PROMPT_COMMAND="$PROMPT_COMMAND"$'\n'auto_cdls

# ac-adapter-rs のドキュメントを開く
function open_ac_adapter_rs() {
  orig_path="${PWD}"
  path_to_ac_adapter=$HOME/procon/ac-adapter-rs
  cd "${path_to_ac_adapter}"
  cargo doc
  cd "${orig_path}"
  path_to_ac_adapter_doc=$path_to_ac_adapter/target/doc/ac_adapter_rs/index.html
  google-chrome "${path_to_ac_adapter_doc}"
}
alias openac='open_ac_adapter_rs'

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
