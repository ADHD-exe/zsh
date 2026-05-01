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
# Stage 0 — typing experience (latency critical)
# ================================================================

# Autosuggestions
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

# History substring search
zinit ice wait lucid
zinit light zsh-users/zsh-history-substring-search

# Required keybindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


# ================================================================
# Stage 1 — completions (heavy, structured)
# ================================================================
zinit ice wait lucid blockf

# Extended completions
zinit light zsh-users/zsh-completions

autoload -Uz compinit
compinit -d "${ZDOTDIR:-$HOME}/.zcompdump"


# ================================================================
# Stage 1.5 — completion UX enhancements
# ================================================================

# fzf-tab (hooks into completion system)
zinit ice wait lucid
zinit light Aloxaf/fzf-tab


# ================================================================
# Stage 2 — directory navigation
# ================================================================

# zoxide (primary)
zinit ice from"gh-r" as"program" mv"zoxide* -> zoxide" \
           atload'eval "$(zoxide init zsh)"'
zinit light ajeetdsouza/zoxide

# legacy jumper (optional, may remove later)
zinit ice wait lucid
zinit light rupa/z


# ================================================================
# Stage 3 — OMZ utility plugins
# ================================================================

zinit ice wait lucid

zinit snippet OMZP::git
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::extract
zinit snippet OMZP::dirhistory
zinit snippet OMZP::man


# ================================================================
# Stage 4 — QoL plugins
# ================================================================

zinit ice wait lucid
zinit light hlissner/zsh-autopair

zinit ice wait lucid
zinit light djui/alias-tips


# ================================================================
# Stage 5 — fzf integration (safe + official)
# ================================================================
if command -v fzf >/dev/null 2>&1; then
  zinit ice wait lucid

  zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
  zinit snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
fi


# ================================================================
# Stage 6 — syntax highlighting (MUST BE LAST)
# ================================================================

zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting
# Core plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Requested plugins
zinit light zsh-users/zsh-history-substring-search
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-completions

# OMZ plugins via snippets
zinit snippet OMZP::git
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::extract
zinit snippet OMZP::dirhistory
zinit snippet OMZP::man
