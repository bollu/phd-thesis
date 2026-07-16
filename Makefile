# Build via latexmk; configuration lives in .latexmkrc.

all:
	latexmk thesis.tex

# Submission build: thesis-submission.pdf, with draft \sid/\grosser notes disabled.
submission:
	latexmk thesis-submission.tex

# Draft + submission.
both: all submission

watch:
	latexmk -pvc thesis.tex

clean:
	latexmk -C
	latexmk -C thesis-submission.tex
	rm -rf _minted-thesis

.PHONY: all submission both watch clean
