#!/usr/bin/env bash
set -euo pipefail
set -o xtrace

# Check for argument
if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <container_name_or_id>"
    echo "Hint: run 'docker container list' to see active containers."
    exit 1
fi

container="$1"

docker cp "$container":/home/user/lean-mlir/bv-evaluation/plots/ plots
cp plots/*.pdf .
docker cp "$container":/home/user/lean-mlir/bv-evaluation/performance-instcombine.tex ../performance-instcombine.tex
docker cp "$container":/home/user/lean-mlir/bv-evaluation/performance-hackersdelight.tex ../performance-hackersdelight.tex
