# Makefile for LaTeX project
LATEX=pdflatex
BIBTEX=biber
MAIN=tesi

all: clean compile

compile:
	$(LATEX) $(MAIN).tex
	$(BIBTEX) $(MAIN)
	$(LATEX) $(MAIN).tex
	$(LATEX) $(MAIN).tex

clean:
	rm -f *.aux *.bbl *.blg *.log *.out *.toc *.lof *.lot *.bcf *.run.xml *.fdb_latexmk *.fls

.PHONY: all clean compile
