# zmodload zsh/zprof
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="false"

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 14

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

COMPLETION_WAITING_DOTS="true"

# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# plugins=(sudo history emoji) # emoji too unoptimal
plugins=(sudo history)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_CUSTOM/plugins/zsh-vim-mode/zsh-vim-mode.plugin.zsh

export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8

# Compilation flags
export ARCHFLAGS="-arch x86_64"

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


# History aliases (copying omz plugin)
alias h='history'
alias hl='history | less'
alias hs='history | rg'
alias hsi='history | rg -i'


# Base 64 aliases (copying omz plugin)
encode64() {
    if [[ $# -eq 0 ]]; then
        cat | base64
    else
        printf '%s' $1 | base64
    fi
}

encodefile64() {
    if [[ $# -eq 0 ]]; then
        echo "You must provide a filename"
    else
        base64 $1 > $1.txt
        echo "${1}'s content encoded in base64 and saved as ${1}.txt"
    fi
}

decode64() {
    if [[ $# -eq 0 ]]; then
        cat | base64 --decode
    else
        printf '%s' $1 | base64 --decode
    fi
}
alias e64=encode64
alias ef64=encodefile64
alias d64=decode64


# Copypath aliases (copying omz plugin)
function cpath {
  # If no argument passed, use current directory
  local file="${1:-.}"

  # If argument is not an absolute path, prepend $PWD
  [[ $file = /* ]] || file="$PWD/$file"

  # Copy the absolute path without resolving symlinks
  # If clipcopy fails, exit the function with an error
  print -n "${file:a}" | clipcopy || return 1

  echo ${(%):-"%B${file:a}%b copied to clipboard."}
}

## Custom

alias -g NUL='> /dev/null 2>&1'

alias ZZ='exit'

alias zshconf="nvim ~/.zshrc"
alias omzconf="nvim ~/.oh-my-zsh"

alias yay='paru'
alias dud='du -hd1'
alias l='lsd -lhF'
alias ls='lsd -lahF'
alias lt='lsd --tree'
alias lst='lsd --tree -a'
alias frg='rg -F'
unalias ll
# alias egrep='grep -E --color=auto'
alias ff='firefox -new-tab'
alias dif='difft'
alias n='nvim'
alias nf="fd -i '.*\\.(tex|ssh|py|cpp|cs|c|lua|pl|r|rs|ts|tsx|php|js|jsx|css|html|sol|md|txt|conf|rasi|ini|json|jsonc|csv|sh|go)$' -H . | rg -vi 'put\\d\\.txt' | fzf --bind 'enter:become(nvim {})' --preview 'bat -n --color=always {}'"
alias z='zathura'
alias zf="fd -i '.*\\.(pdf|djvu|epub)$' . | fzf --bind 'enter:become(zathura {})'"
alias mpvf="fd -i '.*\\.(mp3|mp4|ogg|flac|wav|m4a|mkv|aac|3gp|aiff|opus|webm|gifv|flv|avi|mov|wmv|m3u)$' . | fzf --bind 'enter:become(mpv {})'"
alias mpvr="mpv $(shuf -n1 -e **/*.(flac|mp3))"
cd_to_dir() {
  cd $1 && cd $(fd -t d | fzf +m --preview 'lsd --tree -a {}')
}
alias cf="cd_to_dir"
mcd() {
  mkdir -p $1 && cd $1 
}
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

# fd . --extension flac --extension mp3 --extension ogg --extension m4a | fzf

unalias grep
# unalias sed
# unalias cat
# unalias diff

alias neovimReset='rm -fr ~/.local/share/nvim ~/.local/state/nvim'

alias pls='sudo'
alias plz='sudo'

#Functions
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


export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:/home/de_mirage/.local/bin"
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk"

# export CLASS_PATH="/usr/lib/jvm/java-21-openjdk"

export EDITOR="/usr/bin/nvim"
export MUSIC="$HOME/Music"

export FZF_DEFAULT_OPTS="--bind='ctrl-e:up' --height 40% --style full"

# fix GTK app brianrot (?)
export GDK_SCALE=1
export GDK_DPI_SCALE=1
export GTK_FONT_SCALE=1
export GTK_THEME=MacTahoe Light

# fix xim conflicting xcompose brainrot (still not fixed) (idk what this even does bruh)
# # export GTK_IM_MODULE="xim"
# export XMODIFIERS="@im=xim"
# # export QT_IM_MODULE="xim"
# export GTK_IM_MODULE=ibus
# export QT_IM_MODULE=ibus
# export XMODIFIERS=@im=ibus

# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - zsh)"

if uwsm check may-start; then
  exec uwsm start hyprland.desktop
fi

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
## [[ -f /home/de_mirage/.config/.dart-cli-completion/zsh-config.zsh ]] && . /home/de_mirage/.config/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

set -o vi

# skip_global_compinit=1

autoload -Uz compinit
# compinit # this snippet should make more optimal
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;



# eval "$(zoxide init zsh --cmd j)"

# Set up fzf key bindings and fuzzy completion
# source <(fzf --zsh)

# eval "$(pyenv virtualenv-init -)"

# zprof 
