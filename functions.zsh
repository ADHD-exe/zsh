#==================================FUNCTIONS========================================
#------------------------------TABLE-OF-CONTENTS------------------------------------
#...................................................................................
#
# Table of contents
# 1. AUTO-AI
# 2. BAT
# 3. DUF
# 4. ERROR-HANDLER
# 5. EZA
# 6. FZF
# 
# ────────────────────────────────────────────────────────────────
# 1. AUTO-AI
# ────────────────────────────────────────────────────────────────
#  Python wrapper that automatically allows all permission questions in AI session.
auto-ai() {
  local script="$HOME/.local/bin/auto-ai"

  if [[ ! -x "$script" ]]; then
    echo "auto-ai is not executable: $script"
    return 1
  fi

  "$script" "$@"
}
#
# ────────────────────────────────────────────────────────────────
# 2.BAT
# ────────────────────────────────────────────────────────────────
#
if command -v "bat" &>/dev/null; then
    #! alias -g -- h='-h 2>&1 | bat --language=help --style=plain --paging=never --color always' # <--- this is discouraged! This conflicts with posix -h test operator
    alias -g -- --help='--help 2>&1 | bat --language=help --style=plain --paging=never --color always'
    alias cat='bat --style=plain --paging=never --color auto'
fi
#
# ────────────────────────────────────────────────────────────────
# 3. DUF
# ────────────────────────────────────────────────────────────────
#
_df() {
    if [[ $# -ge 1 && -e "${@: -1}" ]]; then
        duf "${@: -1}"
    else
        duf
    fi
}

if command -v "duf" &>/dev/null; then
    alias df='_df'
fi
#
# ────────────────────────────────────────────────────────────────
# 4. ERROR-HANDLER
# ────────────────────────────────────────────────────────────────
#
function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf "${green}zsh${reset}: command ${purple}NOT${reset} found: ${bright}'%s'${reset}\n" "$1"

    if ! ${PM_COMMAND[@]} -h &>/dev/null; then
        return 127
    fi

    printf "${bright}Searching for packages that provide '${bright}%s${green}'...\n${reset}" "${1}"

    if ! "${PM_COMMAND[@]}" fq "/usr/bin/$1"; then
        printf "${bright}${green}[ ${1} ]${reset} ${purple}NOT${reset} found in the system and no package provides it.\n"
        return 127
    else
        printf "${green}[ ${1} ] ${reset} might be provided by the above packages.\n"
        for entry in $entries; do
            # Assuming the entry already has ANSI color codes, we don't add more colors
            printf "  %s\n" "${entry}"
        done

    fi
    return 127
}

# Function to handle initialization errors
function handle_init_error {
    if [[ $? -ne 0 ]]; then
        echo "Error during initialization. Please check your configuration."
    fi
}

function no_such_file_or_directory_handler {
    local red='\e[1;31m' reset='\e[0m'
    printf "${red}zsh: no such file or directory: %s${reset}\n" "$1"
    return 127
}
#
# ────────────────────────────────────────────────────────────────
# 5. EZA
# ────────────────────────────────────────────────────────────────
#
if command -v "eza" &>/dev/null; then
    alias l='eza -lh --icons=auto' \
        ll='eza -lha --icons=auto --sort=name --group-directories-first' \
        ld='eza -lhD --icons=auto' \
        lt='eza --icons=auto --tree'
fi

#
# ────────────────────────────────────────────────────────────────
# 6. FZF
# ────────────────────────────────────────────────────────────────
# best fzf aliases ever
_fuzzy_change_directory() {
    local initial_query="$1"
    local selected_dir
    local fzf_options=('--preview=ls -p {}' '--preview-window=right:60%')
    fzf_options+=(--height "80%" --layout=reverse --preview-window right:60% --cycle)
    local max_depth=7

    if [[ -n "$initial_query" ]]; then
        fzf_options+=("--query=$initial_query")
    fi

    #type -d
    selected_dir=$(find . -maxdepth $max_depth \( -name .git -o -name node_modules -o -name .venv -o -name target -o -name .cache \) -prune -o -type d -print 2>/dev/null | fzf "${fzf_options[@]}")

    if [[ -n "$selected_dir" && -d "$selected_dir" ]]; then
        cd "$selected_dir" || return 1
    else
        return 1
    fi
}

_fuzzy_edit_search_file_content() {
    # [f]uzzy [e]dit  [s]earch [f]ile [c]ontent
    local selected_file
    local fzf_options=()
    local preview_cmd
    if command -v "bat" &>/dev/null; then
        preview_cmd=('bat --color always --style=plain --paging=never {}')
    else
        preview_cmd=('cat {}')
    fi
    fzf_options+=(--height "80%" --layout=reverse --cycle --preview-window right:60% --preview ${preview_cmd[@]})
    selected_file=$(grep -irl "${1:-}" ./ | fzf "${fzf_options[@]}")

    if [[ -n "$selected_file" ]]; then
        if command -v "$EDITOR" &>/dev/null; then
            "$EDITOR" "$selected_file"
        else
            echo "EDITOR is not specified. using vim.  (you can export EDITOR in ~/.zshrc)"
            vim "$selected_file"
        fi

    else
        echo "No file selected or search returned no results."
    fi
}

_fuzzy_edit_search_file() {
    local initial_query="$1"
    local selected_file
    local fzf_options=()
    fzf_options+=(--height "80%" --layout=reverse --preview-window right:60% --cycle)
    local max_depth=5

    if [[ -n "$initial_query" ]]; then
        fzf_options+=("--query=$initial_query")
    fi

    # -type f: only find files
    selected_file=$(find . -maxdepth $max_depth -type f 2>/dev/null | fzf "${fzf_options[@]}")

    if [[ -n "$selected_file" && -f "$selected_file" ]]; then
        if command -v "$EDITOR" &>/dev/null; then
            "$EDITOR" "$selected_file"
        else
            echo "EDITOR is not specified. using vim.  (you can export EDITOR in ~/.zshrc)"
            vim "$selected_file"
        fi
    else
        return 1
    fi
}

_fuzzy_search_cmd_history() {
  local selected
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases noglob nobash_rematch 2> /dev/null

  local fzf_query=""
  if [[ -n "$1" ]]; then
    fzf_query="--query=${(qqq)1}"
  else
    fzf_query="--query=${(qqq)LBUFFER}"
  fi

  if zmodload -F zsh/parameter p:{commands,history} 2>/dev/null && (( ${+commands[perl]} )); then
    selected="$(printf '%s\t%s\000' "${(kv)history[@]}" |
      perl -0 -ne 'if (!$seen{(/^\s*[0-9]+\**\t(.*)/s, $1)}++) { s/\n/\n\t/g; print; }' |
      FZF_DEFAULT_OPTS=$(__fzf_defaults "" "-n2..,.. --scheme=history --bind=ctrl-r:toggle-sort --wrap-sign '\t↳ ' --highlight-line ${FZF_CTRL_R_OPTS-} $fzf_query +m --read0") \
      FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd))"
  else
    selected="$(fc -rl 1 | __fzf_exec_awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' |
      FZF_DEFAULT_OPTS=$(__fzf_defaults "" "-n2..,.. --scheme=history --bind=ctrl-r:toggle-sort --wrap-sign '\t↳ ' --highlight-line ${FZF_CTRL_R_OPTS-} $fzf_query +m") \
      FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd))"
  fi
  local ret=$?
  if [ -n "$selected" ]; then
    if [[ $(__fzf_exec_awk '{print $1; exit}' <<< "$selected") =~ ^[1-9][0-9]* ]]; then
      zle vi-fetch-history -n $MATCH
    else
      LBUFFER="$selected"
    fi
  fi
  return $ret
}

# ────────────────────────────────────────────────────────────────
# 
# ────────────────────────────────────────────────────────────────
