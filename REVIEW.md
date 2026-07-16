# Examiner's Report (revision 4) — *Mechanized Finite Domain Decision Procedures*

**Reviewed artifact:** `thesis-submission.pdf` (the clean submission build, draft annotations
disabled; 170 pp), freshly rebuilt at the current commit. This supersedes revision 3. Stance:
demanding Cambridge examiner; complaint-focused. Citations are `file:line` into the source.

---

## 0. Fixed since revision 3 (acknowledged)

Revision 3's substantive items are all resolved and well executed:

- **The Introduction now does doctoral-level framing (C1a).** A new
  `\section{Automated Speed and Interactive Trust}` (`introduction.tex:48`) positions the work
  against the landscape — the SMT-vs-ITP trust dichotomy, the verified-compilation lineage
  (CompCert, Vellvm, Alive/Alive2), and the certifying/proof-producing spectrum (SMTCoq, CoqQFBV,
  F\*/HACL\*, and the Harrison/Flocq/VCFloat "verify theorems, not the solver" tradition). The
  origin-story pivot (`:20`) and the thesis-level research questions, woven into prose as "a single
  question asked in four parts" each `\cref`-mapped to its chapter (`:26-36`), are present.
- **The Conclusion now owns the cost (C1b).** A new `\section{The Price of Verification}`
  (`future-work.tex:29`) states the constant-factor price plainly (including that the verified
  $k$-induction backend is paired with the *unverified* rIC3 because rIC3 is faster on the hardest
  instances, `:31-41`) and reflects at the thesis level on what resisted mechanization — nonlinear
  arithmetic — naming nonlinear proof automation as the missing enabling technology (`:43-59`).
- **The "first verified" claim is scoped at its point of use (C2).** `floating-point.tex:151-154`
  now caveats the claim inline (excluding round-to-integral, remainder, and integer conversions),
  echoed at `:170`.
- **The artifact asymmetry is closed (C3).** The lean-mlir chapter now carries a Data-availability
  note (`lean-mlir.tex:812-816`, Zenodo record) matching the single-width chapter.

I checked the expanded Introduction against the per-chapter Related Work sections: the landscape
is a faithful compression, with no contradictions. The submission build log is clean — zero
undefined, multiply-defined, or unresolved references.

This is now a strong dissertation.

---

## 1. Verdict & summary

**Recommendation: accept, subject to minor/typographical corrections.** The science is sound and
largely published; the positioning, limitations, references, and attribution objections of the
earlier reviews are all closed. What remains is editorial — one terminology inconsistency, some
source-side draft-note hygiene, and an optional structural rebalancing — none of which blocks
submission. There is no longer any item requiring new research or re-experimentation.

---

## 2. Remaining items (all minor)

### M1 — One concept, three names on the first two pages *(cheap, real)*
The abstract calls the multi-width reduction target a **"mono-width"** formula
(`abstract.tex:26-28`), while the Introduction calls the same thing **"single-symbolic-width"**
(`introduction.tex:148-149`) and **"one symbolic width"** (`introduction.tex:31,45`). A reader
meets all three names before the technical content begins. **Fix:** standardize on
"single symbolic width" throughout (the abstract's "mono-width" is the outlier).

### M2 — Live draft notes remain in the source *(source hygiene)*
Six `\sid`/`\grosser` draft macros survive in the source. They are correctly hidden in the
submission build (verified: zero leakage in `thesis-submission.pdf`), so they are not defects in
the reviewed PDF — but they are loose ends to clear before the final source is handed to the
binder or released:
- `parametric-bv.tex:2655` — `\grosser{Can we double-check the GB number…}`, attached to a live
  RAM figure (`\MwSystemSpecsMemoryGb`) that appears in the *published* evaluation. **Resolve this
  one first** (confirm the number, then delete the note).
- `parametric-bv.tex:2788`, `:2823`, `:2865` — analysis/TODO questions on the multi-width
  evaluation (Alive memouts; unsolved-example inlining; translation-vs-solving time breakdown).
- `floating-point.tex:760` — `\sid{TODO: write this better}`.
- `floating-point.tex:900` — `\sid{TODO: link code}`, a missing hyperlink for the square-root proof.

**Fix:** answer in prose or delete each; none needs to survive to submission.

### M3 — The parametric-bitvector chapter is a mega-chapter *(editorial)*
`parametric-bv.tex` is 3077 lines — roughly twice the next longest chapter (floating-point, 1633)
— because it fuses the single-width and multi-width work. It now has an interior roadmap
(added in rev 2), so navigation is no longer a blocker; whether to split it into two chapters is
a judgment call for the candidate and supervisor. Flagged, not required.

### M4 — Minor prose nits *(optional)*
- Signature phrases recur closely in the front matter: "trusted down to the kernel" and
  "(unverified) state of the art" each appear several times within the Introduction and again in
  the Conclusion; two adjacent "on one side / on the other side" antitheses sit in the landscape
  section (`introduction.tex:50-93`). Light de-duplication would tighten otherwise high-quality prose.
- The certifying-approaches contrast set up in the Introduction (SMTCoq/CoqQFBV,
  `introduction.tex:82-100`) is never revisited in a chapter; the parametric-bitvector Related Work
  would be its natural home. Optional.

---

## 3. Reproducibility and evaluation — closed

I record this explicitly because earlier revisions pressed it. The evaluation is honestly caveated
in-text (the multi-width benchmarks' agentic-translation provenance and naive-enumerative check to
bound 8; the floating-point stratified cross-family sample), and the published contributions are
distributed as artifacts, with the single-width work independently reproduced through published
artifact evaluation. On that basis I treat reproducibility as **resolved** and do not carry it as
an action item. A maximally adversarial examiner could still note that the headline runtimes are
single-run and that the floating-point set is sub-sampled; both are mitigated (disclosed;
artifact-evaluated where published), and I do not pursue them further.

---

## 4. Presentation and references

- **References:** clean — no placeholders, no bogus publishers, no undefined citations. Good.
- **Attribution:** each chapter's contribution note is exemplary; the Background chapter's reliance
  on the co-authored `leanbv` work is disclosed up front (`background.tex:14-19`) and framed as
  background, not contribution, which is the correct handling.
- **Draft-note hygiene:** see M2.
- **Terminology:** see M1.
- **Cross-references/notation:** consistent on `\cref`; all resolve.

---

## 5. Required vs recommended changes

**Required before final submission (typographical only):**
1. Standardize the "mono-width" / "single-symbolic-width" / "one symbolic width" terminology (M1).

**Recommended (polish, none blocking):**
1. Resolve or delete the six source-side draft notes (M2) — starting with the `parametric-bv.tex:2655`
   note that questions a published RAM figure.
2. Optionally split the parametric-bitvector mega-chapter (M3).
3. Light de-duplication of the Introduction's signature phrases, and an optional callback to the
   certifying-approaches contrast in the parametric-bitvector Related Work (M4).

---

*Bottom line: revision 4 is submittable. Every substantive objection from revisions 1–3 —
references, overclaiming, scattered limitations, thin intro/conclusion, artifact asymmetry — is
now closed, and the intro/conclusion additions are genuine quality improvements. What is left is a
single terminology fix and a tidy-up of draft notes in the source; the reproducibility question is
resolved by the honest caveats and the artifact evaluation of the published work. This is a strong
dissertation; correct the terminology, clear the draft notes, and submit.*
