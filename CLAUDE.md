# Thesis writing guide

## Model of style: Schulman, *Optimizing Expectations* (the "TRPO thesis")

The reference the author admires is John Schulman's 2016 Berkeley dissertation.
When drafting or restructuring a chapter, imitate the following. These are
descriptions of what that thesis actually does, not generic advice.

### Chapter skeleton (repeated identically in every chapter)

1. `Overview` — a self-contained chapter abstract.
2. `Preliminaries` — every definition and piece of notation the chapter needs,
   in one place, before any argument starts.
3. Idealized theory — the result that is true but impractical.
4. Practical algorithm — the approximations, made explicit.
5. Connections with prior work — **after** the method, never before.
6. Evaluation.
7. `Discussion` — short, honest, restates proved-vs-measured.
8. Proofs, parameter tables, and extra plots as *numbered sections at the end of
   the same chapter*, not in a global appendix. TRPO's chapter 3 runs §3.1–§3.9
   as the readable chapter and §3.10–§3.15 as its own appendix.

Chapter 4 additionally has a `Frequently Asked Questions` section that answers,
by name, the objections a hostile reader would raise ("Why Don't You Just Use a
Q-Function?"). Use this when a chapter has a standing "but why didn't you just…".

### The Overview section

Two paragraphs, essentially no citations. Paragraph one: the question this
chapter answers, where it sits in the thesis argument ("As we argued in the
Introduction…"), and the result in one plain sentence. Paragraph two: "Following
this theoretical analysis, we make a series of approximations to the
theoretically-justified algorithm, yielding a practical algorithm…", then the
empirical payoff. A reader who stops after the Overview knows the chapter.

### Reconciling the theory with what was built

The signature move, and note that TRPO gives it **no heading at all**. It is an
unnamed bulleted list at the tail of §3.6 *Practical Algorithm*, immediately
before *Connections with Prior Work*, introduced by one sentence:

> Let us briefly summarize the relationship between the theory from Section 3.3
> and the practical algorithm we have described:

Three bullets follow. Each names one guarantee that was weakened, why it had to
be, and what replaced it ("the large penalty coefficient leads to prohibitively
small steps, so we use a hard constraint instead of a penalty"). Do not invent a
section heading for this. It belongs inside whichever section presents the
finished artifact, so the reader meets the caveats while the algorithm is still
in front of them. Never let the gap between the theorem and the artifact be
discovered by the reader in a footnote.

### Evaluation framed as questions

"We designed our experiments to investigate the following questions: 1. … 2. …
3. …" Then say which experiment answers which, and answer them in order.
Negative results are stated flatly and without apology — "we could not obtain
error statistics due to time constraints"; "While our method only outperformed
the prior methods on some of the games, it consistently achieved reasonable
scores."

### Prose at the paragraph level

- The argument spine is a chain of numbered equations. Each paragraph performs
  exactly one transformation and says why. The connective sentences alone should
  carry the derivation: "Note that $L_\pi$ uses the visitation frequency
  $\rho_\pi$ rather than $\rho_{\tilde\pi}$, ignoring changes in state visitation
  density due to changes in the policy."
- Every definition is immediately followed by an intuition sentence, usually
  opening "Intuitively," or "The intuitive interpretation is that…".
- A boxed `Note:` aside carries scope caveats that would otherwise derail the
  main line (TRPO p.13 boxes the whole fixed-vs-variable trajectory-length
  question).
- Figure captions are long and self-contained: they say what to notice, not what
  the picture is.

### Sentence level

- First person plural, present tense, short declaratives. No throat-clearing, no
  hedging adverbs.
- Technical terms italicized at first use, and named things get one memorable
  word plus the reason for it: "We use the term *vine*, since the trajectories
  used for sampling can be likened to the stems of vines."
- Each chapter ends by pointing at the next one. The background chapter closes
  "The next two chapters improve on the vanilla policy gradient method in two
  orthogonal ways."

## Author's own voice (keep alongside the above)

- Model prose on `frontmatter/abstract.tex` and the FP paper: rhetorical-question
  pivots, mixed I/we, concrete hooks, semicolons.
- `\cref` never as a sentence subject — put it in parentheses or mid-sentence.
  Prose must read correctly with every reference erased.
- Epigraphs are wry and literary, not grand engineering aphorisms. Verify exact
  wording before proposing one.
- Never claim the verification price is "a constant factor, not asymptotic" —
  there is no size sweep behind that claim.
