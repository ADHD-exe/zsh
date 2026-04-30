# completions/fzf.zsh 
# Ctrl-R fzf completions
    if command -v fzf &>/dev/null; then
        eval "$(fzf --zsh)"
    fi
