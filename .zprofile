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
# Only Run at Shell Login & Directory bootstrap
# =========================
[[ -o login ]] || return

mkdir -p \ 
  "$XDG_CONFIG_HOME" \
  "$XDG_DATA_HOME" \
  "$XDG_STATE_HOME" \
  "$XDG_STATE_HOME/less" \
  "$XDG_CACHE_HOME"
  2>/dev/null
  
# =========================
# History / system behavior
# =========================
export LESSHISTFILE="${XDG_STATE_HOME}/less/history"

# =========================
# App configs
# =========================
export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
