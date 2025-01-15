# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git archlinux sudo history emoji encode64 copypath)
autoload zmv

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

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
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias yay='paru'

alias l='lsd -lhF --color=auto'
alias ls='lsd -lahF --color=auto'
alias lt='lsd --tree'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='grep -E --color=auto'
alias diff='diff --color=auto'
alias ZZ='exit'
alias pacsize="pacman -Qui | egrep '^(Name|Installed)' | cut -f2 -d':' | paste - - | column -t | sort -nrk 2 | grep MiB | less"
alias neovimReset='rm -fr ~/.local/share/nvim ~/.local/state/nvim'

alias pls='sudo'

alias freak="echo 'im 𝓯𝓻𝓮𝓪𝓴𝔂'"
alias rosesarered="echo 'violetsareblue'"

#Functions
musicdl() {
  yt-dlp $1 -f "ba" -x -o "$2"
}

ytaudiostream() {
  yt-dlp -f bestaudio $1 -x -o - 2>/dev/null | ffplay -nodisp -autoexit -i - &>/dev/null
}

##plot2d() {
#  #strIn = $1 | sed -e 's/[^\.](\*|\/|\^)/&/g'
#  octave --eval "figure; axes('position',[0.1, 0.3, 0.8, 0.6]); x=linspace(-1, 1, 100); y=$1; plot(x,y); axis([-1,1]); hslider = uicontrol ('style', 'slider', 'Units', 'normalized', 'position', [0.1, 0.1, 0.8, 0.1], 'min', 1, 'max', 100, 'sliderstep', [0.01, 0.1], 'value', 10, 'callback', {@refreshX}); function refreshX (h, event) x=linspace(get(h,'value')*-1, get(h,'value'), floor(500*log10(1+10*get(h,'value'))));y=$1;plot(x,y);axis([get(h,'value')*-1,get(h,'value')]); end" --persist
#}
#
#plot3d() {
#  octave --eval "[x,y]=meshgrid($1,$2);mesh($1,$2,$3)" --persist
#}
#
mcd() {
  mkdir -p $1 && cd $1 
}

function myman {
    # `-t` and `-e`: run `tbl` and `eqn` on the input, for tables and equations
    # `-mandoc`: use a set of troff macros specifically for manpages
    # `-Tutf8`: output UTF-8 text rather than PostScript
    gunzip < /usr/share/man/man1/"${1}.1.gz" | groff -t -e -mandoc -Tutf8 | less
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
export XDG_MUSIC_DIR="/home/de_mirage/Music"

export ELECTRON_OZONE_PLATFORM_HINT=wayland

# Created by `pipx` on 2024-09-20 23:02:03
export PATH="$PATH:/home/de_mirage/.local/bin"

# fix GTK app brianrot
export GDK_SCALE=1
export GDK_DPI_SCALE=0.5
export GTK_FONT_SCALE=0.5
export GTK_THEME=Adwaita:dark

# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

if uwsm check may-start; then
  exec uwsm start hyprland.desktop
fi

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/de_mirage/.config/.dart-cli-completion/zsh-config.zsh ]] && . /home/de_mirage/.config/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

