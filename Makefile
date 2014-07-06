TEX = main.tex
LABTEX = labworks.tex 

TEX += header.tex
LABTEX += header.tex

TEX += ARM.tex
TEX += STM32F1xx.tex
TEX += bib.tex
TEX += instide.tex
LABTEX += instide.tex
TEX += milandr.tex
TEX += workenv.tex
LABTEX += workenv.tex

TEXTMP = *.aux *.log *.dvi *.pdf *.ex *.out

.PHONY: all clean

all: labworks.pdf

clean:
	rm -f $(TEXTMP)

labworks.pdf: $(LABTEX)
	pdflatex labworks.tex
	pdflatex labworks.tex

main.pdf: $(TEX)
	pdflatex main.tex
	pdflatex main.tex

