# Build helpers for the UPC paper skeleton.
#   make            compile, then run the checks
#   make pdf        also copy to <team><letter>.pdf for submission
#   make figs       regenerate figures from code/
#   make clean      remove LaTeX by-products (keeps main.pdf)
# TEAM and PROBLEM are read from config.tex, so there is one source of truth.

MAIN    := main.tex
TEAM    := $(shell sed -n 's/^\\newcommand{\\teamnum}{\([^}]*\)}.*/\1/p' config.tex)
PROBLEM := $(shell sed -n 's/^\\newcommand{\\problemltr}{\([^}]*\)}.*/\1/p' config.tex)
SUBMIT  := $(TEAM)$(PROBLEM).pdf
-include local.mk
SKILL   ?= ../..
LATEXMK_FLAGS := -pdf -interaction=nonstopmode -halt-on-error -file-line-error -synctex=1

.PHONY: all build check words figs pdf demo clean

all: build check

build:
	latexmk $(LATEXMK_FLAGS) $(MAIN)

check: build
	@test -f $(SKILL)/scripts/check_pdf.py || { echo "cannot find the upc-paper scripts at $(SKILL); set SKILL in local.mk"; exit 1; }
	python3 $(SKILL)/scripts/check_pdf.py main.pdf --team $(TEAM) --problem $(PROBLEM)
	python3 $(SKILL)/scripts/count_summary.py main.tex --tex

words:
	python3 $(SKILL)/scripts/count_summary.py $(MAIN) --tex

figs:
	python3 scripts/make_example_fig.py

# Rebuild the sample PDF with the AI-disclosure section visible.
# Your own builds follow config.tex, where the switch is off.
demo:
	latexmk $(LATEXMK_FLAGS) -g -usepretex='\def\AIREPORTDEMO{}' $(MAIN)

pdf: check
	cp main.pdf $(SUBMIT)
	@echo "wrote $(SUBMIT) -- check the name against the rules for your year"

clean:
	latexmk -c $(MAIN)
	rm -f main.bbl main.run.xml main.synctex.gz
