fzf_file_complete_with_query() {
  local line="$READLINE_LINE"
  local point="$READLINE_POINT"

  local left="${line:0:point}"
  local right="${line:point}"

  # Get the command (first word)
  local cmd="${left%% *}"

  # Get the last word being typed
  local last_word="${left##* }"
  local line_before_last_word="${left:0:${#left} - ${#last_word}}"

  # Choose file search command based on the command
  local file_list_cmd="fd ."

  if [[ "$cmd" == "mpv" ]]; then
    file_list_cmd="fd -i '.*\\.(mp3|mp4|ogg|flac|wav|m4a|mkv|aac|3gp|aiff|opus|webm|gifv|flv|avi|mov|wmv|m3u)$' ."
  fi

  if [[ "$cmd" == "z" || "$cmd" == "zathura" ]]; then
    file_list_cmd="fd -i '.*\\.(pdf|djvu|epub)$' ."
  fi

  if [[ "$cmd" == "n" || "$cmd" == "nvim" ]]; then
    file_list_cmd="fd -i '.*\\.(tex|ssh|py|java|cpp|cs|c|lua|pl|r|rs|ts|tsx|php|js|jsx|css|html|sol|md|txt|conf|rasi|ini|json|jsonc|csv|sh|go)$' -H ."
  fi

  if [[ "$cmd" == "cd" || "$cmd" == "mcd" || "$cmd" == "rd" || "$cmd" == "ls" ]]; then
    file_list_cmd="fd -t d ."
  fi

  # Run fzf with last word as query
  local selected
  selected=$(eval "$file_list_cmd" 2>/dev/null | fzf --query="$last_word" --select-1 --exit-0)

  if [[ -n "$selected" ]]; then
    # Rebuild the command line
    READLINE_LINE="${line_before_last_word}${selected}${right}"
    READLINE_POINT=${#READLINE_LINE}
  fi
}
