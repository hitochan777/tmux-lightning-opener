#!/usr/bin/env bash

WINDOW_NAME=_

create_warmup_window() {
  tmux split-window -v -c '#{pane_current_path}'
  tmux break-pane -dP -n $WINDOW_NAME
}

# https://superuser.com/a/1188041
get_current_session_id() {
  for s in $(tmux list-sessions -F '#{session_name}'); do
      tmux list-panes -F '#{pane_tty} #{session_name}' -t "$s"
  done | grep "$(tty)" | awk '{print $2}' | head -1
}

get_warmup_pane_id() {
  session_id=$(get_current_session_id)
  window_id=$(tmux list-windows | grep ": ${WINDOW_NAME}" | cut -d":" -f1)
  pane_id=$(tmux list-panes -t $window_id | head -1 | cut -d":" -f1)
  echo "$session_id:$window_id.$pane_id"
}
