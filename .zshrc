export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick when ZSH_THEME=random
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="false"

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 14

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load?
# Standard and custom plugins found in $ZSH/plugins/ and $ZSH_CUSTOM/plugins/

plugins=(sudo history emoji)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_CUSTOM/plugins/zsh-vim-mode/zsh-vim-mode.plugin.zsh

# User configuration

export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Personal Keybinds
#bindkey -r "^E"
#bindkey "^E" edit-command-line
#bindkey -r "^I"
#bindkey "^I" end-of-line
#bindkey -r "^F"
#bindkey "^F" forward-word
#bindkey -r "^B"
#bindkey "^B" backward-word
#
#bindkey -r '^[[1;5C'
#bindkey '^[[1;5C' autosuggest-accept
#bindkey -r '^[[1;5D'
#bindkey '^[[1;5D' expand-or-complete
#bindkey '\t' expand-or-complete


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
alias frg='rg -F'
# alias egrep='grep -E --color=auto'
alias dif='difft'

unalias grep
# unalias sed
# unalias cat
# unalias diff

alias neovimReset='rm -fr ~/.local/share/nvim ~/.local/state/nvim'

alias pls='sudo'
alias plz='sudo'

alias freak="echo 'im 𝓯𝓻𝓮𝓪𝓴𝔂'"
alias rosesarered="echo 'violetsareblue'"

#Functions
ytdl() {
  yt-dlp $1 -f "ba" -x -o "$2"
}

ytaudiostream() {
  yt-dlp -f bestaudio $1 -x -o - 2>/dev/null | ffplay -nodisp -autoexit -i - &>/dev/null
}

mcd() {
  mkdir -p $1 && cd $1 
}

wavescrashing() {
  play -c 2 -n synth brownnoise synth pinknoise mix synth 0 0 0 15 40 50 trapezium amod $1 50
}

export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

export PATH="$HOME/.cargo/bin:$PATH"
export EDITOR="/usr/bin/nvim"
# export XDG_MUSIC_DIR="$HOME/Music" # UNCOMMENT IF SOMETHING BREAKS
export MUSIC="$HOME/Music"

export ELECTRON_OZONE_PLATFORM_HINT=wayland

# Created by `pipx` on 2024-09-20 23:02:03
export PATH="$PATH:/home/de_mirage/.local/bin"

# fix GTK app brianrot
export GDK_SCALE=1
export GDK_DPI_SCALE=1
export GTK_FONT_SCALE=1
export GTK_THEME=Adwaita:dark

# fix xim conflicting xcompose brainrot (still not fixed)
export GTK_IM_MODULE="xim"
export XMODIFIERS="@im=xim"
export QT_IM_MODULE="xim"

# fix zsh suggesting that neovim should edit an executable/song when it really shouldn't (not fixed)
function nv() {
  nvim "$@"
}
_nv() {
  _files -g '^(*.mp3|*.ogg|*.flac|*.wav|*.exe|*.out|*.bin|*.a|*.so|*.o|*.mod|*.png|*.jpg|*.jpeg)(.)'
}
compdef _nv nv

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

if uwsm check may-start; then
  exec uwsm start hyprland.desktop
fi

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
## [[ -f /home/de_mirage/.config/.dart-cli-completion/zsh-config.zsh ]] && . /home/de_mirage/.config/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

set -o vi

autoload -Uz compinit
compinit

eval "$(zoxide init zsh --cmd j)"

# eval "$(pyenv virtualenv-init -)"
