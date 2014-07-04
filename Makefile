TEX = partial.tex main.tex header.tex workenv.tex STM32F1xx.tex \
ARM.tex milandr.tex bib.tex

TEXTMP = *.aux *.log *.dvi *.pdf *.ex *.out

.PHONY: all clean
all: 
	pdflatex partial.tex
	pdflatex partial.tex

clean:
	rm -f $(TEXTMP)

main.pdf: $(TEX)
	pdflatex main.tex
	pdflatex main.tex

partial.pdf: $(TEX)
	pdflatex partial.tex
	pdflatex partial.tex
	