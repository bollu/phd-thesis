#!/usr/bin/env bash
set -o xtrace
set -e

CONTAINER="$1"

docker cp "$CONTAINER:/code/lean-mlir/SSA/Experimental/Bits/Fast/Dataset2/mba.sqlite3" .
docker cp "$CONTAINER:/code/lean-mlir/SSA/Experimental/Bits/Fast/Dataset2/dataset2-cactus-plot-data.tex" .
docker cp "$CONTAINER:/code/lean-mlir/SSA/Experimental/Bits/Fast/Dataset2/dataset2-cactus-plot.pdf" .

docker cp "$CONTAINER:/code/lean-mlir/bv-evaluation/compare.jsonl" .
docker cp "$CONTAINER:/code/lean-mlir/bv-evaluation/automata-automata-circuit-cactus-plot-data.tex" .
docker cp "$CONTAINER:/code/lean-mlir/bv-evaluation/automata-automata-circuit-cactus-plot.pdf" .

