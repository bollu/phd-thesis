.PHONY: clean all
all: lc.pdf lc.nowrap.tex

lc.pdf: lc.tex
	pdflatex lc.tex

lc.tex: lc.ott
	ott lc.ott -o lc.tex

lc.nowrap.tex: lc.ott
	ott lc.ott -o lc.nowrap.tex -tex_wrap false

clean:
	rm *.tex *.pdf || true

