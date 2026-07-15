#!/usr/bin/env bash
set -e
set -o xtrace

GITROOT=$(git rev-parse --show-toplevel)
source $GITROOT/plots/config.sh

ssh -t $SSH_HOST "bash -lc '
cd $EVAL_DIR
source .venv/bin/activate
./run-on-container.sh
'"
./copy-from-remote.sh

