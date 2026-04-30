# Powerlevel10k instant prompt must stay near the top of the file.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM=kitty

# Plugins / prompt / core config
for f in $ZDOTDIR/*.zsh(.N); do
  source "$f"
done

# Functions
for f in $ZDOTDIR/functions/*.zsh(.N); do
  source "$f"
done

# Completions
for f in $ZDOTDIR/completions/*.zsh(.N); do
  source "$f"
done

# Aliases
source $ZDOTDIR/aliases/aliases.zsh

# Avoid passing empty X11 variables to tools like pacman/GPGME on Wayland.
[[ -v DISPLAY && -z $DISPLAY ]] && unset DISPLAY
[[ -v XAUTHORITY && -z $XAUTHORITY ]] && unset XAUTHORITY

# Core Oh My Zsh setup.
ZSH=/usr/share/oh-my-zsh/
COMPLETION_WAITING_DOTS="true"

plugins=(
  alias-finder
  aliases
  archlinux
  colorize
  colored-man-pages
  command-not-found
  dirhistory
  docker
  docker-compose
  extract
  fast-syntax-highlighting
  fzf
  git
  history
  history-substring-search
  man
  sudo
  urltools
  you-should-use
  z
  zsh-autosuggestions
  zsh-bat
  zsh-interactive-cd
)

# Inline suggestions while typing plus normal Tab completion.
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
LISTMAX=100
zic_custom_binding='^X^I'

# Completion system
autoload -Uz compinit
compinit -d "$ZDOTDIR/zcompdump/.zcompdump"

# Cache directory for Oh My Zsh.
ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir -p "$ZSH_CACHE_DIR"
fi

source "$ZSH/oh-my-zsh.sh"
source /usr/share/cachyos-zsh-config/cachyos-config.zsh
bindkey '^I' complete-word


if [[ -d ~/.config/zsh ]]; then
  for file in ~/.config/zsh/*.zsh; do
    [[ -r "$file" ]] && source "$file"
  done
fi

# Shell integrations.
# The Oh My Zsh `fzf` plugin already handles fzf integration.
# Avoid sourcing `fzf --zsh` here because it overrides Tab with `fzf-completion`.

# History.
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Editor preference.
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='code'
fi

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

# Prompt theme.
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
[[ -f ~/.config/zsh/.p10k.zsh ]] && source ~/.config/zsh/.p10k.zsh

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


export PATH="$HOME/Documents/Scripts:$PATH"
export FZF_CTRL_R_OPTS='--preview "echo {}"'

# Managed aliases live in one file. Clear those names first so disabled entries
# stay disabled even if plugins or system snippets defined them earlier.
if [[ -r ~/.config/zsh/aliases/aliases.zsh ]]; then
  while IFS= read -r alias_name; do
    unalias -- "$alias_name" 2>/dev/null || true
  done < <(
    awk '
      /^[[:space:]]*#?[[:space:]]*alias[[:space:]]+(--[[:space:]]+)?[A-Za-z0-9_.!-]+=/ {
        line = $0
        sub(/^[[:space:]]*#?[[:space:]]*alias[[:space:]]+/, "", line)
        sub(/^--[[:space:]]+/, "", line)
        sub(/=.*/, "", line)
        print line
      }
    ' ~/.config/zsh/aliases/aliases.zsh
  )


fi

if [[ -o interactive && -f ~/.zsh-banner ]]; then
  source ~/.config/zsh/.zsh-banner
fi

