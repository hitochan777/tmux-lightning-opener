#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BINDINGS_DIR="$CURRENT_DIR/bindings"
SCRIPTS_DIR="$CURRENT_DIR/scripts"

source $SCRIPTS_DIR/common.sh

create_warmup_window

tmux bind-key "-" run "$BINDINGS_DIR/split_window_horizontally.sh"
tmux bind-key "|" run "$BINDINGS_DIR/split_window_vertically.sh"

tmux set-hook -g session-created "run $SCRIPTS_DIR/session_created.sh"

# tmux new -s warmup_session -d # TODO: use different shell for keeping warmup panes
