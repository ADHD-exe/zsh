#!/usr/bin/env zsh

# Only the bare minimum environment bootstrap

export ZDOTDIR="$HOME/.config/zsh"

# Basic PATH safety (must exist everywhere)
export PATH="$HOME/.local/bin:$PATH"
