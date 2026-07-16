# Examiner's Report

**Thesis:** *Mechanized Finite Domain Decision Procedures*
**Candidate:** Siddharth Bhat (Churchill College)
**Degree:** PhD in Computer Science, University of Cambridge
**Reviewer role:** Independent examiner
**Build:** `latexmk -g -pdf -shell-escape thesis-submission.tex` succeeds cleanly; produces `thesis-submission.pdf`, 170 pp. No undefined references or citations in the log. (93 overfull `\hbox`es remain — cosmetic; see Presentation.)

---

## 1. Recommendation

**Pass subject to minor corrections** (corrections not requiring re-examination).

This is strong, coherent doctoral work, comfortably above the bar for a Cambridge PhD. It bundles four peer-reviewed or under-review contributions (ITP 2024; OOPSLA 2025; OOPSLA 2026, conditionally accepted; one in submission) into a single, genuinely unified narrative, backed by a large and evidently working Lean mechanization. The central intellectual contributions — recasting width-independent bitvector reasoning as model checking, the width-as-bitmask reduction from multi-width to mono-width parametric bitvectors, and the first (scoped) verified floating-point bitblaster — are novel, non-trivial, and independently significant.

I am recommending *minor* rather than no corrections because the thesis's **headline quantitative claim is mis-calibrated against its own measured numbers** (§4 below), and because one chapter suppresses the formal semantics that its main theorem is stated against (§5.4). Neither is a defect of the underlying science; both are matters of honest framing and completeness that must be fixed before the thesis is deposited. None rises to the level of major corrections: the results are sound, the evaluation is real, and the limitations are — with the exceptions noted — stated candidly.

---

## 2. Overall assessment

### 2.1 Is there a thesis-level contribution and narrative?

Yes, and this is the thesis's greatest strength. Assembling four papers into a PhD often yields a stapled collection; here the introduction (`chapters/introduction/introduction.tex`) builds a real arc: verified peephole rewriting (Ch. 3) is shown to *generate* finite-domain proof obligations, which the subsequent chapters *discharge* with decision procedures of increasing generality — fixed width → mono-width (Ch. 4) → multi-width (Ch. 5) → richer values, i.e. floating point (Ch. 6). The "structural proof is free, the arithmetic is the bottleneck" framing (`introduction.tex:103-126`; reprised at `lean-mlir.tex:799-810`) is a persuasive spine, and the inter-chapter "bridges" (e.g. `multi-width-bv.tex:1608-1615`) are well written and earn the transitions. The retrospective in Ch. 7 (`future-work.tex:30-60`) — that the true obstacle throughout was *nonlinear* arithmetic — is an honest and valuable synthesis.

### 2.2 Novelty and significance

Sufficient and then some. Specifically:

- The **width-as-bitmask reduction** (`multi-width-bv.tex:429-650`), collapsing exponential width-enumeration into a single QF_BV query and, composed with automata, yielding a decidable fragment strictly larger than prior work by adding zero/sign extension, is the strongest single result. The paper proof (Def. 5.x compatibility; Lemma correspondence; Thm equisatisfiability) is clean and convincing.
- The **model-checking view of PBV₁** and the accompanying *executable, verified* automata/`k`-induction library inside an ITP (`mono-width-bv.tex:333-568`) is a real contribution: the point that the model-checking lens "was previously unusable in mechanized proofs" for want of fast verified model checkers (`mono-width-bv.tex:52-59`) is well taken.
- The **first verified floating-point bitblaster** (Ch. 6), properly scoped, is a substantial engineering-and-proof achievement, and the by-products — surfacing latent SymFPU width assumptions and a genuine SMT-LIB spec typo (`floating-point.tex:1268-1305`) — are exactly the kind of thing mechanization is supposed to buy.

### 2.3 Individual contribution (collaborative/published work)

Handled well and honestly. Every chapter opens with an explicit attribution note delineating the candidate's role (`lean-mlir.tex:22-31`, `mono-width-bv.tex:24-35`, `multi-width-bv.tex:22-29`, `floating-point.tex:131-138`), and the background chapter is *explicitly* demarcated as not a contribution — the `bv_decide`/Lean-BV work (Böving-led, on which the candidate is second author) is presented as infrastructure the thesis builds on (`background.tex:13-19`, `introduction.tex:178-185`). This is scrupulous and to the candidate's credit.

Two honest observations for the viva rather than criticisms:
- In Ch. 3 the initial peephole-correctness proof was Chris Hughes's, and the candidate generalised it; in Ch. 4 the initial algorithm and the alternative automatic-structures solver are others' (`mono-width-bv.tex:28-35`). The candidate's own contribution (generalisation to all predicates, the Lean implementation and tactic frontends, the MBA solver, and the multi-width generalisation) remains clearly PhD-worthy, but the examiners should confirm the boundaries in person.
- The whole edifice sits on `bv_decide`, which is not the candidate's. This is fine — it is background — but it means the candidate's independent verified contribution is concentrated in Chs. 4–6, which is where the viva should probe hardest.

---

## 3. Per-chapter critique

### Ch. 1 — Introduction
Excellent. Sharp problem statement (the speed-vs-trust tension), the "re-derive the solver inside the prover" positioning against certifying (SMTCoq, CoqQFBV) and floating-point-theorem (Flocq, VCFloat) traditions (`introduction.tex:83-101`), and a clear contributions list tied to venues. The one problem is the **central claim wording** (§4).

### Ch. 2 — Background
Very good and genuinely useful: `QF_BV`, bitblasting, AIGs, LRAT, Lean/reflection/FBIP, the `BitVec` library and its proof techniques, `bv_decide`, and the three existing width-generic fragments (`background.tex:526-581`). Honest about the trusted code base (`ofReduceBool`/compiler trust, `background.tex:113-128`, `260-273`). It is long, but it is the shared substrate for three chapters, so the length is justified. Minor: it leans heavily on `leanbv`; the attribution paragraph covers this, but a reader could momentarily mistake the depth of exposition for ownership.

### Ch. 3 — Verifying Peephole Rewriting in SSA Compiler IRs
Technically solid and clearly written. The intrinsically-well-typed `Expr`/`Com` encoding, the zipper-based rewrite-correctness proof (`lean-mlir.tex:399-449`), region support, DCE/CSE, the pure-in-effectful extension, and three case studies (LLVM bitvectors, `scf`, FHE `Poly`) together demonstrate the framework scales. Strengths: the FHE case study is a compelling argument for high-level IRs; the exhaustive-enumeration cross-check of the LLVM semantics against `opt` up to width 8 (`lean-mlir.tex:563-570`) is good practice.

Weaknesses/soundness caveats, all disclosed:
- Side effects are modelled coarsely; `ub` and poison are both collapsed to `Option.none`, sound only because both sides of each translated rewrite are manually checked to trigger `ub` iff the other does (`lean-mlir.tex:554-561`, `784-797`). This is an honest hole.
- Only 54/93 translated Alive rewrites were dischargeable by the automation of the day (`lean-mlir.tex:577-582`, `803-806`) — but the chapter turns this into the motivating gap for the rest of the thesis, which is rhetorically effective and fair.

### Ch. 4 — Mono-Width Parametric Bitvectors
The intellectual heart of the automata line. Two independent decision procedures (automata universality; `k`-induction as a safety check) plus a specialised MBA solver, all mechanized, all proof-producing. The bisimulation-to-Mathlib-`NFA` specification strategy (`mono-width-bv.tex:479-549`) and the generic worklist algorithm (proved terminating once) are elegant and clearly the right engineering. The `k`-induction completeness argument via simple-path constraints (`mono-width-bv.tex:808-817`) is correct and well explained. Preprocessing (§4.6) is thorough and honest about what it does.

Concerns:
- **Native compilation is disabled** for the evaluation ("does not work with the recent versions of Mathlib and Lean we tested with", `mono-width-bv.tex:1273-1279`), so the automata solver runs interpreted and the reported times are ≥2× conservative. Disclosed, but it complicates any speed comparison.
- The failure taxonomy on InstCombine (`mono-width-bv.tex:1291-1315`) is admirably candid: most "failures" are fixed-width problems mis-treated as all-width (447), multi-width problems out of the mono fragment (1925), etc. This honesty is good, but it also means the 100%-of-Hacker's-Delight headline and the InstCombine coverage number should be read in that light (see §4).

### Ch. 5 — Multi-Width Parametric Bitvectors
The strongest theoretical chapter. The worked example (`multi-width-bv.tex:66-219`) is genuinely illuminating, and the equisatisfiability development (§5.3) is rigorous. The two solver paths (single QF_BV call vs. automata) are well motivated, and the diagnostics table on formula/automaton sizes (§5.7.3) is exactly the right auxiliary evidence for the "linear blowup" claim.

Concerns (see §4, §5):
- The **formal semantics figure is commented out** in the source (`multi-width-bv.tex:354-401`), leaving §5.2.3 as prose plus "See the accompanying Lean development" (`multi-width-bv.tex:426-427`). The chapter's flagship theorem is *stated against a semantics the thesis does not print.* This must be fixed.
- The multi-width InstCombine benchmark is partly **LLM-generated** (`multi-width-bv.tex:1326-1338`, `1599-1606`). Disclosed and mitigated (enumeration check to bound 8), but it is the dataset on which "BMC-Ours saturates" and "beats CVC5" headlines partly rest.
- Whether the **equisatisfiability theorem itself is mechanized** is unclear (see viva Q3). The bounded reduction *implementation* is explicitly unverified (`multi-width-bv.tex:1149`, `1153-1157`), and mechanization is claimed for the *unbounded* solver (`multi-width-bv.tex:59-60`).

### Ch. 6 — Mechanizing Floating Point Bitblasting
Impressive in scope and honest in its scoping. The generic-over-numeric-domain SMT-LIB mechanization (Mathlib-free, extended-rationals instance) serving simultaneously as spec and executable oracle (`floating-point.tex:341-560`) is a nice design. The guard/sticky rounding contract and the "round the same rational" correctness argument (`floating-point.tex:296-321`, `685-810`) are clearly explained. Table 6.1 (`floating-point.tex:570-632`) is a model of transparency: it states per-operation exactly what is *proven* vs. merely *implemented/tested*. The four-way testing regimen (executable spec vs. circuits; vs. Lean's Float model; vs. SymFPU; end-to-end FPTG oracle) is genuinely rigorous, and the SymFPU archaeology (`floating-point.tex:1188-1237`) is valuable community work.

Concerns:
- **Three operations (round-to-integral, rem, to_ubv/to_sbv) are unproven**, and sqrt is only partially specified ("closer than either neighbour", not "is the square root", for want of the reals, `floating-point.tex:898-903`). The "first verified floating-point bitblaster" claim is correctly qualified everywhere it appears (`floating-point.tex:151-154`, `1601-1607`). But the *shipped solver still bitblasts the unproven circuits*, so end-to-end soundness for full `QF_FP` rests on testing for those operations (see viva Q4).
- The **33.1× geomean slowdown vs. Bitwuzla** (`floating-point.tex` resolved figure; `\SmtLibGeomeanTimeElapsedRatioOB`) is the crux of §4.

### Ch. 7 — Conclusions and Future Directions
The best kind of conclusion: it names the price of verification plainly (`future-work.tex:30-42`), identifies nonlinear arithmetic as the recurring obstacle, and sketches concrete, credible directions (2-adic CAD solver with an unpublished decidability/undecidability pair; incremental solving + arrays for Bitwuzla parity; δ-satisfiability for average-case FP error). The candour here is exactly right — which makes the over-softened wording *elsewhere* (§4) all the more conspicuous by contrast.

---

## 4. The central claim is mis-calibrated (the most important required correction)

The thesis's thesis is stated at `introduction.tex:39-43`:

> decision procedures … can be mechanized … **at a small, constant-factor cost** over the unverified state of the art, **rather than the order-of-magnitude slowdown** usually assumed of foundational methods.

The abstract echoes it — the FP bitblaster "**runs within a small factor** of … Bitwuzla" (`frontmatter/abstract.tex:36-38`) — as does the conclusion ("a **modest** geometric-mean factor", `future-work.tex:35`).

The thesis's own measured numbers do not support the *magnitude* descriptor:

- **Floating point: 33.1× geomean slowdown** vs. Bitwuzla on the SMT-COMP sample (Ch. 6 evaluation, `\SmtlibRandSpeedupBitwuzlaOverOurs`). 33× is *more than* an order of magnitude — it is the very thing the central claim says the work avoids.
- The chapter itself explains why: `bv_decide` is already "**within roughly an order of magnitude** of Bitwuzla's … bitvector engine" (`floating-point.tex:1442-1445`), and the FP layer adds more on top.
- So across the flagship value-domain result, the evidence shows an order-of-magnitude-plus slowdown, directly contradicting "rather than the order-of-magnitude slowdown."

To be scrupulously fair to the candidate: the *defensible* and genuinely valuable claim is the **asymptotic** one — verified automation pays a **constant factor** (independent of problem size / width count) rather than an *unbounded* or *exponential* blow-up (e.g. BMC-Ours vs. naive enumeration's `o^k`; the automata solver's completeness). That claim *is* supported. The problem is purely the adjective "**small**" and the "rather than order-of-magnitude" contrast, which the FP number falsifies. The recent commit "requalify the central claim to the measured constant-factor cost" shows the candidate is already alive to this; the fix is to finish the job.

**Required:** reword the abstract, `introduction.tex:39-47`, and `future-work.tex:30-42` so that (a) "constant factor" is retained and defended as *asymptotic* (vs. enumeration/asymptotic blow-up), and (b) the *magnitude* is stated honestly per domain — roughly an order of magnitude for the bitvector core, ~33× for floating point — dropping "small" where the measured factor is large. This is a truth-in-labelling fix, not a re-run of experiments.

### Secondary over-/under-claims to reconcile (Required):

1. **Multi-width "several times as many":** the chapter intro says the unbounded solvers "prove **several times as many** all-width problems as … CVC5" (`multi-width-bv.tex:63-64`), but the measured overall ratio is **1.45× (385 vs. 265)**, and the conclusion correctly says "**1.5×**" (`multi-width-bv.tex:1579-1580`). Per-dataset it is 156 vs. 107, 222 vs. 153, 7 vs. 5 — never "several times." Reword the intro to match.

2. **Mono-width "27%":** the abstract and Ch. 4 conclusion say the tools solve "**up to 27%**" of LLVM peephole rewrites (`mono-width-bv.tex:67-68`, `1413`), but the best symbolic solver (`k`-induction) solves **2498/7978 = 31.3%** per the evaluation table; 27% ≈ the *automata* solver's 2138/7978 = 26.8%. "Up to" should quote the maximum. This under-sells their own result and is internally inconsistent — reconcile the hardcoded figure with the generated numbers.

The lesson these three share: **hardcoded prose numbers have drifted from the macro-generated evaluation numbers.** A pass to route every quantitative claim through the generated `\...` macros (or at least to audit them against the table values) is required.

---

## 5. Rigour, evaluation, reproducibility, threats to validity

**Empirical support — generally good.** Evaluation uses survival/cactus plots, geomeans, per-dataset breakdowns, and (Ch. 5) size diagnostics that directly evidence the "linear blowup" claim. Baselines are appropriate and current: Bitwuzla (FP/BV roofline), CVC5-berger (SOTA parametric), naive enumeration (the actual Alive2 approach), exhaustive enumeration (a *sound* small-format baseline). The choice to run BMC-Naive and BMC-Ours through the *same* `bv_decide` backend to isolate the reduction's effect (`multi-width-bv.tex:1362-1367`) is exactly right.

**Reproducibility — uneven but mostly good.**
- Ch. 4: Zenodo artifact, "independently reproduced through published artifact evaluation" (`mono-width-bv.tex:1426-1429`) — the gold standard.
- Ch. 3: Zenodo artifact archived (`lean-mlir.tex:812-816`).
- Ch. 5: Docker container (`multi-width-bv.tex:1617-1619`), *not* independently reproduced — and the chapter itself flags the asymmetry (`multi-width-bv.tex:1604-1606`).
- Ch. 6: open GitHub development with per-theorem source links (a very nice touch), but no archived artifact cited.
**Recommended:** archive Ch. 5 and Ch. 6 artifacts (Zenodo DOI) for the deposited version.

**Threats to validity — mostly acknowledged.** The strongest un-foregrounded ones:
- **Benchmark provenance (Ch. 5):** the multi-width InstCombine set is hand-seeded then LLM-extended (`multi-width-bv.tex:1332-1338`); the "clean generalization to parametric widths" is checked only to bound 8, not proven. Since this is a headline dataset, the threat deserves a sentence in the evaluation body, not only the limitations paragraph.
- **Statistical treatment:** geomeans are reported but with **no dispersion** (no CIs, quartiles, or run-to-run variance; the `\FpConfigRuns`/repeat line is commented out at `floating-point.tex:1403`). For a "within a factor of X" claim, at least single-run determinism and one measure of spread should be stated. **Recommended.**
- **Kernel-vs-NoKernel and interpreted-vs-native:** the trust/speed configurations are handled transparently, but they make cross-tool comparison subtle; a short "what is in the trusted base for each bar" note under each cactus plot would help. **Recommended.**

**Soundness scoping — good.** Out-of-fragment inputs return `unknown` rather than a guess (`multi-width-bv.tex:1481-1483`); SAT answers are certified by kernel-checking a reconstructed model (`floating-point.tex:1090-1119`); the bounded solver's "valid up to bound o" assumption is stated as a limitation (`multi-width-bv.tex:1153-1157`). I did not find an over-claimed soundness result. In particular, I checked the bitmask-wraparound worry in the bounded reduction (a model could pick a width value > o with a wrapped mask): for the *proving* direction this is harmless, since UNSAT over the larger BV(o) domain implies UNSAT over the genuine widths ≤ o — no defect. (Good viva material nonetheless: Q5.)

---

## 6. Scholarship, positioning, honesty of limitations

Related-work coverage is broad and fair: certifying vs. re-deriving solvers; CompCert/Vellvm/Alive lineage; automata/Presburger and mechanized model checking (cava, KAT-in-Coq, ACL2 SVEX); the Flocq/VCFloat/Harrison/FLoPS floating-point tradition; SymFPU and the extended-real SMT-LIB semantics. The "first/verified/complete" claims are, on inspection, properly scoped:
- "first verified floating-point bitblaster" — always qualified by the three unproven ops (`floating-point.tex:151-170`).
- "sound and complete" (Ch. 5) — explicitly restricted to the **linear-bitwise** fragment (`multi-width-bv.tex:1040-1046`, `1588-1594`); nonlinear is deferred to Ch. 7.
- "complete" `k`-induction (Ch. 4) — for the handled fragment, with the simple-path caveat spelled out.

Limitations are, with the §4/§5.4 exceptions, stated candidly and often pre-emptively (the per-chapter "Limitations" paragraphs are a good habit).

**Bibliography hygiene (Recommended):** because chapters were ported from separate papers, the same tools appear under **multiple bib keys** — Z3 as `de2008z3`, `deMoura2008z3`, and `z3`; cvc5 as `barbosa2022cvc5` and `cvc5`; Bitwuzla as `niemetz2023bitwuzla` and `bitwuzla` (thesis.bib lines 229, 463, 972, 1253, 1282, 2946, 3909). The same paper is thus cited inconsistently across chapters (e.g. `de2008z3` in Ch. 2 vs. `deMoura2008z3` in Ch. 3). Deduplicate to one key per work.

---

## 7. Presentation

Prose quality is high throughout — clear, well-paced, and unusually good at motivating before formalising. Figures are a strength (the AIG data structures, the elevator transition system, the guard/sticky rational-line diagram at `floating-point.tex:699-755`, the FP pipeline figures). Cross-referencing is consistent (`\cref` throughout) and the build resolves all references.

Issues:
- **Commented-out semantics figure (Required):** `multi-width-bv.tex:354-401` — restore or replace; the reader must be able to see the multi-width semantics.
- **93 overfull hboxes (Recommended):** for a submission build, a typographic pass is warranted; several are in the wide evaluation tables and inline Lean listings.
- **Whimsical epigraphs:** the *Alice in Wonderland* epigraphs are charming and thematically apt (finite domains, rabbit-holes). Acceptable; flagged only so the candidate can confirm the examiners' taste tolerates them.
- **Minor typos** spotted in passing: "theorey" (`lean-mlir.tex:561`), "numnber" (`mono-width-bv.tex:1378`), "incomparison" (`mono-width-bv.tex:1270`), "lossess" (`multi-width-bv.tex:645`), "affirmitively"/"soundess" (`floating-point.tex:1496`, `1315`). A full proofreading pass is expected for minor corrections.

---

## 8. Prioritised list of changes

### Required (for minor corrections)
1. **Re-calibrate the central claim.** Reword abstract, `introduction.tex:39-47`, `future-work.tex:30-42` so "constant factor" is defended asymptotically and the *magnitude* is stated honestly per domain (≈order of magnitude for BV core; ~33× for FP). Drop "small"/"rather than order-of-magnitude" where the measured factor is large.
2. **Restore the multi-width formal semantics** (`multi-width-bv.tex:354-401`); do not leave the flagship theorem stated against an unprinted semantics.
3. **Reconcile drifted numbers with the generated macros:** the "several times as many" → 1.5× (`multi-width-bv.tex:63-64`); "up to 27%" vs. the 31.3% best solver (`mono-width-bv.tex:67-68`, `1413`); audit all hardcoded quantitative prose against table values.
4. **Foreground the LLM-generated benchmark caveat** in the Ch. 5 evaluation body (not only limitations), and state clearly which headline numbers depend on it.
5. **Full proofreading pass** (typos above are a non-exhaustive sample).

### Recommended
6. Archive Ch. 5 and Ch. 6 artifacts with DOIs; state each solver's trusted base under its plot.
7. Report at least one measure of dispersion / run count for the timing claims.
8. Deduplicate bibliography keys (one key per work); fix 93 overfull boxes.
9. Add one sentence in Ch. 2 disambiguating exposition of `leanbv` from ownership.

---

## 9. Questions for the viva

1. **Central claim.** Your thesis statement contrasts "small constant factor" with "the order-of-magnitude slowdown usually assumed," yet your floating-point solver is 33× slower than Bitwuzla and `bv_decide` is itself ~10×. Defend the claim: is the durable contribution *asymptotic* (constant vs. exponential/unbounded), and if so, why keep the word "small"?

2. **Where does the 33× go?** Decompose the FP slowdown: how much is inherited from `bv_decide`'s BV engine, how much from missing SymFPU fast-paths (Sterbenz-style exactness), how much from kernel replay? Which is fixable in principle, and to what floor?

3. **Is the equisatisfiability theorem mechanized?** You state mechanized soundness/completeness for the *unbounded* solver and that the *bounded* reduction implementation is unverified (`multi-width-bv.tex:1149`). Is the equisatisfiability theorem (Thm 5.x) itself Lean-checked, or a paper proof? If paper-only, what is the risk that the implemented reduction diverges from the proven one?

4. **Unproven FP operations in the shipped solver.** The solver bitblasts round-to-integral, rem, and the integer conversions, which are unproven. On an UNSAT answer involving one of these, what exactly is trusted — the LRAT certificate certifies UNSAT *of a circuit you have not proven correct.* How should a user read such an answer?

5. **Bitmask wraparound.** In the bounded reduction, width variables become BV(o) values that can exceed o with wrapped masks. Argue precisely why this cannot produce an unsound "valid up to o" conclusion, and whether it can produce spurious counterexamples in the SAT direction.

6. **Sqrt specification.** You prove sqrt returns a value closer than either neighbour, but not that it *is* the square root, because you avoid the reals. What would it take to close this — the Mathlib reals instance of `ExtendedNumber`? — and why was staying Mathlib-free worth this weaker guarantee?

7. **Mono-width native compilation.** Your automata solver is evaluated interpreted because native compilation broke on current Lean/Mathlib. How much does this understate performance, and does it change any comparative conclusion against `bv_decide` or the MBA solver?

8. **Generalisation soundness (Ch. 5 benchmarks).** The LLM "clean generalization to parametric widths" is checked only to bound 8. Have you found any generalisation that is valid to 8 but false at a larger width? How would you detect one?

---

## 10. Summary

A genuinely unified, technically deep, and honestly presented thesis whose contributions — the width-as-bitmask reduction, the executable verified model-checking route to width-independent bitvector reasoning, and the first (scoped) verified floating-point bitblaster — clear the Cambridge PhD bar with room to spare. The mechanization is real and substantial, the evaluation is serious, and the limitations are — with two exceptions — stated with unusual candour. The required corrections are corrective, not remedial: the headline quantitative claim must be re-calibrated to the thesis's own measured numbers (chiefly the 33× floating-point slowdown, which contradicts "small factor" / "rather than order-of-magnitude"), a suppressed semantics figure must be restored, and drifted prose numbers must be reconciled with the generated evaluation data. With these fixed, this is a clear pass.

**Recommendation: Pass subject to minor corrections.**
