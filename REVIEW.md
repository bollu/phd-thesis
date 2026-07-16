# Examiner's Report (revision 5) — *Mechanized Finite Domain Decision Procedures*

**Reviewed artifact:** `thesis-submission.pdf` (the clean submission build, draft annotations
disabled; 170 pp, **now seven chapters**), at the current commit following the mega-chapter split.
This supersedes revision 4. Stance: demanding Cambridge examiner; complaint-focused. Citations are
`file:line` into the source.

---

## 0. Fixed since revision 4 (acknowledged)

All four rev-4 items are resolved:

- **M1 — terminology standardized.** The "count of symbolic widths" axis is now uniformly
  *mono-width* ($\text{PBV}_1$) / *multi-width* ($\text{PBV}_n$) across the abstract, introduction,
  and both new chapters; the distinct *width-independent* property term is preserved. Remaining
  "single symbolic width" occurrences are legitimate definitional glosses, not stragglers.
- **M2 — source hygiene.** All six live `\sid`/`\grosser` draft notes are gone; two adjacent typos
  fixed.
- **M3 — the mega-chapter is split (Option A).** The 3077-line chapter is now two standalone
  chapters — **Ch 4 Mono-Width Parametric Bitvectors** (`mono-width-bv.tex`, §4.1–4.10) and
  **Ch 5 Multi-Width Parametric Bitvectors** (`multi-width-bv.tex`, §5.1–5.8) — each with its own
  intro, Related Work, and Conclusions, following the historical development (mono first, multi as
  the later generalization that reduces back to it). Both land at a conventional 8–10 section shape.
- **M4 — intro phrase de-duplication.** The "state of the art" refrain is thinned.

I read both new chapters in full and checked the seams. The split is well executed and, with one
minor exception below, introduced no new defects.

---

## 1. Verdict & summary

**Recommendation: accept, subject to minor/typographical corrections.** The restructure is clean:
re-levelling produced correct `X.Y` numbering with no stranded headings; every cross-chapter
reference goes through `\cref` (which auto-adjusts) with **no dangling prose references** ("previous
section" phrases were verified intra-chapter); the divided Related Work is disjoint and correctly
cross-links back to Ch 4 for shared background; the Ch 5 recap of the mono-width machinery is a
self-contained re-derivation (fresh worked example, cites the paper) rather than a reprint; and both
attribution notes survive with correct "This chapter is based on" wording. Nothing blocks submission.

---

## 2. Remaining items (all minor)

### N1 — One echoed sentence across the Ch 5 opening *(the one concrete edit)*
The Ch 5 lettrine and the body's technical opening both state the same fact within ~20 lines,
straddling the attribution block: the lettrine (`multi-width-bv.tex:12-13`) "The previous chapter
decided bitvector predicates in the mono-width fragment $\text{PBV}_1$" and the body
(`multi-width-bv.tex:31-33`) "\cref{ch:mono-width} showed how to decide predicates in the mono-width
setting ($\text{PBV}_1$)." The two openings are otherwise complementary (narrative, then the
enumeration-bottleneck motivation). **Fix:** trim or reword one of the two clauses so the
"$\text{PBV}_1$ / Ch 4" pointer is not made twice.

### N2 — Directory name residue *(cosmetic)*
The mono-width chapter file lives in `chapters/single-width-bv/` while the chapter is titled
"Mono-Width Parametric Bitvectors." Paths are not reader-visible, so this is pure source hygiene;
rename the directory only if you want perfect consistency (it means updating the `\input` in
`thesis.tex` and the `single-width-bv/plots/...` and `single-width-bv/images/...` asset paths).

### N3 — Caption/body formula arity *(pre-existing, not split-induced)*
In §5.1 the body states the motivating identity with explicit source widths
(`\sext(\zext(a, u, v), v, w) = \zext(a, u, w)`, `multi-width-bv.tex:88`) while the figure caption
uses an abbreviated arity (`multi-width-bv.tex:172-173`). Both are defensible (the caption is
shorthand), but an exacting examiner may ask about the mismatch. Harmonize if convenient.

### N4 — Early forward pointer *(note, not a defect)*
The Ch 5 conclusion sketches the nonlinear case "via a reduction to the first-order theory of the
$2$-adic integers, in \cref{sec:fw:2adic}" (`multi-width-bv.tex`), a forward jump into the
Conclusions chapter. It resolves (0 undefined references) and is appropriate as a pointer; flagged
only because it is an early forward reference.

---

## 3. The split, assessed

- **Standalone readability:** each chapter opens with intro prose between the chapter head and the
  first section, and closes on its own terms. Ch 4's conclusion names the *specific* limitation
  (no size-changing operations) that Ch 5 resolves and previews the linear-blowup result without
  spoiling it — a genuinely good seam. Ch 5's conclusion claims exactly what the chapter delivers
  and hands off cleanly to Ch 6.
- **No dangling prose references:** all "previous section" phrases in Ch 5 were verified to be
  intra-chapter; no mono-half labels (`sec:swbv:*`) are referenced from Ch 5; Ch 4 has no forward
  prose leak into Ch 5.
- **Divided Related Work:** disjoint. Ch 4 covers the mono machinery (bitwidth-independent circuits,
  automata Presburger solvers, model checking, automata libraries, MBA); Ch 5 covers the
  multi-specific work (fixed-width backends, parametric BV solving, BMC) and explicitly points back
  to Ch 4 for the shared background.
- **Attribution:** both chapters retain their "My contributions" notes.

---

## 4. Required vs recommended

**Required before final submission:** none (typographical only).

**Recommended (polish, none blocking):**
1. Trim the echoed "$\text{PBV}_1$ / Ch 4" statement across the Ch 5 opening (N1).
2. Optionally rename the `single-width-bv/` directory for consistency with the "Mono-Width" title (N2).
3. Optionally harmonize the §5.1 caption/body formula arity (N3).

---

*Bottom line: revision 5 confirms the chapter split is well executed and the thesis reads as a clean
seven-chapter monograph. Every substantive objection from revisions 1–4 is closed; what remains is a
single one-line prose trim and two optional cosmetic tidies. This is a submittable dissertation.*
