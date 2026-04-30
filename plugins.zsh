# ================================================================
# Zinit bootstrap (correct + minimal)
# ================================================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ ! -d "$ZINIT_HOME" ]]; then
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"


# ================================================================
# Prompt (fast path, no delay)
# ================================================================
zinit ice depth=1
zinit snippet "$ZDOTDIR/prompt.zsh"


# ================================================================
# Stage 0 — typing experience (must feel instant)
# ================================================================

zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait lucid
zinit light zsh-users/zsh-history-substring-search

# correct bindings (required)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


# ================================================================
# Stage 1 — completions (heavy, deferred)
# ================================================================
zinit ice wait lucid blockf

zinit light zsh-users/zsh-completions

autoload -Uz compinit
compinit -d "${ZDOTDIR:-$HOME}/.zcompdump"


# # # ================================================================
# Stage 2 — zoxide (correct + race-free)
# ================================================================
zinit ice from"gh-r" as"program" mv"zoxide* -> zoxide" \
           atload'eval "$(zoxide init zsh)"'

zinit light ajeetdsouza/zoxide
# ================================================================
# Stage 3 — QoL plugins
# ================================================================
zinit ice wait lucid
zinit light hlissner/zsh-autopair

zinit ice wait lucid
zinit light djui/alias-tips


# ================================================================
# Stage 4 — fzf integration (SAFE version)
# ================================================================
if command -v fzf >/dev/null 2>&1; then
  zinit ice wait lucid

  # use official install sources (NOT blob URLs)
  zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
  zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
fi
