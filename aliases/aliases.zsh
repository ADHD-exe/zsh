# aliases/aliases.zsh

alias yarem='yay -Rns'
alias yarep='yay -Si'
alias yareps='yay -Ss'
alias yasu='yay -Syu --noconfirm'
alias yaupd='yay -Sy'
alias yaupg='yay -Syu'

# Imported / Docker
alias dbl='docker build'
alias dcb='docker-compose build'
alias dcdn='docker-compose down'
alias dce='docker-compose exec'
alias dcin='docker container inspect'
alias dck='docker-compose kill'
alias dcl='docker-compose logs'
alias dclF='docker-compose logs -f --tail 0'
alias dclf='docker-compose logs -f'
alias dcls='docker container ls'
alias dclsa='docker container ls -a'
alias dco=docker-compose
alias dcps='docker-compose ps'
alias dcpull='docker-compose pull'
alias dcr='docker-compose run'
alias dcrestart='docker-compose restart'
alias dcrm='docker-compose rm'
alias dcstart='docker-compose start'
alias dcstop='docker-compose stop'
alias dcup='docker-compose up'
alias dcupb='docker-compose up --build'
alias dcupd='docker-compose up -d'
alias dcupdb='docker-compose up -d --build'
alias dib='docker image build'
alias dii='docker image inspect'
alias dils='docker image ls'
alias dipru='docker image prune -a'
alias dipu='docker image push'
alias dirm='docker image rm'
alias dit='docker image tag'
alias dlo='docker container logs'
alias dnc='docker network create'
alias dncn='docker network connect'
alias dndcn='docker network disconnect'
alias dni='docker network inspect'
alias dnls='docker network ls'
alias dnrm='docker network rm'
alias dpo='docker container port'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dpu='docker pull'
alias dr='docker container run'
alias drit='docker container run -it'
alias drm!='docker container rm -f'
alias drm='docker container rm'
alias drs='docker container restart'
alias dst='docker container start'
alias dsta='docker stop $(docker ps -q)'
alias dstp='docker container stop'
alias dtop='docker top'
alias dvi='docker volume inspect'
alias dvls='docker volume ls'
alias dvprune='docker volume prune'
alias dxc='docker container exec'
alias dxcit='docker container exec -it'

# Imported / Git
alias gaa='git add --all'
alias gam='git am'
alias gama='git am --abort'
alias gamc='git am --continue'
alias gams='git am --skip'
alias gamscp='git am --show-current-patch'
alias gap='git apply'
alias gapa='git add --patch'
alias gapt='git apply --3way'
alias gau='git add --update'
alias gav='git add --verbose'
alias gb='git branch'
alias gbD='git branch --delete --force'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbg='LANG=C git branch -vv | grep ": gone\]"'
alias gbgD='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '\''{print $1}'\'' | xargs git branch -D'
alias gbgd='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '\''{print $1}'\'' | xargs git branch -d'
alias gbl='git blame -w'
alias gbm='git branch --move'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsn='git bisect new'
alias gbso='git bisect old'
alias gbsr='git bisect reset'
alias gbss='git bisect start'
alias gc!='git commit --verbose --amend'
alias gcB='git checkout -B'
alias gca!='git commit --verbose --all --amend'
alias gcam='git commit --all --message'
alias gcan!='git commit --verbose --all --no-edit --amend'
alias gcann!='git commit --verbose --all --date=now --no-edit --amend'
alias gcans!='git commit --verbose --all --signoff --no-edit --amend'
alias gcas='git commit --all --signoff'
alias gcasm='git commit --all --signoff --message'
alias gcb='git checkout -b'
alias gcd='git checkout $(git_develop_branch)'
alias gcf='git config --list'
alias gcl='git clone --recurse-submodules'
alias gclean='git clean --interactive -d'
alias gclf='git clone --recursive --shallow-submodules --filter=blob:none --also-filter-submodules'
alias gcm='git checkout $(git_main_branch)'
alias gcmsg='git commit --message'
alias gcn!='git commit --verbose --no-edit --amend'
alias gcn='git commit --verbose --no-edit'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias gcount='git shortlog --summary --numbered'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcs='git commit --gpg-sign'
alias gcsm='git commit --signoff --message'
alias gcss='git commit --gpg-sign --signoff'
alias gcssm='git commit --gpg-sign --signoff --message'
alias gdca='git diff --cached'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdup='git diff @{upstream}'
alias gdw='git diff --word-diff'
alias gf='git fetch'
alias gfa='git fetch --all --tags --prune --jobs=10'
alias gfg='git ls-files | grep'
alias gfo='git fetch origin'
alias gg='git gui citool'
alias gga='git gui citool --amend'
alias ggpull='git pull origin "$(git_current_branch)"'
alias ggpur=ggu
alias ggpush='git push origin "$(git_current_branch)"'
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias ghh='git help'
alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias git-svn-dcommit-push='git svn dcommit && git push github $(git_main_branch):svntrunk'
alias gk='\gitk --all --branches &!'
alias gke='\gitk --all $(git log --walk-reflogs --pretty=%h) &!'
alias glg='git log --stat'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glgp='git log --stat --patch'
alias glo='git log --oneline --decorate'
alias glod='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
alias glods='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias glols='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
alias glp=_git_log_prettily
alias gluc='git pull upstream $(git_current_branch)'
alias glum='git pull upstream $(git_main_branch)'
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gmff='git merge --ff-only'
alias gmom='git merge origin/$(git_main_branch)'
alias gms='git merge --squash'
alias gmtl='git mergetool --no-prompt'
alias gmtlvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/$(git_main_branch)'
alias gpd='git push --dry-run'
alias gpf!='git push --force'
alias gpf='git push --force-with-lease --force-if-includes'
alias gpoat='git push origin --all && git push origin --tags'
alias gpod='git push origin --delete'
alias gpr='git pull --rebase'
alias gpra='git pull --rebase --autostash'
alias gprav='git pull --rebase --autostash -v'
alias gpristine='git reset --hard && git clean --force -dfx'
alias gprom='git pull --rebase origin $(git_main_branch)'
alias gpromi='git pull --rebase=interactive origin $(git_main_branch)'
alias gprum='git pull --rebase upstream $(git_main_branch)'
alias gprumi='git pull --rebase=interactive upstream $(git_main_branch)'
alias gprv='git pull --rebase -v'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gpsupf='git push --set-upstream origin $(git_current_branch) --force-with-lease --force-if-includes'
alias gpu='git push upstream'
alias gpv='git push --verbose'
alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbd='git rebase $(git_develop_branch)'
alias grbi='git rebase --interactive'
alias grbm='git rebase $(git_main_branch)'
alias grbo='git rebase --onto'
alias grbom='git rebase origin/$(git_main_branch)'
alias grbs='git rebase --skip'
alias grbum='git rebase upstream/$(git_main_branch)'
alias grev='git revert'
alias greva='git revert --abort'
alias grevc='git revert --continue'
alias grf='git reflog'
alias grh='git reset'
alias grhh='git reset --hard'
alias grhk='git reset --keep'
alias grhs='git reset --soft'
alias grm='git rm'
alias grmc='git rm --cached'
alias grmv='git remote rename'
alias groh='git reset origin/$(git_current_branch) --hard'
alias grrm='git remote remove'
alias grs='git restore'
alias grset='git remote set-url'
alias grss='git restore --source'
alias grst='git restore --staged'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote --verbose'
alias gsb='git status --short --branch'
alias gsd='git svn dcommit'
alias gsh='git show'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status --short'
alias gst='git status'
alias gsta='git stash push'
alias gstaa='git stash apply'
alias gstall='git stash --all'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --patch'
alias gstu='gsta --include-untracked'
alias gsu='git submodule update'
alias gsw='git switch'
alias gswc='git switch --create'
alias gswd='git switch $(git_develop_branch)'
alias gswm='git switch $(git_main_branch)'
alias gta='git tag --annotate'
alias gtl='gtl(){ git tag --sort=-v:refname -n --list "${1}*" }; noglob gtl'
alias gts='git tag --sign'
alias gtv='git tag | sort -V'
alias gunignore='git update-index --no-assume-unchanged'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'
alias gup=$'\n    print -Pu2 "%F{yellow}[oh-my-zsh] \'%F{red}gup%F{yellow}\' is a deprecated alias, using \'%F{green}gpr%F{yellow}\' instead.%f"\n    gpr'
alias gupa=$'\n    print -Pu2 "%F{yellow}[oh-my-zsh] \'%F{red}gupa%F{yellow}\' is a deprecated alias, using \'%F{green}gpra%F{yellow}\' instead.%f"\n    gpra'
alias gupav=$'\n    print -Pu2 "%F{yellow}[oh-my-zsh] \'%F{red}gupav%F{yellow}\' is a deprecated alias, using \'%F{green}gprav%F{yellow}\' instead.%f"\n    gprav'
alias gupom=$'\n    print -Pu2 "%F{yellow}[oh-my-zsh] \'%F{red}gupom%F{yellow}\' is a deprecated alias, using \'%F{green}gprom%F{yellow}\' instead.%f"\n    gprom'
alias gupomi=$'\n    print -Pu2 "%F{yellow}[oh-my-zsh] \'%F{red}gupomi%F{yellow}\' is a deprecated alias, using \'%F{green}gpromi%F{yellow}\' instead.%f"\n    gpromi'
alias gupv=$'\n    print -Pu2 "%F{yellow}[oh-my-zsh] \'%F{red}gupv%F{yellow}\' is a deprecated alias, using \'%F{green}gprv%F{yellow}\' instead.%f"\n    gprv'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias gwipe='git reset --hard && git clean --force -df'
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtls='git worktree list'
alias gwtmv='git worktree move'
alias gwtrm='git worktree remove'

# Imported / Search, history, and text
alias history='history | less -R'
alias ccat=colorize_cat
alias cless=colorize_less
alias egrep='grep -E'
alias fgrep='grep -F'
alias fsh-alias=fast-theme
alias h=history
alias history=omz_history
alias hl='history | less'
alias hs='history | grep'
alias hsi='history | grep -i'
alias man='nocorrect man'
alias run-help=man
alias su='nocorrect su'
alias sudo='nocorrect sudo'
alias urldecode='node -e "console.log(decodeURIComponent(process.argv[1]))"'
alias urlencode='node -e "console.log(encodeURIComponent(process.argv[1]))"'
alias which-command=whence
alias x=extract
alias z='zshz 2>&1'

# Imported / Local extras
alias auto-ai='python "$HOME/.local/bin/auto-ai"'
alias tb='nc termbin.com 9999'
alias al='kate ~/.config/zsh/.aliases'
# Imported / Misc
alias make='make -j8'
alias n=ninja
alias ninja='ninja -j8'
alias please=sudo
alias rcat='command cat'


OS=`echo \`uname\` | tr '[:upper:]' '[:lower:]'`
AURL="https://gist.githubusercontent.com/hightemp/5071909/raw/"
ANAME=".bash_aliases"
TMPAPATH="/tmp/$ANAME"
HOMEAPATH="~/$ANAME"

[ "$OS" = "windowsnt" ] && OS_WIN="yes"
[ "$OS" = "darwin" ]    && OS_MAC="yes"
[ "$OS" = "linux" ]     && OS_LIN="yes"

# Self-update
alias alias_update="rm -f $TMPAPATH;wget $AURL -O $TMPAPATH;mv $TMPAPATH $HOMEAPATH;source $HOMEAPATH"

# ls variants
alias la='ls -A'
alias l='ls -alFtr'
alias lsd='ls -d .*'
alias ll='ls -alF'
[ -n "$OS_LIN" ] && alias ls='ls --color=auto'
[ -n "$OS_MAC" ] && alias ls='ls -G'

# Various
alias h='history | tail'
alias hg='history | grep'
alias mvi='mv -i'
alias rmi='rm -i'
alias {ack,ak}='ack-grep'

# Directories
alias {up,..}='cd ..'

# Archives
function extract {
  if [ -z "$1" ]; then
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
  else
    if [ -f $1 ]; then
      case $1 in
        *.tar.bz2)   tar xvjf $1    ;;
        *.tar.gz)    tar xvzf $1    ;;
        *.tar.xz)    tar xvJf $1    ;;
        *.lzma)      unlzma $1      ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar x -ad $1 ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xvf $1     ;;
        *.tbz2)      tar xvjf $1    ;;
        *.tgz)       tar xvzf $1    ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *.xz)        unxz $1        ;;
        *.exe)       cabextract $1  ;;
        *)           echo "extract: '$1' - unknown archive method" ;;
      esac
    else
      echo "$1 - file does not exist"
    fi
  fi
}
alias extr='extract '
function extract_and_remove {
  extract $1
  rm -f $1
}
alias extrr='extract_and_remove '
function abspath() {
    if [ -d "$1" ]; then
        echo "$(cd $1; pwd)"
    elif [ -f "$1" ]; then
        if [[ $1 == */* ]]; then
            echo "$(cd ${1%/*}; pwd)/${1##*/}"
        else
            echo "$(pwd)/$1"
        fi
    fi
}
alias abspath="abspath "

# Rails
alias src='script/rails console'
alias srs='script/rails server'
alias rgm='rails g model'
alias rgc='rails g controller'
alias rdc='rake db:drop db:create db:migrate db:seed'
alias rrg='rake routes | grep '
alias rspecd='rspec --drb '

# Git
alias gcl='git clone '
alias gst='git status'
alias {gbra,gb}='git branch'
alias {gco,go}='git checkout'
alias {gcob,gob}='git checkout -b '
alias {gadd,ga}='git add '
alias {gcom,gc}='git commit'
alias {gpul,gl}='git pull '
alias {gpus,gh}='git push '
alias glom='git pull origin master'
alias ghom='git push origin master'
alias gg='git grep '

# Output
alias lcase="tr '[:upper:]' '[:lower:]'"
alias ucase="tr '[:lower:]' '[:upper:]'"

# System
alias df="df -h"
alias du="du -h"
[ -n "$OS_MAC" ] && alias nproc="sysctl hw.ncpu | awk '{print \$2}'"
CORES=`nproc`
JOBS=$(expr $CORES + 1)
alias make="make -j$JOBS"

function install_from_git {
  URL=$1
  DIRNAME="/tmp/${URL##*/}"
  gcl $URL $DIRNAME
  pushd $DIRNAME
  make
  sudo make install
  popd
  rm -rf $DIRNAME
}
alias ifg="install_from_git "

if [ -n "$OS_MAC" ]; then
  function free() {
    FREE_BLOCKS=$(vm_stat | grep free | awk '{ print $3 }' | sed 's/\.//')
    INACTIVE_BLOCKS=$(vm_stat | grep inactive | awk '{ print $3 }' | sed 's/\.//')
    SPECULATIVE_BLOCKS=$(vm_stat | grep speculative | awk '{ print $3 }' | sed 's/\.//')
    FREE=$((($FREE_BLOCKS+SPECULATIVE_BLOCKS)*4096/1048576))
    INACTIVE=$(($INACTIVE_BLOCKS*4096/1048576))
    TOTAL=$((($FREE+$INACTIVE)))
    echo "Free:       $FREE MB"
    echo "Inactive:   $INACTIVE MB"
    echo "Total free: $TOTAL MB"
  }
  alias free="free"
fi

# Files
alias lcf="rename 'y/A-Z/a-z/' "
alias ucf="rename 'y/a-z/A-Z/' "

# Vim
alias v='vim'

# Tmux
alias {ton,tn}='tmux set -g mode-mouse on'
alias {tof,tf}='tmux set -g mode-mouse off'

# Linux ubuntu apt/aptitude
if [ -n "$OS_LIN" ]; then
  alias aptcs='apt-cache search'
  alias apti='sudo aptitude install'
  alias aptr='sudo aptitude remove'
  alias aptre='sudo aptitude reinstall'
  alias apts='aptitude search'
  alias aptu='sudo aptitude update'
  alias aptuu='sudo aptitude update;sudo aptitude upgrade;'
fi

# Mac ports
if [ -n "$OS_MAC" ]; then
  alias brewi='brew install'
  alias brews='brew search'
  alias porti='sudo port install'
  alias ports='port search'
fi

# Grep
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

# Ruby gems
alias gemi='gem install'
alias gemre='gem reinstall'
alias gems='gem search'

# DNS
alias {hostname2ip,h2ip}='dig +short'

# Mac DHCP service
if [ -n "$OS_MAC" ]; then
  alias {dhcpup,dhcp-start}='sudo /bin/launchctl load -w /System/Library/LaunchDaemons/bootps.plist'
  alias {dhcpdn,dhcp-stop}='sudo /bin/launchctl unload -w /System/Library/LaunchDaemons/bootps.plist'
fi

# Clipboard
[ -n "$OS_MAC" ] && alias getcb='pbpaste'
[ -n "$OS_WIN" ] && alias getcb='cat /dev/clipboard'
[ -n "$OS_LIN" ] && alias getcb='xclip -o'

# Wget
alias wgetncc='wget --no-check-certificate'
alias wgetc='wget `getcb`'

function wget_archive_and_extract {
  URL=$1
  FILENAME=${URL##*/}
  wget $URL -O $FILENAME
  extract $FILENAME
  rmi $FILENAME
}
alias wgetae='wget_archive_and_extract '
alias wgetaec='wgetae getcb'

# Utils
alias sitecopy='wget -k -K -E -r -l 10 -p -N -F -nH '
alias ytmp3='youtube-dl --extract-audio --audio-format mp3 '

findimg () {
  local dir="${1:-.}"

  find "$dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.heic" \) \
    | fzf --preview 'kitty +kitten icat --clear --transfer-mode=file {}' \
          --preview-window=right:60%:wrap
}
