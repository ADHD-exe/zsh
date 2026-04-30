#zprofile
#!/usr/bin/env zsh

# =========================
# XDG Base Directory Spec
# =========================
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# =========================
# History / system behavior
# =========================
export LESSHISTFILE="${LESSHISTFILE:-/tmp/less-hist}"
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"

# =========================
# Optional user dirs
# =========================
if command -v xdg-user-dir >/dev/null 2>&1; then
  export XDG_DESKTOP_DIR="$(xdg-user-dir DESKTOP)"
  export XDG_DOWNLOAD_DIR="$(xdg-user-dir DOWNLOAD)"
  export XDG_TEMPLATES_DIR="$(xdg-user-dir TEMPLATES)"
  export XDG_PUBLICSHARE_DIR="$(xdg-user-dir PUBLICSHARE)"
  export XDG_DOCUMENTS_DIR="$(xdg-user-dir DOCUMENTS)"
  export XDG_MUSIC_DIR="$(xdg-user-dir MUSIC)"
  export XDG_PICTURES_DIR="$(xdg-user-dir PICTURES)"
  export XDG_VIDEOS_DIR="$(xdg-user-dir VIDEOS)"
fi

# =========================
# App configs
# =========================
export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"

# =========================
# Hyprland
# =========================
export HYPRLAND_CONFIG="${XDG_DATA_HOME}/hypr/hyprland.conf"
