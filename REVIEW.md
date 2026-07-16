# Examiner's Report (revision 3) — *Mechanized Finite Domain Decision Procedures*

**Reviewed artifact:** `thesis-submission.pdf` (the clean submission build, draft annotations
disabled; 168 pp), freshly rebuilt at the current commit. This supersedes revision 2. Stance:
demanding Cambridge examiner; complaint-focused. Citations are `file:line` into the source.

---

## 0. Fixed since revision 2 (acknowledged)

Revision 2's two submission-blockers and several lesser items are resolved:

- **The bibliography no longer prints placeholders.** `thesis.bib` contains zero `XXXXX` and
  zero "Citeseer" publishers. The reference list is now professional. (rev-2 **P0** cleared.)
- **The headline claim is requalified.** `introduction.tex:20-24` now states the contribution as
  mechanization "at a small, constant-factor cost over the unverified state of the art, rather
  than the order-of-magnitude slowdown usually assumed of foundational methods." The
  "without giving up scalability" overclaim is gone. (rev-2 **P1** cleared.)
- **Limitations are no longer scattered.** All three technical chapters now close with a woven
  `\section{Conclusions, Limitations, and Future Work}` (`lean-mlir.tex:771`,
  `parametric-bv.tex:3011`, `floating-point.tex:1597`) that states scope, threats, and
  near-term future work in the chapter's own voice. (rev-2 **P1** cleared.)
- **The Ch 3 case-study failures are now attributed.** `lean-mlir.tex:803-807` separates the
  54-of-93 Alive result into *framework*- vs *automation*-limited: "the 39 that remain fail not
  because [the framework] cannot state or compose them, but because the residual bitvector goals
  outrun the general-purpose tactics then available." (rev-2 Ch-3 gripe cleared.)
- **Ch 4 now has an interior roadmap.** `parametric-bv.tex:67-76` sets out the two-step structure
  before the reader is dropped into a ~54-page chapter. (rev-2 should-fix cleared.)
- **Paper-collection residue removed** from the Ch 4 data-availability prose; the multi-width
  benchmark provenance (agentic translation from LLVM InstCombine, validated against a naive
  enumerative solver to bound 8) is now stated honestly (`parametric-bv.tex:3056-3063`).

This is a substantial improvement. The document has moved from "major corrections" to the cusp
of submittable.

---

## 1. Verdict & summary

**Recommendation: minor corrections.** The science is sound and largely published; the
professionalism, attribution, and rhetorical objections of revisions 1–2 are closed. What
remains is one item of genuine scholarly effort (a thin Introduction and Conclusion that do not
yet do doctoral-level framing), and two small, mechanical prose fixes (scope one "first verified"
claim at its point of use; add a missing artifact statement to the ITP'24 chapter). Nothing now
blocks submission outright, but the two prose fixes should be done before it goes to the binder.

---

## 2. Remaining concerns (prioritised)

### C1 — Introduction and Conclusion are thin for a doctorate *(needs real writing)*
`introduction.tex` is ~128 lines. It states a crisp central claim and lists contributions, and
the narrative arc is now well set up — but it does **not** position the thesis against the
broader landscape (no mention of CompCert-style verified compilation, certifying/proof-producing
SMT, or the reflective-tactic tradition), and it poses no thesis-level research questions. The
Conclusions chapter (`future-work.tex`) correctly bookends the introduction but is similarly
brief: it does not reflect on what did *not* work, nor synthesise the honest constant-factor cost
into a single retrospective statement. For a PhD, the opening and closing should locate the work
in its field and own its limitations at the thesis level, not only per chapter.
- **Fix:** expand the Introduction with a short "related fields / positioning" passage and one or
  two explicit research questions; add a retrospective paragraph to the Conclusion (what was
  harder than expected — the nonlinear-proof bottleneck is the obvious honest thread — and what
  the measured constant-factor cost means for the field).

### C2 — The "first verified floating-point bitblaster" claim is unscoped at its point of use *(prose)*
The strong claim appears unqualified at `floating-point.tex:151` ("the first \emph{verified}
floating-point bitblaster") and again at `:167` ("the first sound, verified solver for these
formats"). The exclusions that make the claim precise — round-to-integral, remainder, and the
ubv/sbv conversions remain circuit-only, not proved — are stated correctly, but only in the
conclusion (`:1600-1606`), some 1450 lines later. An examiner reading front-to-back meets the
unbounded claim first and the caveat much later.
- **Fix:** add a one-clause inline caveat at `:151`/`:167` ("first verified … for all QF\_FP
  operations except round-to-integral, remainder, and integer conversions, whose circuits are
  implemented and tested but not yet proved"), scoping the claim where it is made.

### C3 — Artifact / data-availability statements are asymmetric across the published chapters *(consistency)*
The single-width work (OOPSLA'25) states independent reproduction and a Zenodo DOI
(`parametric-bv.tex:3061-3077`), which is exactly right and strongly defuses any reproducibility
concern for that contribution. But the **lean-mlir chapter (ITP'24)** carries **no** artifact,
data-availability, or reproduction statement at all — despite ITP being an artifact-bearing venue
and the work being published. The asymmetry reads as an oversight.
- **Fix:** add a short data-availability note to `\cref{ch:lean-mlir}` recording the ITP'24
  artifact (and its evaluation, if it was badged). If any chapter's artifact was independently
  artifact-evaluated, say so explicitly — it is a free, strong rebuttal to reproducibility doubts.

### C4 — Evaluation caveats: honestly stated, but two are worth a sentence more *(minor)*
The woven limitations are candid, which is welcome. Two points an examiner may still press, each
needing at most a sentence: (i) the multi-width benchmarks are agentically translated and checked
only to bound 8 — the prose says this "does not replace a full correctness argument," which is the
right admission, but a line on *how many* were hand-audited would strengthen it; (ii) the
floating-point evaluation runs on a stratified cross-family sample of SMT-COMP rather than the full
set (`floating-point.tex`, evaluation section) — the sampling rationale is given, but the residual
selection bias should be acknowledged in one clause.

---

## 3. Per-chapter notes

- **Ch 1 Introduction / Ch 6 Conclusions** — see C1. Structurally sound, scholarly framing thin.
- **Ch 2 Background** — partly derived from co-authored `leanbv` (second author), boundary is
  stated; keep standard textbook material compressed to citations.
- **Ch 3 Verifying Peephole Rewriting** — strongest chapter; attribution note exemplary; the new
  conclusion (side-effect modelling, termination requirement, automation bottleneck) is a model of
  the woven style. Only gap: the missing artifact statement (C3).
- **Ch 4 Parametric Bitvector Solving** — the roadmap and honest benchmark provenance are real
  improvements. It remains a ~54-page mega-chapter; splitting is optional now that navigation is
  fixed, but consider it.
- **Ch 5 Mechanizing Floating Point Bitblasting** — strong; the only substantive fix is scoping
  the "first verified" claim inline (C2). The `fp.rem` timeout story is stated; a sentence of
  analysis would round it off.
- **Ch 6 Conclusions and Future Directions** — correctly bookends the intro and cross-references
  the per-chapter future work without duplication; add the retrospective of C1.

---

## 4. Presentation, references, reproducibility

- **References:** now clean — no placeholders, no bogus publishers. Good.
- **Reproducibility:** single-width is independently reproduced and cited; multi-width ships a
  Docker artifact (honestly not yet claimed as independently evaluated); floating-point is in
  submission. The one gap is the missing ITP'24 statement (C3). A doctoral artifact ideally
  rebuilds every reported number from one entry point — worth stating wherever true.
- **Contribution maturity:** two of four contributions are unrefereed at submission
  (`introduction.tex`: "conditionally accepted", "in submission"). This is stated plainly in the
  front matter, which is the correct handling; no change needed.
- **Limitations style:** there is no standalone "Threats to Validity" heading; limitations are
  woven into each chapter's closing section. This is a legitimate stylistic choice and reads well;
  flagged only so the choice is deliberate.
- **Cross-references/notation:** consistent on `\cref`; the new cross-chapter future-work links
  (`sec:fw:2adic`, `sec:fw:ackermannization`, `sec:fw:deltasat`) resolve and point outward
  without restating the global chapter.

---

## 5. Required vs recommended changes

**Should fix before binding (small, mechanical):**
1. Scope the "first verified floating-point bitblaster" claim inline at `floating-point.tex:151`
   and `:167` (C2).
2. Add a data-availability / artifact statement to the ITP'24 chapter to match the OOPSLA'25 one
   (C3).

**Recommended (doctoral polish, real writing):**
1. Expand the Introduction with field positioning and explicit research questions, and the
   Conclusion with an honest retrospective and cost synthesis (C1).
2. Add the two clarifying sentences on benchmark auditing and sampling bias (C4).
3. Optionally reconsider splitting the Ch 4 mega-chapter now that its roadmap is in place.

---

*Bottom line: revision 3 clears every blocker from the earlier reviews — the references,
the overclaim, the scattered limitations, the case-study attribution, and the chapter navigation
are all addressed. The thesis is submittable once the two mechanical prose fixes (C2, C3) are
applied; the intro/conclusion scholarly expansion (C1) is the one item still worth real effort
and is what separates a solid dissertation from a distinguished one.*
