source ~/.config/git-prompt.sh

SEP_R=$'\uE0B0'  # 
SEP_L=$'\uE0B2'  # 

RESET=`tput sgr0`
BG_IVY=`tput setab 23`
FG_IVY=`tput setaf 23`
BG_AQU=`tput setab 159`
FG_AQU=`tput setaf 159`
DIM=`tput dim`

# if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
#     GIT_PROMPT_ONLY_IN_REPO=1
#     source "$HOME/.bash-git-prompt/gitprompt.sh"
# fi

_ps1_userhost() {
  echo "\[${FG_IVY}\]${SEP_L}\[${BG_IVY}${FG_AQU}\]\u\[${DIM}\]@\[${RESET}${BG_IVY}${FG_AQU}\]\h";
}
_ps1_workdir() {
  echo "\[${FG_IVY}${BG_AQU}\]${SEP_R} \w";
}
_ps1_git() {
  echo '\[${RESET}${FG_AQU}\]${SEP_R}\[${RESET}\]$(__git_ps1 " (%s)")';
  # echo '\[${RESET}${FG_AQU}\]${SEP_R}\[${RESET}\]$($HOME/.bash-git-prompt/gitstatus.sh)';
}
_ps1_sym() {
  echo "\[${DIM}\]\$\[${RESET}\] ";
}
_mkps1() {
  local ps1="$(_ps1_userhost) $(_ps1_workdir) $(_ps1_git) $(_ps1_sym)";
  echo "$ps1";
}

# _mkps1
