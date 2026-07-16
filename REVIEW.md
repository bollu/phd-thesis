# Examiner's Report — *Mechanized Finite Domain Decision Procedures*

**Reviewer stance:** demanding Cambridge PhD examiner. This report is deliberately
complaint-focused; strengths are acknowledged briefly and then set aside so that the
required corrections are unambiguous. Line references are `file:line` into the source tree.

---

## 1. Verdict & summary

The thesis makes a genuine and timely contribution: mechanized, executable, proved-correct
decision procedures for finite-domain theories (fixed/parametric bitvectors and
floating-point), tied to a verified peephole-rewriting framework, with four papers'-worth
of substance behind it. The central arc — framework generates obligations, decision
procedures discharge them — is coherent and now well-signposted.

**However, in its present state I would not pass it without corrections.** My recommendation
is **major corrections**. The thesis reads as a submitted-too-early assembly of four papers:
it still contains unfinished author/co-author notes in the body, incomplete bibliography
entries, single-run evaluation numbers, an overclaimed central thesis, and — most seriously
for a Cambridge degree — no clear delineation of the *candidate's own* contribution within
uniformly co-authored work. None of these are fatal to the science; all are fatal to
submission as it stands.

---

## 2. Major concerns (prioritised)

### P0 — Unfinished notes left in the submitted text
This is the first thing an examiner sees and it is disqualifying on its own. There are
**seven visible `\sid`/`\grosser` annotations** still in the body:
- `chapters/floating-point/floating-point.tex:752` — `\sid{TODO: write this better}`
- `chapters/floating-point/floating-point.tex:892` — `\sid{TODO: link code}` (attached to a
  *correctness* claim about square root — the proof is asserted but not linked)
- `chapters/parametric-bv/parametric-bv.tex:2642` — `\grosser{Can we double-check the GB
  number? Why this non-power-of-two number?}` — i.e. the machine spec in the evaluation is
  *itself in doubt*
- `chapters/parametric-bv/parametric-bv.tex:2775` — `\grosser{I am surprised that Alive leads
  to memouts...}` — an unresolved reviewer question about the headline results
- `chapters/parametric-bv/parametric-bv.tex:2810` — `\grosser{Can we inline some examples that
  none of these solvers can solve?}`
- `chapters/parametric-bv/parametric-bv.tex:2852,2869` — `\sid{TODO: ...}` including "with the
  full camera ready script", which concedes the evaluation is not yet reproducible in one run.
- **Fix:** remove every author-note macro from the body (grep `\\sid{` / `\\grosser{`), and
  *resolve* the questions they raise — do not merely delete `2642`/`2775`.

### P0 — The candidate's own contribution is never delineated
Every one of the four contributions is joint work (attribution notes at
`lean-mlir.tex:22`, `parametric-bv.tex` §4.1/§4.2 openings, `floating-point.tex:131`), and
the thesis uses an undifferentiated "we" throughout. The Cambridge degree is awarded for the
*candidate's* substantial original contribution; the examiners must be told, per chapter,
**which components are the candidate's own** versus each coauthor's. `introduction.tex:109`
gestures at this ("where a specific contribution is not my own this is stated") but the
chapters do not then state it.
- **Fix:** add an explicit, specific contribution statement to each chapter's attribution
  note (e.g. "the automata library and its Lean mechanization are mine; the k-induction
  metatheory was developed jointly with X"). A vague "joint work with …" is not enough.

### P1 — The central claim is overclaimed
The abstract and introduction assert decision procedures can be mechanized "**without giving
up the scalability that makes them useful**" (`introduction.tex:23`, `abstract.tex`). The
evaluation shows otherwise in the honest sense: the verified solvers run *within a geometric-
mean slowdown* of the unverified state of the art (`floating-point.tex:1404`), and the
verified k-induction backend is deliberately paired with an *unverified* rIC3 backend because
the latter is faster (`parametric-bv.tex:2695,2717`). There **is** a scalability cost; the
contribution is that it is a small constant factor, which is a stronger and defensible claim.
- **Fix:** requalify to "…without the order-of-magnitude cost usually assumed", or similar,
  and state the measured factor up front.

### P1 — Evaluation rigour and reproducibility
Several issues an examiner will press in the viva:
- **Single-run numbers.** The line that would report repeated runs is *commented out*:
  `floating-point.tex:1396` (`% Each problem-solver pair is executed … times and we report
  the geomean aggregate`). Headline ratios therefore carry no variance or confidence interval.
- **Sub-sampling without justification.** Floating-point results are on a "stratified cross-
  family *sample*" of SMT-COMP (`floating-point.tex:1405`), not the full set — selection bias
  must be argued away.
- **LLM-generated benchmarks.** The new multi-width dataset is produced by an agent converting
  LLVM IR to SMT-LIB (`parametric-bv.tex:2677–2682`), validated only "with a naive enumerative
  solver with a bound of 8", after *manual* generalisation to arbitrary width
  (`parametric-bv.tex:2675`). The soundness of these benchmarks (and the risk of circularity —
  the tool under test shares assumptions with the benchmark generator) is not established.
- **Baseline fairness.** Bitwuzla is built from source with *experimental* small-format flags
  (`floating-point.tex` §"small-format" discussion, ~`1349`,`1477`); the comparison needs an
  explicit fairness caveat.
- **Fix:** report ≥3 runs with dispersion; justify or drop the sub-sampling; audit a sample of
  the LLM-generated benchmarks by hand and state the protocol; add a threats-to-validity
  subsection to each evaluation.

### P1 — Soundness caveats are buried, and "verified" is qualified per-operation
- `lean-mlir.tex:502`: "we assume that all regions are potentially side-effecting … shall be
  addressed in a newer version of the proof." A simplifying assumption in the *main*
  correctness result, with the fix deferred — the examiner will ask whether the headline
  theorem holds without it.
- The floating-point work mechanises "all operations *except* conversions … and rem"
  (`floating-point.tex:559`), with some operations validated by exhaustive testing rather
  than proof. The blanket "first *verified* floating-point bitblaster" needs the exceptions
  stated wherever the claim appears.
- **Fix:** a single, honest "Limitations / Threats to Validity" section per technical chapter,
  and precise scoping of every "verified"/"complete" claim.

---

## 3. Per-chapter critique

### Ch 1 — Introduction (~4 pp, `introduction.tex`)
Too thin for a doctoral introduction. The motivation and arc are good, but there is no
thesis-level positioning against the broader landscape (verified compilation à la CompCert,
verified/certifying SMT, proof-producing tactics), and no thesis-level research questions.
The contributions list doubles as the outline; a first-year examiner expects a fuller
problem statement and scope. **Fix:** expand to set up the whole field, not just chapter 3's
starting point.

### Ch 2 — Background (~14 pp)
Reasonable, but partly derived from `leanbv`, on which the candidate is second author
(`background.tex:13`). Some material is standard-textbook (SMT, bitblasting, SAT
certificates). **Fix:** compress genuinely standard content to citations, and make the
boundary between "background I co-authored" and "my contribution" crisp so it cannot be read
as padding the contribution.

### Ch 3 — Verified Peephole Rewriting (~24 pp, `lean-mlir.tex`)
The strongest, most self-contained chapter. Main complaints: the side-effecting-regions
assumption (P1 above); case studies are described but the reader cannot tell how much of the
54/93 Alive discharge rate is the framework versus the (then-immature) automation; and the
opening is still visibly the ITP'24 paper opening. **Fix:** state the assumption's impact,
and separate framework-limited from automation-limited failures in the case study.

### Ch 4 — Parametric Bitvector Solving (~54 pp)
A **mega-chapter** — roughly a third of the body — created by merging two papers. It carries
two evaluations and the bulk of the unfinished notes. Navigation is hard: the reader travels
from single-width automata theory to multi-width bitmask reductions to a joint evaluation
with no interior map. **Fix:** add a chapter roadmap after the intro; consider whether §4.1
and §4.2 want to remain one chapter or become two shorter ones (the earlier merge achieved
unity but at the cost of length); resolve the `\grosser` evaluation questions.

### Ch 5 — Mechanizing Floating Point Bitblasting (~32 pp)
Strong technical content. Complaints are the evaluation-rigour items (single-run,
sub-sample), the per-operation scoping of "verified", and the `fp.rem` timeout story
(`floating-point.tex:1418`) which is stated but not analysed. **Fix:** as P1.

### Ch 6 — Conclusions and Future Directions (~4 pp)
Now present (good) but thin. It restates the arc and the claim, then lists future work. A
doctoral conclusion should also reflect: what did *not* work, what was harder than expected,
what the broader implications are for verified tooling, and an honest appraisal of the
constant-factor cost. **Fix:** add a retrospective and a limitations synthesis.

---

## 4. Presentation, references, reproducibility

- **Incomplete bibliography.** `thesis.bib` contains `XXXXX` placeholders for required fields
  (`brummayer2006local` booktitle, `smtlibfpa` institution, `fphandbook` publisher,
  `bhat2026multiwidth`/`hydra` volume). Also `aho1985compilers` lists publisher "Citeseer",
  which is an index, not a publisher. **Fix:** complete all entries; no `XXXXX` may survive.
- **Contribution maturity.** Two of four contributions are unrefereed at submission: floating
  point "in submission", multi-width "conditionally accepted" (`introduction.tex:88`). This is
  permissible but should be stated plainly in the front matter, not only in citations
  (`introduction.tex:76` "Conditionally accepted", `introduction.tex:83` "In submission").
- **Paper-collection residue.** `parametric-bv.tex:3045` "the artifact accompanying the
  associated paper"; per-chapter data-availability notes referencing separate artifacts. A
  monograph should present a single, unified artifact and speak in its own voice.
- **Reproducibility.** The "full camera ready script" TODO (`parametric-bv.tex:2869`) concedes
  the tables are not regenerable in one run. A doctoral artifact should rebuild every number
  from a single entry point.
- **Cross-references / notation.** (Now consistent on `\cref`.) Verify every `\qffp{}/\qfbv{}`,
  acronym-on-first-use, and figure/table callout; check that the merged Ch 4's demoted
  subsubsection depth (`4.1.x.y`) still reads cleanly.

---

## 5. Required vs recommended changes

**Must fix (degree withheld until done):**
1. Remove all `\sid`/`\grosser` notes from the body and *resolve* the questions they raise.
2. Add explicit per-chapter statements of the candidate's own contribution.
3. Complete every `thesis.bib` entry (no `XXXXX`; fix wrong publishers).
4. Requalify the "without giving up scalability" claim to match the measured results.
5. Report repeated runs with dispersion; justify sub-sampling; document and audit the
   LLM-generated benchmark protocol.
6. State the side-effecting-regions assumption's impact on the Ch 3 theorem, and scope every
   "verified"/"first verified" claim to the operations actually proved.

**Should fix (polish expected of a doctoral monograph):**
1. Expand the Introduction (field-level positioning, thesis-level RQs) and the Conclusion
   (retrospective, limitations synthesis, broader impact).
2. Add a roadmap to the Ch 4 mega-chapter; reconsider its length.
3. Add per-chapter "Threats to Validity" subsections.
4. Unify artifacts and remove paper-collection phrasing; compress textbook background.
5. Separate framework-limited from automation-limited failures in the Ch 3 case study.

---

*Bottom line: the science is here and is publishable (indeed largely published); the
document is not yet a submitted thesis. The corrections above are mechanical-to-moderate and
do not require new research, with the exception of tightening the evaluation, which needs
re-running.*
