#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BINDINGS_DIR="$CURRENT_DIR/bindings"
SCRIPTS_DIR="$CURRENT_DIR/scripts"

source $SCRIPTS_DIR/common.sh

create_warmup_window

lightning_horiz_key_option="@lightning_horiz_key"
lightning_vert_key_option="@lightning_vert_key"

get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value
  option_value=$(tmux show-option -gqv "$option")
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

lightning_horiz_key() {
  get_tmux_option "$lightning_horiz_key" "-"
}

lightning_vert_key() {
  get_tmux_option "$lightning_vert_key" "|"
}

tmux bind-key "$(lightning_horiz_key)" run "$BINDINGS_DIR/split_window_horizontally.sh"
tmux bind-key "$(lightning_vert_key)" run "$BINDINGS_DIR/split_window_vertically.sh"

tmux set-hook -g session-created "run $SCRIPTS_DIR/session_created.sh"

# tmux new -s warmup_session -d # TODO: use different shell for keeping warmup panes
