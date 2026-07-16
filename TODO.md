# Thesis TODO

Remaining work to finish porting the five papers into a single coherent thesis.
The build is currently green (`latexmk thesis.tex`, no `!` errors, no undefined
references) with Lean code highlighted via the custom Lean 4 lexer.

## Content TODOs (author notes left in the text)

These are `\sid{...}` margin notes that still need addressing:

- `chapters/floating-point/floating-point.tex:750` — `\sid{TODO: write this better}`: prose needs rewriting.
- `chapters/floating-point/floating-point.tex:890` — `\sid{TODO: link code}`: add a source link (use the `\leanlink`/`\leanlinkroot` macros defined in the chapter preamble) for the square-root closeness proof.
- `chapters/parametric-bv/parametric-bv.tex:2852` — `\sid{TODO: address comment on solver-time breakdown for translation vs. solving.}`
- `chapters/parametric-bv/parametric-bv.tex:2869` — `\sid{TODO: regenerable table in a single run with the full camera-ready script.}`
- `chapters/parametric-bv/parametric-bv.tex:2741` — commented-out `\sid{...}` note about modelling as uninterpreted functions; decide whether to fold into the text or drop.

## Chapter merge follow-ups (parametric-bv)

The former `single-width-bv` and `multi-width-bv` chapters are now one chapter,
`chapters/parametric-bv/parametric-bv.tex` (§4.1 + §4.2, merged Related Work/Conclusions).
- **Asset folders not yet relocated**: `chapters/single-width-bv/` and
  `chapters/multi-width-bv/` now hold only `images/`+`plots/` (their `.tex` was removed).
  Paths are root-relative so the build works, but the folders should be moved under
  `chapters/parametric-bv/` and the `\input`/`\includegraphics` paths updated for tidiness.
- **`mwbv:fig:pipeline` converted from `wrapfigure` to a `figure` float** (the tall
  `[26]`-line wrapfigure was silently dropped in the merged pagination, losing its label).
  Revisit if the floating placement is undesirable.
- The demoted headings now nest to `\subsubsection` (numbered `4.1.x.y`); confirm the
  depth reads well, and consider whether the two `\subsection`-level intros want polish.

## Cross-chapter consistency

- **Cross-reference style is mixed**: `\cref` (~81 uses) vs `\autoref` (~56 uses) across
  chapters. **Recommended: standardize on `\cref`/`\Cref`** (cleveref is already loaded
  `[noabbrev,capitalise]`, is the majority, and handles ranges/lists like `\cref{a,b}`
  which `\autoref` cannot). Sweep `\autoref`→`\cref` (and sentence-initial→`\Cref`).
- **Thin chapters**: `chapters/introduction/introduction.tex` (~111 lines) and
  `chapters/future-work/future-work.tex` (~100 lines) are lighter than the paper chapters
  and need expansion/polish to read as thesis-level framing rather than stubs.
- **Redundant/duplicate macros**: audit each chapter preamble (e.g. floating-point defines
  its own Lean-link and notation macros) for macros that could move into the shared
  `macros.sty` to avoid drift.

## Minted / listings

- **DONE**: dropped the unused `mlir`/`xdsl` environments (and their helper macros, the
  `MLIRLexer.py` file, and its `.latexminted_config` registration); added `style=bw` to
  `leanfootnotesize`.
- The custom-lexer syntax is version-guarded in `macros.sty` via
  `\@ifpackagelater{minted}{2024/06/01}` (minted 3.x uses the bare `path:Class`; older
  minted uses `customlexer`/`-x`). Only the minted-3.x path is exercised locally; verify
  the 2.x fallbacks if the CI/Overleaf toolchain uses an older minted.

## Bibliography hygiene

- **DONE (structural)**: fixed entry types (`bhat_2025_16269885` `@software`→`@misc`,
  `aho1985compilers` `@article`→`@book`). All `thesis.blg` warnings now clear.
- **NEEDS REAL DATA (marked `XXXXX` in `thesis.bib`)** — search the bib for `XXXXX`:
  - `brummayer2006local` `booktitle`, `smtlibfpa` `institution`, `fphandbook` `publisher`,
    `bhat2026multiwidth` `volume`, `hydra` `volume`. These were empty/missing required
    fields; placeholders inserted so they are easy to find and fill with correct values.
- Near-duplicate Büchi entries (`Buchi-presburger`, `buchi1990weak`, `buchi1966symposium`);
  the parametric-bv chapter cites `Buchi-presburger` and `buchi1990weak`. Consolidate if
  `buchi1966symposium` (or others) turn out to be unused.

## Verification checklist for future changes

- `latexmk -C && latexmk thesis.tex` should exit 0 with no `!` lines in `thesis.log`.
- `grep -i "didn't find a database entry" thesis.blg` should be empty.
- Spot-check that Lean code blocks render with the custom lexer (keyword token class
  `k+kn` in `_minted/*.highlight.minted` is the tell-tale of `Lean4Lexer`).
