TEX = main.tex STM32F1xx.tex ARM.tex

pdf: main.pdf

main.pdf: $(TEX)
	pdflatex main.tex
	pdflatex main.tex
