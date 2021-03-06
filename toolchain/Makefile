# Makefile для сборки своего тулчайна из исходников для Windows
# сборка выполняется под Linux по схеме "канадский крест"
# вменяемо реализовать _быструю_ сборку под win пока не удалось

# тройка канадского креста @build@ @host@ @target@
BUILD		= build
BUILD_CFG	= --disable-multilib	

HOST_CPU	= i686
HOST		= $(HOST_CPU)-mingw32
HOST_CFG	= --disable-multilib \
	--with-cpu=$(HOST_CPU) --with-tune=$(HOST_CPU)

TARGET		= arm-none-eabi
TARGET_CPU	= cortex-m3
TARGET_CFG	= --disable-multilib --disable-interwork \
	--with-cpu=$(TARGET_CPU) --with-tune=$(TARGET_CPU) --with-mode=thumb

# версии пакетов
BINUTILS_VER	= 2.24
GMP_VER			= 5.1.3
MPFR_VER		= 3.1.2
MPC_VER			= 1.0.2
GCC_VER			= 4.9.1
NEWLIB_VER		= 2.1.0
W32API_VER		= 4.0.3

# имена пакетов
BINUTILS	= binutils-$(BINUTILS_VER)
GMP			= gmp-$(GMP_VER)
MPFR		= mpfr-$(MPFR_VER)
MPC			= mpc-$(MPC_VER)
GCC			= gcc-$(GCC_VER)
NEWLIB		= newlib-$(NEWLIB_VER)
W32API		= w32api-$(W32API_VER)-1-mingw32-src

# рабочие каталоги
#	каталог для сборки и прочих временных файлов (рекомендуется в ramfs)
TMP = $(PWD)/tmp
#	сюда распаковываются исходники (ramfs)
SRC = $(PWD)/src
#	дистрибутивы исходников
GZ = $(PWD)/gz
#	каталоги бинарников для таргетов канадского креста
B = $(PWD)/$(BUILD)
H = $(PWD)/$(HOST)
T = $(PWD)/$(TARGET)
DIRS = $(TMP) $(B) $(H) $(T)
RAMBUILD = $(TMP)
PATH := $(B)/bin:$(PATH)

# параметры для configure

CCACHE = ccache
CC_B0 = $(CCACHE) gcc -pipe
CXX_B0 = $(CCACHE) g++ -pipe
CC_B = $(CCACHE) $(BUILD)-gcc -pipe
CXX_B = $(CCACHE) $(BUILD)-g++ -pipe

CFLAGS_B= -g0 -Ofast -march=native -mtune=native

CFG = configure --disable-nls
CFG_B0 = $(CFG) --prefix=$(B) CC="$(CC_B0)" CXX="$(CXX_B0)" \
	CFLAGS="$(CFLAGS_B)"
CFG_B  = $(CFG) --prefix=$(B) CC="$(CC_B)" CXX="$(CXX_B)" \
	CFLAGS="$(CFLAGS_B)"
CFG_H  = $(CFG) --prefix=$(H)
CFG_T  = $(CFG) --prefix=$(T)

CFG_B_CCLIBS = --with-gmp=$(B) --with-mpfr=$(B) --with-mpc=$(B)
CFG_B_GMP = $(CFG_B_CCLIBS) --disable-shared --enable-cxx 
CFG_B_MPFR = $(CFG_B_CCLIBS) --disable-shared
CFG_B_MPC = $(CFG_B_CCLIBS) --disable-shared

CFG_BINUTILS = --enable-lto --disable-werror 
CFG_B_BINUTILS = $(CFG_BINUTILS) --program-prefix=$(BUILD)- $(BUILD_CFG)
CFG_H_BINUTILS = $(CFG_BINUTILS) --program-prefix=$(HOST)- --target=$(HOST) $(HOST_CFG)
CFG_T_BINUTILS = $(CFG_BINUTILS) --program-prefix=$(TARGET)- --target=$(TARGET) $(TARGET_CFG)

CFG_GCC = --enable-languages="c,c++"
CFG_B_GCC = $(CFG_B_BINUTILS) $(CFG_B_CCLIBS) $(CFG_GCC) --disable-bootstrap
CFG_H_GCC = $(CFG_H_BINUTILS) $(CFG_B_CCLIBS) $(CFG_GCC) --disable-win32-registry	
CFG_T_GCC = $(CFG_T_BINUTILS) $(CFG_B_CCLIBS) $(CFG_GCC) --without-headers --with-newlib
#	--disable-libssp --disable-libquadmath

CFG_H_W32API = --host=$(HOST)

# команды
WGET = wget --no-check-certificate -N -P $(GZ)

NUMBER_OF_PROCESSORS ?= $(shell grep processor /proc/cpuinfo|wc -l)
MAKE = make -j$(NUMBER_OF_PROCESSORS)
INSTALL = make install-strip 

.PHONY: debianpackages all dirs distclean gz

# главная цель
all: distclean gz cclibs_b0 gcc_b0 cclibs_b binutils_b

# создание дерева каталогов
dirs:
	mkdir -p $(DIRS) $(GZ) $(SRC) 
# зачистка дерева каталогов
distclean:
	make dirs ; rm -rf $(TMP)/* $(BUILD)/* $(HOST)/* $(TARGET)/*

# установка пакетов нужных для сборки под Debian GNU/Linux
debianpackages:
	aptitude install make binutils gcc g++ m4 flex bison cvs

# закачка дистрибутивов пакетов в исходниках
gz:
	$(WGET) http://ftp.gnu.org/gnu/binutils/$(BINUTILS).tar.bz2
	$(WGET) ftp://ftp.gmplib.org/pub/gmp/$(GMP).tar.bz2
	$(WGET) http://www.mpfr.org/mpfr-current/$(MPFR).tar.bz2
	$(WGET) http://www.multiprecision.org/mpc/download/$(MPC).tar.gz
	$(WGET) http://gcc.skazkaforyou.com/releases/$(GCC)/$(GCC).tar.bz2
	$(WGET) ftp://sourceware.org/pub/newlib/$(NEWLIB).tar.gz
	$(WGET) http://downloads.sourceforge.net/project/mingw/MinGW/Base/w32api/w32api-$(W32API_VER)/$(W32API).tar.lzma

# правила распаковки исходников
$(SRC)/%/README: $(GZ)/%.tar.gz
	cd $(SRC) &&  zcat $< | tar x && touch $@
$(SRC)/%/README: $(GZ)/%.tar.bz2
	cd $(SRC) && bzcat $< | tar x && touch $@
$(SRC)/%/README: $(GZ)/%.tar.xz
	cd $(SRC) && xzcat $< | tar x && touch $@	

$(SRC)/$(W32API)/README: $(GZ)/$(W32API).tar.lzma
	cd $(SRC) && lzcat $< | tar x && \
	mv $(SRC)/w32api-$(W32API_VER)-1.mingw32-src $(SRC)/$(W32API) &&\
	touch $@	
	
.PHONY: src
src: cclibs_src gcc_src binutils_src

# сборка бинарников для $BUILD

# библиотеки поддержки для сборки gcc
.PHONY: cclibs_src
cclibs_src: $(SRC)/$(GMP)/README $(SRC)/$(MPFR)/README $(SRC)/$(MPC)/README
.PHONY: cclibs_b0 gmp_b0 mpfr_b0 mpc_b0
cclibs_b0: gmp_b0 mpfr_b0 mpc_b0
.PHONY: cclibs_b gmp_b mpfr_b mpc_b
cclibs_b: gmp_b mpfr_b mpc_b
gmp_b0: $(SRC)/$(GMP)/README
	rm -rf $(TMP)/$(GMP) && mkdir $(TMP)/$(GMP) && cd $(TMP)/$(GMP) &&\
	$(SRC)/$(GMP)/$(CFG_B0) $(CFG_B_GMP) && $(MAKE) && $(INSTALL) &&\
	rm -rf $(RAMBUILD)/$(GMP)
gmp_b: $(SRC)/$(GMP)/README
	rm -rf $(TMP)/$(GMP) && mkdir $(TMP)/$(GMP) && cd $(TMP)/$(GMP) &&\
	$(SRC)/$(GMP)/$(CFG_B) $(CFG_B_GMP) && $(MAKE) && $(INSTALL) &&\
	rm -rf $(RAMBUILD)/$(GMP)
mpfr_b0: $(SRC)/$(MPFR)/README
	rm -rf $(TMP)/$(MPFR) && mkdir $(TMP)/$(MPFR) && cd $(TMP)/$(MPFR) &&\
	$(SRC)/$(MPFR)/$(CFG_B0) $(CFG_B_MPFR) && $(MAKE) && $(INSTALL) &&\
	rm -rf $(RAMBUILD)/$(MPFR)
mpfr_b: $(SRC)/$(MPFR)/README
	rm -rf $(TMP)/$(MPFR) && mkdir $(TMP)/$(MPFR) && cd $(TMP)/$(MPFR) &&\
	$(SRC)/$(MPFR)/$(CFG_B) $(CFG_B_MPFR) && $(MAKE) && $(INSTALL) &&\
	rm -rf $(RAMBUILD)/$(MPFR)
mpc_b0: $(SRC)/$(MPC)/README
	rm -rf $(TMP)/$(MPC) && mkdir $(TMP)/$(MPC) && cd $(TMP)/$(MPC) &&\
	$(SRC)/$(MPC)/$(CFG_B0) $(CFG_B_MPC) && $(MAKE) && $(INSTALL) &&\
	rm -rf $(RAMBUILD)/$(MPC)
mpc_b: $(SRC)/$(MPC)/README
	rm -rf $(TMP)/$(MPC) && mkdir $(TMP)/$(MPC) && cd $(TMP)/$(MPC) &&\
	$(SRC)/$(MPC)/$(CFG_B) $(CFG_B_MPC) && $(MAKE) && $(INSTALL) &&\
	rm -rf $(RAMBUILD)/$(MPC)

# $(BUILD)-toolchain
.PHONY: binutils_src binutils_b binutils_bb binutils_bh binutils_bt
binutils_src: $(SRC)/$(BINUTILS)/README
binutils_b: binutils_bb binutils_bh binutils_bt
binutils_bb: $(SRC)/$(BINUTILS)/README
	# >B
	rm -rf $(TMP)/$(BINUTILS) && mkdir $(TMP)/$(BINUTILS) && cd $(TMP)/$(BINUTILS) &&\
	$(SRC)/$(BINUTILS)/$(CFG_B) $(CFG_B_BINUTILS) && $(MAKE) && $(INSTALL) &&\
	rm -rf $(RAMBUILD)/$(BINUTILS)
binutils_bh: $(SRC)/$(BINUTILS)/README
	# >H
	rm -rf $(TMP)/$(BINUTILS) && mkdir $(TMP)/$(BINUTILS) && cd $(TMP)/$(BINUTILS) &&\
	$(SRC)/$(BINUTILS)/$(CFG_B) $(CFG_H_BINUTILS) && $(MAKE) && $(INSTALL) &&\
	rm -rf $(RAMBUILD)/$(BINUTILS)
binutils_bt: $(SRC)/$(BINUTILS)/README
	# >T
	rm -rf $(TMP)/$(BINUTILS) && mkdir $(TMP)/$(BINUTILS) && cd $(TMP)/$(BINUTILS) &&\
	$(SRC)/$(BINUTILS)/$(CFG_B) $(CFG_T_BINUTILS) && $(MAKE) && $(INSTALL) &&\
	rm -rf $(RAMBUILD)/$(BINUTILS)

.PHONY: gcc_src gcc_b gcc_b0 gcc_bb gcc_bh cc_bt
gcc_src: $(SRC)/$(GCC)/README
gcc_b: gcc_bb gcc_bh cc_bt
gcc_b0: $(SRC)/$(GCC)/README
	# >B0
	rm -rf $(TMP)/$(GCC) && mkdir $(TMP)/$(GCC) && cd $(TMP)/$(GCC) &&\
	$(SRC)/$(GCC)/$(CFG_B0) $(CFG_B_GCC) && $(MAKE) && $(INSTALL) &&\
	rm -rf $(RAMBUILD)/$(GCC)
gcc_bb: $(SRC)/$(GCC)/README
	# >B
	rm -rf $(TMP)/$(GCC) && mkdir $(TMP)/$(GCC) && cd $(TMP)/$(GCC) &&\
	$(SRC)/$(GCC)/$(CFG_B) $(CFG_B_GCC) && $(MAKE) && $(INSTALL) &&\
	rm -rf $(RAMBUILD)/$(GCC)
gcc_bh: $(SRC)/$(GCC)/README
	# >H
	rm -rf $(TMP)/$(GCC) && mkdir $(TMP)/$(GCC) && cd $(TMP)/$(GCC) &&\
	$(SRC)/$(GCC)/$(CFG_B) $(CFG_H_GCC) && $(MAKE) && $(INSTALL) &&\
	rm -rf $(RAMBUILD)/$(GCC)
gcc_bt: $(SRC)/$(GCC)/README
	# >T
	rm -rf $(TMP)/$(GCC) && mkdir $(TMP)/$(GCC) && cd $(TMP)/$(GCC) &&\
	$(SRC)/$(GCC)/$(CFG_B) $(CFG_T_GCC) && $(MAKE) && $(INSTALL) &&\
	rm -rf $(RAMBUILD)/$(GCC)

w32api: $(SRC)/$(W32API)/README
	rm -rf $(TMP)/$(W32API) && mkdir $(TMP)/$(W32API) && cd $(TMP)/$(W32API) &&\
	$(SRC)/$(W32API)/$(CFG_H) $(CFG_H_W32API) && make 

armkit: $(TARGET)/generic.ld \
	$(TARGET)/STM32F100RB.ld $(TARGET)/LM3S811.ld \
	$(TARGET)/startup.c $(TARGET)/vectors.h
$(TARGET)/%: ../hello/%
	iconv -f cp1251 -t utf8 $< > $@

