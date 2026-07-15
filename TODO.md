# Thesis TODO

Remaining work to finish porting the five papers into a single coherent thesis.
The build is currently green (`latexmk thesis.tex`, 188 pages, no `!` errors, no
undefined references) with Lean code highlighted via the custom Lean 4 lexer.

## Content TODOs (author notes left in the text)

These are `\sid{...}` margin notes that still need addressing:

- `chapters/floating-point/floating-point.tex:750` — `\sid{TODO: write this better}`: prose needs rewriting.
- `chapters/floating-point/floating-point.tex:890` — `\sid{TODO: link code}`: add a source link (use the `\leanlink`/`\leanlinkroot` macros defined in the chapter preamble) for the square-root closeness proof.
- `chapters/multi-width-bv/multi-width-bv.tex:1516` — `\sid{TODO: address comment on solver-time breakdown for translation vs. solving.}`
- `chapters/multi-width-bv/multi-width-bv.tex:1533` — `\sid{TODO: regenerable table in a single run with the full camera-ready script.}`
- `chapters/multi-width-bv/multi-width-bv.tex:1405` — commented-out `\sid{...}` note about modelling as uninterpreted functions; decide whether to fold into the text or drop.

## Cross-chapter consistency

- **Cross-reference style is mixed**: `\cref` (~81 uses) vs `\autoref` (~56 uses) across
  chapters. Pick one convention (cleveref `\cref`/`\Cref` is recommended) and sweep all
  chapters so cross-references read uniformly.
- **Thin chapters**: `chapters/introduction/introduction.tex` (~111 lines) and
  `chapters/future-work/future-work.tex` (~100 lines) are lighter than the paper chapters
  and need expansion/polish to read as thesis-level framing rather than stubs.
- **Redundant/duplicate macros**: audit each chapter preamble (e.g. floating-point defines
  its own Lean-link and notation macros) for macros that could move into the shared
  `macros.sty` to avoid drift.

## Minted / listings

- **`mlir` and `xdsl` environments are defined but unused** (0 `\begin{mlir}`/`\begin{xdsl}`
  in `chapters/`). Either wire them into the lean-mlir chapter where MLIR/xDSL snippets
  belong, or drop them (and the `MLIRLexer.py` registration in `.latexminted_config`).
- **`leanfootnotesize` has no explicit `style`** (unlike `lean`/`lean4` which set `style=bw`).
  Since `\usemintedstyle{vs}` was removed, it now falls back to the pygments `default`
  style. Consider adding `style=bw` for visual consistency with the other Lean blocks.
- The custom-lexer syntax is now version-guarded in `macros.sty` via
  `\@ifpackagelater{minted}{2024/06/01}` (minted 3.x uses the bare `path:Class`; older
  minted uses `customlexer`/`-x`). Only the minted-3.x path is exercised locally; verify
  the 2.x fallbacks if the CI/Overleaf toolchain uses an older minted.

## Bibliography hygiene (from `thesis.blg` warnings)

- `bhat_2025_16269885` — entry type not defined by `plainnat.bst`; fix the entry type.
- Empty required fields: `aho1985compilers` (journal), `brummayer2006local` (booktitle),
  `smtlibfpa` (institution), `fphandbook` (publisher).
- Number without volume: `bhat2026multiwidth`, `hydra`.
- There are near-duplicate Büchi entries (`Buchi-presburger`, `buchi1990weak`,
  `buchi1966symposium`); the multi-width chapter now cites `Buchi-presburger`. Consolidate
  if the others are unused.

## Verification checklist for future changes

- `latexmk -C && latexmk thesis.tex` should exit 0 with no `!` lines in `thesis.log`.
- `grep -i "didn't find a database entry" thesis.blg` should be empty.
- Spot-check that Lean code blocks render with the custom lexer (keyword token class
  `k+kn` in `_minted/*.highlight.minted` is the tell-tale of `Lean4Lexer`).
