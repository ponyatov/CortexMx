pdf: main.pdf

main.pdf: main.tex STM32F1xx.tex
	pdflatex main.tex
	pdflatex main.tex
