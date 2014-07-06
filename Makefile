TEX = main.tex labworks.tex part.tex header.tex
TEX += ARM.tex
TEX += STM32F1xx.tex
TEX += bib.tex
TEX += instide.tex
TEX += milandr.tex
TEX += workenv.tex
TEX += devkitstruc.tex
TEX += labgitinstall.tex
TEX += labinstjava.tex
TEX += labinsteclipse.tex
TEX += labqemuinstall.tex
TEX += labdebianinst.tex
TEX += texinstall.tex
TEX += vcs.tex
TEX += labhello.tex
TEX += labecreprj.tex

TEXTMP = *.aux *.log *.dvi *.pdf *.ex *.out

.PHONY: all clean

all: part.pdf

clean:
	rm -f $(TEXTMP)

part.pdf: $(TEX)
	pdflatex part.tex
	pdflatex part.tex

labworks.pdf: $(TEX)
	pdflatex labworks.tex
	pdflatex labworks.tex

main.pdf: $(TEX)
	pdflatex main.tex
	pdflatex main.tex
