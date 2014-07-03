TEX = main.tex header.tex workenv.tex STM32F1xx.tex ARM.tex
TEXTMP = *.aux *.log *.dvi *.pdf *.ex *.out

all: pdf
pdf: main.pdf

clean:
	rm -f $(TEXTMP)

main.pdf: $(TEX)
	pdflatex main.tex
	pdflatex main.tex
