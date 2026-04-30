# Additional PATH management (if needed later)

typeset -U path

path+=(
  $HOME/.local/bin
  $HOME/Documents/Scripts
  $HOME/.spicetify
  $HOME/ios-decryptor/target/release
  $HOME/.local/share/nvim/site
)

export PATH
