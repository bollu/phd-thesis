# Examiner's Report (revision 2) — *Mechanized Finite Domain Decision Procedures*

**Reviewed artifact:** `thesis-submission.pdf` (the clean submission build, with draft
annotations disabled) at commit following the contribution-statement pass. This supersedes
revision 1. Stance: demanding Cambridge examiner; complaint-focused. Citations are
`file:line` into the source.

---

## 0. Fixed since revision 1 (acknowledged)

Three of the revision-1 blockers are resolved and I will not belabour them:
- **Draft annotations no longer appear.** The submission build hides all `\sid`/`\grosser`
  notes (verified: zero annotation strings in `thesis-submission.pdf`). They remain in
  source for drafting, which is the right arrangement.
- **The deferred-proof caveat is gone.** The `lean-mlir` footnote conceding the
  side-effecting-regions assumption "shall be addressed in a newer version" has been removed.
- **Individual contribution is now delineated.** Each chapter's attribution note carries a
  "My contributions" statement separating the candidate's work from coauthors'
  (Hughes, Stefanesco, Goens, Keizer, Abdal, Shi). This directly answers the revision-1 P0.

Good progress. The document is materially closer to submittable. It is **not there yet.**

---

## 1. Verdict & summary

**Recommendation: major corrections.** The science remains sound and largely published; the
remaining defects are (a) a bibliography that literally prints placeholder text, (b) an
evaluation that is not yet rigorous or reproducible, and (c) a headline claim the results do
not support. Only (b) needs real work (re-running experiments); the rest are prose- and
reference-level. Two items block submission *today*: the `XXXXX` references and the
single-run evaluation numbers.

---

## 2. Major concerns (prioritised)

### P0 — The bibliography prints `XXXXX`
The submission PDF's reference list contains five literal `XXXXX` placeholders
(`thesis.bib:721` booktitle, `:1546` publisher, `:2014` volume, `:3522` institution,
`:4005` volume). An examiner turning to the references sees unfinished work on the page.
Additionally `aho1985compilers` still lists publisher "Citeseer" (an index, not a publisher).
- **Fix:** complete every entry with correct data; no `XXXXX` may survive in either build.

### P1 — The central claim is not supported by the evaluation
The abstract and introduction still assert mechanization "**without giving up the scalability
that makes them useful**" (`introduction.tex:23`), while the body's honest measurements show a
*cost*: the floating-point solver "runs within a small factor of" Bitwuzla (`abstract.tex:37`),
and the verified k-induction backend is paired with an unverified rIC3 backend precisely
because it is faster. The contribution — a *small constant-factor* cost — is strong and
defensible; the current wording overclaims and invites attack in the viva.
- **Fix:** requalify to state the measured factor up front (e.g. "at a small constant-factor
  cost") and drop "without giving up scalability".

### P1 — Evaluation rigour and reproducibility
- **Single-run numbers.** The line that would report repeated runs is commented out
  (`floating-point.tex:1402`), so the headline geomean ratios carry no variance or confidence
  interval. This is the single most exposed methodological weakness.
- **Unjustified sub-sampling.** Floating-point results are on a "stratified cross-family
  *sample*" of SMT-COMP (`floating-point.tex:1411,1623`), not the full benchmark set; the
  selection procedure and its bias must be argued, or the full set run.
- **LLM-generated benchmarks.** The multi-width dataset is produced by an agent converting
  LLVM IR to SMT-LIB (`parametric-bv.tex:2690`), after manual generalisation, validated only
  by a naive enumerative solver to bound 8. The soundness of the benchmarks and the risk of
  shared-assumption circularity with the tool under test are not established.
- **Fix:** report ≥3 runs with dispersion; justify or eliminate the sub-sample; hand-audit a
  sample of the generated benchmarks and document the protocol.

### P1 — Limitations/threats are still scattered, and "verified" is qualified per-operation
There is no systematic "Threats to Validity"/"Limitations" treatment. Scope caveats are
buried — e.g. the floating-point work mechanises "all operations *except* conversions … and
rem" (`floating-point.tex:565`), some validated only by exhaustive testing. The blanket
"first *verified* floating-point bitblaster" needs the exceptions stated wherever it appears.
- **Fix:** a short Limitations/Threats subsection per technical chapter; scope every
  "verified"/"complete"/"first" claim to what was actually proved.

---

## 3. Per-chapter critique

### Ch 1 — Introduction (~4 pp)
Still too thin for a doctoral introduction: no thesis-level positioning against the broader
landscape (CompCert-style verified compilation, certifying SMT, proof-producing tactics), no
thesis-level research questions. The narrative arc is now well set up (good), but the
scholarly framing is missing. **Fix:** expand to situate the whole field.

### Ch 2 — Background (~14 pp)
Partly derived from `leanbv` (candidate second author, `background.tex:13`), some of it
standard-textbook. **Fix:** compress standard material to citations; keep the co-authored
boundary crisp so it cannot read as padding.

### Ch 3 — Verified Peephole Rewriting (~24 pp)
Strongest chapter, and the attribution/contribution note is now exemplary. Remaining gripe:
the case study reports that "only 54 of the 93 translated Alive rewrites could be discharged
by the automation available at the time" (`lean-mlir.tex:787`) but does not separate
*framework*-limited failures from *automation*-limited ones — which matters, since the thesis
argues the automation (later chapters) is the fix. **Fix:** break down the 39 failures.

### Ch 4 — Parametric Bitvector Solving (~54 pp)
A **mega-chapter** — roughly a third of the body — with two evaluations and no interior
roadmap. Navigation is hard. The `\grosser` questions that were visible in revision 1 are now
hidden in the submission build, but they flag *real* unresolved analysis (e.g. why Alive
memouts occur) that the prose should answer, not merely hide. **Fix:** add a chapter roadmap;
resolve (in prose) the analysis questions the hidden notes raised; reconsider splitting.

### Ch 5 — Mechanizing Floating Point Bitblasting (~32 pp)
Strong content; complaints are the evaluation-rigour items (single-run, sub-sample) and the
per-operation scoping of "verified". The `fp.rem` timeout story is stated but not analysed.

### Ch 6 — Conclusions and Future Directions (~4 pp)
Now present and correctly bookends the introduction (good). Still thin: a doctoral conclusion
should also reflect on what did *not* work, the honest constant-factor cost, and broader
implications. **Fix:** add a short retrospective and a limitations synthesis.

---

## 4. Presentation, references, reproducibility

- **References (P0 above):** `XXXXX` placeholders and the "Citeseer" publisher.
- **Contribution maturity:** two of four contributions remain unrefereed at submission
  ("Conditionally accepted", `introduction.tex:76`; "In submission", `introduction.tex:83`).
  Permissible, but state it plainly in the front matter.
- **Paper-collection residue:** `parametric-bv.tex:3058` "the artifact accompanying the
  associated paper", plus separate per-chapter data-availability notes. A monograph should
  present one unified artifact and speak in its own voice.
- **Reproducibility:** the evaluation is not regenerable from a single entry point (the reason
  the multi-width numbers depend on a not-yet-unified script). A doctoral artifact should
  rebuild every reported number in one run.
- **Cross-references/notation:** now consistent on `\cref`; verify acronym-on-first-use and
  that the merged Ch 4's `4.x.y.z` heading depth still reads cleanly.

---

## 5. Required vs recommended changes

**Must fix (submission blocked until done):**
1. Complete every `thesis.bib` entry — eliminate all `XXXXX`; fix the "Citeseer" publisher.
2. Requalify the "without giving up scalability" claim to the measured constant factor.
3. Report repeated runs with dispersion; justify or drop the SMT-COMP sub-sampling; document
   and audit the LLM-generated benchmark protocol.
4. Add per-chapter Limitations/Threats-to-Validity, and scope every "verified"/"first" claim.

**Should fix (doctoral polish):**
1. Expand the Introduction (field positioning, thesis-level RQs) and the Conclusion
   (retrospective, honest cost, broader impact).
2. Add a roadmap to the Ch 4 mega-chapter; answer in prose the analysis questions the
   now-hidden `\grosser` notes raised; reconsider its length.
3. Break down the Ch 3 case-study failures (framework- vs automation-limited).
4. Unify artifacts and remove paper-collection phrasing; compress textbook background.

---

*Bottom line: revision 2 clears the professionalism and attribution objections; what remains
is scholarly (a thin intro/conclusion), rhetorical (one overclaim), and — the only item
needing real effort — a rigorous, reproducible re-run of the evaluation. Fix the references
and the claim wording immediately; schedule the evaluation re-run.*
