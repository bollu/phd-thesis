#!/usr/bin/env bash
set -e
set -o xtrace

GITROOT=$(git rev-parse --show-toplevel)
source $GITROOT/plots/config.sh

ssh -t $SSH_HOST "bash -lc '
cd $EVAL_DIR
# make kick-the-tires
make full
'"
./copy-from-remote.sh

