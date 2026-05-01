# ================================================================
# ZSHRC
# ================================================================

typeset -U path
export TERM=kitty
bindkey '^I' complete-word


# Sources
source $ZDOTDIR/env/xdg.zsh
source $ZDOTDIR/env/paths.zsh
source $ZDOTDIR/plugins/plugins.zsh
source $ZDOTDIR/functions/functions.zsh
source $ZDOTDIR/aliases/aliases.zsh
source $ZDOTDIR/.zprompt
source $ZDOTDIR/.zprofile
#source $ZDOTDIR/.zlogin
#source $ZDOTDIR/.zlogout

# Prompt starship
eval "$(starship init zsh)"

# Avoid passing empty X11 variables to tools like pacman/GPGME on Wayland.
[[ -v DISPLAY && -z $DISPLAY ]] && unset DISPLAY
[[ -v XAUTHORITY && -z $XAUTHORITY ]] && unset XAUTHORITY


# Inline suggestions while typing plus normal Tab completion.
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
LISTMAX=25
zic_custom_binding='^X^I'

# Completion system
autoload -Uz compinit
compinit -d "$ZDOTDIR/zcompdump/.zcompdump"

if [[ -d ~/.config/zsh ]]; then
  for file in ~/.config/zsh/*.zsh; do
    [[ -r "$file" ]] && source "$file"
  done
fi


# History.
HISTFILE=~/.config/zsh/history/zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory


# Environment.
path+=(
  ~/.spicetify
  /home/rabbit/ios-decryptor/target/release
  /home/rabbit/.local/bin
  /home/rabbit/Documents/Scripts
)

export QT_MEDIA_BACKEND=gstreamer
export LIBVA_DRIVER_NAME=iHD
export GST_VAAPI_ALL_DRIVERS=1
export GST_PLUGIN_FEATURE_RANK="vaapi:MAX"

# Editor preference.
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Pacman helpers.
paccull() {
  echo "==> Orphans:"
  pacman -Qdt || true
  echo
  echo "==> Removing orphans..."
  sudo pacman -Rns $(pacman -Qdtq 2>/dev/null) 2>/dev/null || true
  echo
  echo "==> Cleaning cache..."
  sudo pacman -Sc
}

if command -v reflector >/dev/null 2>&1; then
  mirrorrefresh() {
    sudo reflector --latest 30 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
  }
fi

# Wayland / desktop helpers.
wb() {
  pkill waybar || true
  waybar >/dev/null 2>&1 &
  disown
}

wbr() {
  pkill waybar || true
  sleep 0.2
  waybar >/dev/null 2>&1 &
  disown
}

ssfull() {
  grim - | wl-copy
  echo "📸 Fullscreen screenshot copied to clipboard."
}

sssel() {
  grim -g $(slurp) - | wl-copy
  echo "📸 Selection screenshot copied to clipboard."
}

ssedit() {
  grim -g $(slurp) - | swappy -f -
}

ssfile() {
  local dir="$HOME/Pictures/Screenshots"
  mkdir -p "$dir"
  local file="$dir/$(date "+%Y-%m-%d_%H-%M-%S").png"
  grim -g $(slurp) "$file"
  echo "📸 Saved: $file"
}


export FZF_CTRL_R_OPTS='--preview "echo {}"'


if [[ -o interactive && -f ~/.config/zsh/banner.zsh ]]; then
  source ~/.config/zsh/banner.zsh
fi
