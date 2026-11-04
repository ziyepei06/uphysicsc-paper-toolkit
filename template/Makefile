# Build helpers for the UPC paper template (standalone: no external skill).
#   make            compile, then run the checks
#   make pdf        also copy to <team><letter>.pdf for submission
#   make figs       regenerate figures from code/
#   make check      checks only (after a successful build)
#   make clean      remove LaTeX by-products (keeps the PDF)
# TEAM and PROBLEM are parsed from config.tex, so there is one source of truth.

MAIN    := main.tex
TEAM    := $(shell sed -n 's/^\\newcommand{\\teamnum}{\([^}]*\)}.*/\1/p' config.tex)
PROBLEM := $(shell sed -n 's/^\\newcommand{\\problemltr}{\([^}]*\)}.*/\1/p' config.tex)
SUBMIT  := $(TEAM)$(PROBLEM).pdf
LATEXMK_FLAGS := -pdf -interaction=nonstopmode -halt-on-error -file-line-error -synctex=1

.PHONY: all build check words figs pdf demo clean

all: build check

build:
	latexmk $(LATEXMK_FLAGS) $(MAIN)

check:
	python3 tools/check_pdf.py main.pdf --team $(TEAM) --problem $(PROBLEM)
	python3 tools/count_summary.py main.tex --tex

words:
	python3 tools/count_summary.py $(MAIN) --tex

figs:
	python3 scripts/make_example_fig.py

# Rebuild the committed sample 000A.pdf with the AI-disclosure section visible.
# Your own builds use config.tex, where the switch is off.
demo:
	latexmk $(LATEXMK_FLAGS) -g -usepretex='\def\AIREPORTDEMO{}' $(MAIN)
	cp main.pdf 000A.pdf
	@echo "wrote 000A.pdf (AI section on)"

pdf: all
	cp main.pdf $(SUBMIT)
	@echo "wrote $(SUBMIT) -- check the name against the rules for your year"

clean:
	latexmk -c $(MAIN)
	rm -f main.bbl main.run.xml main.synctex.gz
