# Build via latexmk; configuration lives in .latexmkrc.

all:
	latexmk thesis.tex

watch:
	latexmk -pvc thesis.tex

clean:
	latexmk -C
	rm -rf _minted-thesis

.PHONY: all watch clean
