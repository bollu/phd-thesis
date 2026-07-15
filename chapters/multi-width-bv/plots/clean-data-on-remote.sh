#!/usr/bin/env bash
set -e
set -o xtrace

GITROOT=$(git rev-parse --show-toplevel)
source $GITROOT/plots/config.sh

ssh -t $SSH_HOST "rm -r $EVAL_DIR/scripts/output/"
ssh -t $SSH_HOST "mkdir -p $EVAL_DIR/scripts/output/"
