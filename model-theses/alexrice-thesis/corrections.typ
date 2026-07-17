#import "@preview/rubber-article:0.1.0": *

#show: article.with()
#set text(lang: "en")

#maketitle(
  title: [ Corrections ],
  authors: (
    "Alex Rice",
  ),
  date: "November 2024", )

The table below contains a list of all corrections made, listing the position of the correction in the original document and in the corrected document. I also note whether each correction was given by the Internal or External examiner, and mark any other changes by other.
#table(
  columns: (1fr, auto, auto, auto),
  inset: 5pt,
  align: horizon,
  table.header(
    [*Correction*], [*Original\ location*], [*New\ location*], [*Examiner*]
  ),
  [ Fixed PSE rule ], [ figure 1.3, p36 ], [ figure 1.3, p36 ], [ Internal\ + External ],
  [ Replaced $g: x op(->, limits: #false)_* y$ with $g : y op(->, limits: #false)_* z$ ], [ example 1.2.3, p36 ], [ example 1.2.4, p36 ], [Internal],
  [ Swap which morphisms are source and target morphisms ], [Definition 1.1.6, p26], [Definition 1.1.6, p26], [Internal],
  [ Replace "globular category" by "globular structure"], [Definition 1.1.6, p26\ Definition 1.1.7, p26\ p191], [Definition 1.1.6, p26\ Definition 1.1.7, p26\ p191], [Internal],
  [ Add a sentence to clarify that the author does not know of a more general definition of coherator which contains both Gr-coherators and cat-coherators ], [Remark 1.1.11, p32], [Remark 1.1.11, p32], [Internal],
  [ Added example of boundary set ], [N/A], [Example 2.3.7, p55], [Internal],
  [ Add sentence on the direction of morphisms, giving a link to remark 1.2.1], [Definition 2.4.17, p68], [Definition 2.4.17, p68], [Internal],
  [ Add paragraph explaining comp and id constructors in implementation ], [N/A], [Paragraph 2, p179], [Internal],
  [ Add a paragraph to the typechecking section explaining the addition of path variables (such as p0) ], [N/A], [p186], [Internal],

  [ Make it clear we are talking about the models of higher categorise in background section by adding the words "models of" ], [Section 1.1, p19], [Section 1.1, p19], [External],
  [ Fix the definition of "codimension", motivating the terminology by comparison to the codimension of a vector subspace ], [Bottom of p20], [Bottom of p20], [External],
  [ Disc contexts -> disc globular sets as contexts have not been defined at this point ], [Bottom of p24], [Bottom of p24], [External],
  [ changed exponentially -> rapidly to suggest that this is a qualitative rather than precise statement ], [p29], [p29], [External],
  [ "Weakly contractible" -> "contractible"], [p29 l. -3], [near bottom, p29], [External],
  [ Typo in guiding principle for categories (equivalences) f/P ], [p31], [p31], [External],
  [ Catt contexts only contain finite globular sets instead of all globular sets ], [p33], [p33], [External],
  [ Changed fibred -> indexed by ], [Throughout], [Throughout], [External],
  [ Add warning for dimension of sphere ], [p49], [p49], [External],
  [ Fix definition of operation set (element of -> collection of triples of type) ], [p54], [p54], [External],
  [ "to piece of syntax" -> "to a piece of syntax"], [l1, p62], [middle of p62], [External],
  [ typo B/A ], [Proposition 2.4.6, p63], [Proposition 2.4.6,\ bottom of p63], [External],
  [ typo t/s ], [Corollary 2.4.9, p64], [Corollary 2.4.9, p65], [External],
  [ typo attention to _the_ typing premise ], [p70], [p70], [External],
  [ Missing "Peak" in rules for Dyck peaks ], [Definition 3.1.6, p86], [Definition 3.1.6, p86], [External],
  [ Missing $n-1$ ], [ Proposition 3.1.16, p90], [ Proposition 3.1.16, p90], [External],
  [ Tree depth -> Tree height ], [Def 3.2.2, p94\ throughout], [Def 3.2.2, p94\ throughout], [External],
  [ Reword "Trees are defined ... as binary trees" to saying "Trees are binary"], [Rem 3.2.3, p 95],[Rem 3.2.3, p 95], [External],
  [ Swap chosen points for wedge sum is the _snd_ of the first context and _fst_ of the second context ], [bottom of p95],[bottom of p95],[External],
  [ Add "by induction" ], [Def 3.2.5, p95], [Def 3.2.5, p95], [External],
  [ Replace inclusion by inl and inr ], [Throughout], [Throughout], [External],
  [ Fix definition of (m,n)-category ], [p11], [p11], [Other],
  [ Fix unmatched parenthesis ], [p195], [p196], [Other],
  [ Make sure statements are always in brackets and add links ], [p194], [p194], [Other],
  [ External substitution -> External labelling ], [p178], [p178], [Other],
  [ Typo replace downarrow with up arrow ], [Def 4.4.2\ l3 p182],[Def 4.4.2\ l3 p182],[Other],
  [ Fix colours for evaluation ], [Paragraph starting\ "we define", p182], [Paragraph starting\ "we define", p182], [Other],
  [ metavariables -> meta-variables ], [p190], [p190], [Other],
  [ typo: B -> B_0 ], [Fig 4.3, p187], [Fig 4.3, p187], [Other],
  [ Syntactic depth -> Syntactic complexity ], [Pf of Lem 4.3.10\ p170], [Pf of Lem 4.3.10\ p170], [Other],
  [ Arrow not properly subscripted ], [Definition 3.1.6, p86], [Definition 3.1.6, p86], [Other],
  [ The descriptions of type-checking rules now point to the correct rule ], [p186], [p186], [Other]
)
