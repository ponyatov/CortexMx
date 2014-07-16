TARGET = arm-none-eabi
TCNAME = cortex

TC = /c/ARM/$(TCNAME)

WGET = wget -N -P gz

GZ = $(PWD)/gz
SRC = $(PWD)/src
TMP = $(PWD)/tmp

DIRS = $(SRC) $(TMP) $(TC)

dirs:
	mkdir -p $(GZ) $(DIRS)
distclean:
	rm -rf $(DIRS)
	make dirs

gz:
	$(WGET) 