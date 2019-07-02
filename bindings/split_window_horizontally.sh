#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPTS_DIR="$CURRENT_DIR/../scripts"

source "$SCRIPTS_DIR/common.sh"

main() {
  warmup_pane_id=$(get_warmup_pane_id)
  # TODO: if pane_id is empty
  tmux join-pane -v -s $warmup_pane_id
  tmux send-keys Enter # FIXME: not working
  create_warmup_window
}

main
