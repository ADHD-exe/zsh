# ========================COMPLETIONS===============================

# Ctrl-R fzf completions
    if command -v fzf &>/dev/null; then
        eval "$(fzf --zsh)"
    fi

# tab completions
    if command -v hydectl &>/dev/null; then
        compdef _hydectl hydectl
        eval "$(hydectl completion zsh)"
    fi
