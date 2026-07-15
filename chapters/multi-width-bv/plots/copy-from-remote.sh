#!/usr/bin/env bash
set -e
set -o xtrace
GITROOT=$(git rev-parse --show-toplevel)
source $GITROOT/plots/config.sh

rsync -avz --progress \
  --include='*/' \
  --include='*.tex' \
  --include='*.jpg' \
  --include='*.png' \
  --include='*.pdf' \
  --exclude='*' \
  "$SSH_HOST:$EVAL_DIR/scripts/output/" \
  output/
