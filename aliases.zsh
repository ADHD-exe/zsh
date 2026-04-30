#==================================FUNCTIONS========================================
#------------------------------TABLE-OF-CONTENTS------------------------------------
#...................................................................................
#
# 1. abspath
# 2. auto-ai
# 3. command_not_found_handler
# 4. _df
# 5. extract
# 6. extract_and_remove
# 7. findimg
# 8. _fuzzy_change_directory
# 9. _fuzzy_edit_search_file
# 10. _fuzzy_edit_search_file_content
# 11. _fuzzy_search_cmd_history
# 12. handle_init_error
# 13. install_from_git
# 14. no_such_file_or_directory_handler
# 15. wget_archive_and_extract

#
#===================================================================================


# ────────────────────────────────────────────────────────────────
# 1. ABSPATH
# ────────────────────────────────────────────────────────────────
abspath() {
    if [[ -d "$1" ]]; then
        (cd "$1" && pwd)
    elif [[ -f "$1" ]]; then
        if [[ "$1" == */* ]]; then
            echo "$(cd "${1%/*}" && pwd)/${1##*/}"
        else
            echo "$(pwd)/$1"
        fi
    fi
}


# ────────────────────────────────────────────────────────────────
# 2. AUTO-AI
# ────────────────────────────────────────────────────────────────
auto-ai() {
  local script="$HOME/.local/bin/auto-ai"

  if [[ ! -x "$script" ]]; then
    echo "auto-ai is not executable: $script"
    return 1
  fi

  "$script" "$@"
}


# ────────────────────────────────────────────────────────────────
# 3. COMMAND NOT FOUND HANDLER
# ────────────────────────────────────────────────────────────────
command_not_found_handler() {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf "${green}zsh${reset}: command ${purple}NOT${reset} found: ${bright}'%s'${reset}\n" "$1"

    if ! ${PM_COMMAND[@]} -h &>/dev/null; then
        return 127
    fi

    printf "${bright}Searching for packages that provide '${bright}%s${green}'...\n${reset}" "$1"

    if ! "${PM_COMMAND[@]}" fq "/usr/bin/$1"; then
        printf "${bright}${green}[ %s ]${reset} ${purple}NOT${reset} found in system or repos.\n" "$1"
        return 127
    fi

    return 127
}

# ────────────────────────────────────────────────────────────────
# 11. DUF WRAPPER
# ────────────────────────────────────────────────────────────────
_df() {
    if [[ $# -ge 1 && -e "${@: -1}" ]]; then
        duf "${@: -1}"
    else
        duf
    fi
}


# ────────────────────────────────────────────────────────────────
# 4. EXTRACT
# ────────────────────────────────────────────────────────────────
extract() {
  if [[ -z "$1" ]]; then
    echo "Usage: extract <archive>"
    return 1
  fi

  if [[ ! -f "$1" ]]; then
    echo "$1 - file does not exist"
    return 1
  fi

  case "$1" in
    *.tar.bz2) tar xvjf "$1" ;;
    *.tar.gz)  tar xvzf "$1" ;;
    *.tar.xz)  tar xvJf "$1" ;;
    *.bz2)     bunzip2 "$1" ;;
    *.rar)     unrar x -ad "$1" ;;
    *.gz)      gunzip "$1" ;;
    *.tar)     tar xvf "$1" ;;
    *.tbz2)    tar xvjf "$1" ;;
    *.tgz)     tar xvzf "$1" ;;
    *.zip)     unzip "$1" ;;
    *.Z)       uncompress "$1" ;;
    *.7z)      7z x "$1" ;;
    *.xz)      unxz "$1" ;;
    *.exe)     cabextract "$1" ;;
    *)         echo "extract: unknown format: $1" ;;
  esac
}


# ────────────────────────────────────────────────────────────────
# 5. EXTRACT AND REMOVE
# ────────────────────────────────────────────────────────────────
extract_and_remove() {
  extract "$1" && rm -f "$1"
}


# ────────────────────────────────────────────────────────────────
# 6. FINDIMG (fzf + preview)
# ────────────────────────────────────────────────────────────────
findimg() {
  local dir="${1:-.}"

  find "$dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.heic" \) \
    | fzf --preview 'kitty +kitten icat --clear --transfer-mode=file {}' \
          --preview-window=right:60%:wrap
}

# ────────────────────────────────────────────────────────────────
# 7. FZF: CHANGE DIRECTORY
# ────────────────────────────────────────────────────────────────
_fuzzy_change_directory() {
    local selected_dir

    selected_dir=$(find . -maxdepth 7 \
      \( -name .git -o -name node_modules -o -name .venv -o -name target -o -name .cache \) -prune \
      -o -type d -print 2>/dev/null \
      | fzf --height 80% --layout=reverse --cycle --preview='ls -p {}') || return

    [[ -d "$selected_dir" ]] && cd "$selected_dir"
}


# ────────────────────────────────────────────────────────────────
# 8. FZF: EDIT FILE
# ────────────────────────────────────────────────────────────────
_fuzzy_edit_search_file() {
    local file
    file=$(find . -maxdepth 5 -type f 2>/dev/null | fzf --height 80%) || return

    "${EDITOR:-vim}" "$file"
}


# ────────────────────────────────────────────────────────────────
# 9. FZF: SEARCH CONTENT
# ────────────────────────────────────────────────────────────────
_fuzzy_edit_search_file_content() {
    local file
    file=$(grep -irl "${1:-}" ./ | fzf --height 80%) || return

    "${EDITOR:-vim}" "$file"
}


# ────────────────────────────────────────────────────────────────
# 10. FZF: HISTORY SEARCH
# ────────────────────────────────────────────────────────────────
_fuzzy_search_cmd_history() {
  local selected
  selected=$(history | fzf --height 80%) || return
  print -z "${selected#* }"
}

# ────────────────────────────────────────────────────────────────
# 11. HANDLE INIT ERROR
# ────────────────────────────────────────────────────────────────
handle_init_error() {
    if [[ $? -ne 0 ]]; then
        echo "Error during initialization."
    fi
}


# ────────────────────────────────────────────────────────────────
# 12. INSTALL FROM GIT
# ────────────────────────────────────────────────────────────────
install_from_git() {
  local url="$1"
  local dir="/tmp/${url##*/}"

  git clone "$url" "$dir" || return 1
  pushd "$dir" >/dev/null || return 1

  make && sudo make install

  popd >/dev/null
  rm -rf "$dir"
}


# ────────────────────────────────────────────────────────────────
# 13. NO SUCH FILE HANDLER
# ────────────────────────────────────────────────────────────────
no_such_file_or_directory_handler() {
    local red='\e[1;31m' reset='\e[0m'
    printf "${red}zsh: no such file or directory: %s${reset}\n" "$1"
    return 127
}


# ────────────────────────────────────────────────────────────────
# 14. WGET ARCHIVE + EXTRACT
# ────────────────────────────────────────────────────────────────
wget_archive_and_extract() {
  local url="$1"
  local file="${url##*/}"

  wget "$url" -O "$file" &&
  extract "$file" &&
  rm -f "$file"
}



