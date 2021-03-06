TARGFILE = part.pdf

TEX = main.tex labworks.tex part.tex header.tex
TEX += ARM.tex
TEX += bib.tex
TEX += instide.tex
TEX += workenv.tex
TEX += devkitstruc.tex
TEX += labgitinstall.tex
TEX += labinstjava.tex
TEX += eclipse/labinsteclipse.tex
TEX += labqemuinstall.tex
TEX += labdebianinst.tex
TEX += texinstall.tex
TEX += vcs.tex
TEX += labhello.tex
TEX += labecreprj.tex
TEX += labmkmake.tex

TEX += tmp/hello.mk
TEX += hello/startup.S
TEX += hello/init.c
TEX += hello/main.c

TEX += labgnuchain.tex
TEX += labgnuwinstall.tex
TEX += labgdbinst.tex labqemuecl.tex
TEX += lstlangarm.sty lstlanggnuld.sty lstlanggnudump.sty
TEX += mktoolchain.tex tmp/toolchain.mk
TEX += labinststsoft.tex

TEX += eclipse/eclipse.tex
TEX += eclipse/labinsteclipse.tex
TEX += eclipse/EclipseMain.png
TEX += eclipse/EclipseSplash.png
TEX += eclipse/eclperpective.png

DUOLOS = duolos_CMSIS/duolos.tex header.tex bib.tex
DUOLOS += duolos_CMSIS/cmsisstruc.png 
DUOLOS += duolos_CMSIS/cmsisdevcosts.png
DUOLOS += duolos_CMSIS/ITMshot.png
DUOLOS += duolos_CMSIS/simplecmsis.png
DUOLOS += duolos_CMSIS/stm32.png


tmp/%.mk: %/Makefile
	cp $< $@

TEXTMP = *.aux *.log *.dvi *.pdf *.ex *.out

.PHONY: all clean
all: $(TARGFILE)

clean:
	rm -f $(TEXTMP)
	
duolos.pdf: $(DUOLOS)
	pdflatex duolos_CMSIS/duolos.tex

part.pdf: $(TEX)
	pdflatex part.tex
	pdflatex part.tex

labworks.pdf: $(TEX)
	pdflatex labworks.tex
	pdflatex labworks.tex

main.pdf: $(TEX)
	pdflatex main.tex
	pdflatex main.tex

	
