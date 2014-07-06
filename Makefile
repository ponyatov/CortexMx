TEX = main.tex labworks.tex header.tex
TEX += ARM.tex
TEX += STM32F1xx.tex
TEX += bib.tex
TEX += instide.tex
TEX += milandr.tex
TEX += workenv.tex
TEX += devkitstruc.tex
TEX += labinstjava.tex
TEX += labinsteclipse.tex

TEXTMP = *.aux *.log *.dvi *.pdf *.ex *.out

.PHONY: all clean

all: labworks.pdf

clean:
	rm -f $(TEXTMP)

labworks.pdf: $(TEX)
	pdflatex labworks.tex
	pdflatex labworks.tex

main.pdf: $(TEX)
	pdflatex main.tex
	pdflatex main.tex

