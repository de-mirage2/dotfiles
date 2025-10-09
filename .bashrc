#
# ~/.bashrc
#

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:/home/de_mirage/.local/bin"
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64" # Compilation flags
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk"

export EDITOR="/usr/bin/nvim"
export MUSIC="$HOME/Music"

export FZF_DEFAULT_OPTS="--bind='ctrl-e:up' --height 40% --style full"

# fix GTK app brianrot (?)
export GDK_SCALE=1
export GDK_DPI_SCALE=1
export GTK_FONT_SCALE=1
export GTK_THEME=MacTahoe Light

# Less termcaps

# Bold text
export LESS_TERMCAP_md=$(tput bold; tput setaf 2) # Green
# End all mode like so, us, mb, md, and mr
export LESS_TERMCAP_me=$(tput sgr0)
# Start underlining
export LESS_TERMCAP_us=$(tput smul; tput setaf 4) # Blue
# End underlining
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)

###
#####
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
#####
###

eval "$(fzf --bash)"

source "$HOME/.config/bash/ps1.sh"
PS1="$(_mkps1)"

source ~/.config/git-prompt.sh

# SEP_R=$'\uE0B0'  # 
# SEP_L=$'\uE0B2'  # 
# PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")'; PS1='\[\e[38;5;23m\]${SEP_L}\[\e[38;5;159;48;5;23m\]\u\[\e[2m\]@\[\e[22m\]\h\[\e[39m\] \[\e[38;5;23;48;5;159m\]${SEP_R}\[\e[39m\] \[\e[38;5;23m\]\w\[\e[39m\] \[\e[0;38;5;159m\]${SEP_R}\[\e[0m\]${PS1_CMD1} \[\e[2m\]\$\[\e[0m\] '

alias l='lsd -lhF'
alias ls='lsd -lahF'
alias ZZ='exit'
alias n='nvim'
alias yay='paru'
alias dud='du -hd1'
alias z='zathura'
alias lt='lsd --tree'
alias lst='lsd --tree -a'
alias frg='rg -F'
alias dif='difft'
alias ff='firefox --new-tab'
alias timeBash='for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done'
alias neovimReset='rm -fr ~/.local/share/nvim ~/.local/state/nvim'

mn() {
    if [ -z "$1" ]; then
        echo "Usage: mn <command>"
        return 1
    fi
    nvim +"Man $*" +only
}

cd_to_dir() {
  if [[ -z $1 ]] then
    cd $1
  fi
  cd $(fd -t d | fzf +m --preview 'lsd --tree -a {}')
}

alias cf="cd_to_dir"

mcd() {
  mkdir -p $1 && cd $1 
}

alias nf="fd -i '.*\\.(tex|ssh|py|cpp|cs|c|lua|pl|r|rs|ts|tsx|php|js|jsx|css|html|sol|md|txt|conf|rasi|ini|json|jsonc|csv|sh|go)$' -H . | rg -vi 'put\\d\\.txt' | fzf --bind 'enter:become(nvim {})' --preview 'bat -n --color=always {}'"
alias zf="fd -i '.*\\.(pdf|djvu|epub)$' . | fzf --bind 'enter:become(zathura {})'"
alias cf="cd_to_dir"
alias mpvf="fd -i '.*\\.(mp3|mp4|ogg|flac|wav|m4a|mkv|aac|3gp|aiff|opus|webm|gifv|flv|avi|mov|wmv|m3u)$' . | fzf --bind 'enter:become(mpv {})'"
alias mpvr="mpv \$(shuf -n1 -e **/*.(flac|mp3))"

alias pls='sudo'
alias plz='sudo'

# Utility funcs
ytdl() {
  yt-dlp $1 -f "ba" -x -o "$2"
}

ytaudiostream() {
  yt-dlp -f bestaudio $1 -x -o - 2>/dev/null | ffplay -nodisp -autoexit -i - &>/dev/null
}

wavescrashing() {
  play -c 2 -n synth brownnoise synth pinknoise mix synth 0 0 0 15 40 50 trapezium amod $1 50
}

toCamel() {
  if [ -z "$1" ]; then
    echo "Usage: $0 \"Your sentence here\""
  fi

  echo "$1" \
      | tr '\n' ' ' \
      | sed 's/^[ \t]*//;s/[ \t]*$//' \
      | tr '[:upper:]' '[:lower:]' \
      | sed -E 's/[[:space:]]+/_/g' \
      | sed -E 's/[^a-z0-9_]/-/g'
}

# Git aliases (copying omz plugin)
alias g='git'
alias ga='git add'
alias gaa='git add -all'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'
alias gc='git commit --verbose'
alias gcm='git commit --verbose --message'
alias gca='git commit --verbose --all'
alias gcam='git commit --verbose --all --message'
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gms="git merge --squash"
alias gmff="git merge --ff-only"
alias gl='git pull'
alias gpr='git pull --rebase'
alias gprv='git pull --rebase -v'
alias gpra='git pull --rebase --autostash'
alias gprav='git pull --rebase --autostash -v'
alias gp='git push'
alias gpd='git push --dry-run'
alias gpv='git push --verbose'
alias gpod='git push origin --delete'
alias gr='git remote'
alias grv='git remote --verbose'
alias gra='git remote add'
alias grrm='git remote remove'
alias grmv='git remote rename'
alias grset='git remote set-url'
alias grup='git remote update'
alias grh='git reset'
alias gru='git reset --'
alias grhh='git reset --hard'
alias grhk='git reset --keep'
alias grhs='git reset --soft'
alias gpristine='git reset --hard && git clean --force -dfx'
alias gwipe='git reset --hard && git clean --force -df'

set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'






if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi
