#!/usr/bin/env bash
set -o xtrace
set -e
clang -S -O3 -emit-llvm -mllvm -disable-llvm-optzns for.c -o for.temp.ll
opt-15 -mem2reg -instcombine  -instnamer for.temp.ll -S -o for.ll
rm for.temp.ll

# clang -S -emit-llvm -O0 for.c -o for.ll

