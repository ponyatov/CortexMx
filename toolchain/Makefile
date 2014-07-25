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
PPL_VER			= 0.11
#CLOOG_VER		= 0.18.2
#CLOOG_VER		= 0.15.11
#ISL_VER		= 0.12.2
GCC_VER			= 4.9.1
NEWLIB_VER		= 2.1.0
W32API_VER		= 4.0.3

# имена пакетов
BINUTILS	= binutils-$(BINUTILS_VER)
GMP			= gmp-$(GMP_VER)
MPFR		= mpfr-$(MPFR_VER)
MPC			= mpc-$(MPC_VER)
PPL			= ppl-$(PPL_VER)
#CLOOG		= cloog-$(CLOOG_VER)
#CLOOG		= cloog-ppl-$(CLOOG_VER)
#ISL		= isl-$(ISL_VER)
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
DIRS = $(TMP) $(SRC) $(B) $(H) $(T)

# параметры для configure

CC_B = ccache gcc -pipe
CXX_B = ccache g++ -pipe
CFLAGS_B = -Ofast -march=native -mtune=native
CXXFLAGS_B = $(CFLAGS_B)

CFG = configure --disable-nls
CFG_B = $(CFG) --prefix=$(B) \
	CC="$(CC_B)" CFLAGS="$(CFLAGS_B)" \
	CXX="$(CXX_B)" CXXFLAGS="$(CXXFLAGS_B)"
CFG_H = $(CFG) --prefix=$(H)
CFG_T = $(CFG) --prefix=$(T)

CFG_B_CCLIBS = --with-gmp=$(B) --with-mpfr=$(B) --with-mpc=$(B)
#	--with-ppl=$(B) --with-cloog=$(B) --with-isl=$(B)
CFG_B_GMP = $(CFG_B_CCLIBS) --disable-shared --enable-cxx
CFG_B_MPFR = $(CFG_B_CCLIBS) --disable-shared
CFG_B_MPC = $(CFG_B_CCLIBS) --disable-shared
#CFG_B_PPL = $(CFG_B_CCLIBS) --disable-shared
#CFG_B_CLOOG = $(CFG_B_CCLIBS) --disable-shared 
#--with-gmp=build --with-gmp-prefix=$(B)
#CFG_B_ISL = $(CFG_B_CCLIBS) --disable-shared --with-gmp=build --with-gmp-prefix=$(B)

CFG_BINUTILS = --enable-lto
#--enable-cloog-back-end=isl
CFG_B_BINUTILS = $(CFG_BINUTILS) --program-prefix=$(BUILD)- $(BUILD_CFG)
CFG_H_BINUTILS = $(CFG_BINUTILS) --program-prefix=$(HOST)- --target=$(HOST) $(HOST_CFG)
CFG_T_BINUTILS = $(CFG_BINUTILS) --program-prefix=$(TARGET)- --target=$(TARGET) $(TARGET_CFG)

CFG_GCC = --enable-languages="c"	
CFG_B_GCC = $(CFG_GCC) $(CFG_B_BINUTILS) $(CFG_B_CCLIBS) --disable-bootstrap
CFG_H_GCC = $(CFG_GCC) $(CFG_H_BINUTILS) $(CFG_B_CCLIBS) --disable-win32-registry	
CFG_T_GCC = $(CFG_GCC) $(CFG_T_BINUTILS) $(CFG_B_CCLIBS) --without-headers --with-newlib
#	--disable-libssp --disable-libquadmath \

# команды
WGET = wget --no-check-certificate -N -P $(GZ)

NUMBER_OF_PROCESSORS ?= $(shell grep processor /proc/cpuinfo|wc -l)
MAKE = make -j$(NUMBER_OF_PROCESSORS)
INSTALL = make install-strip 

.PHONY: debianpackages all dirs distclean gz

# главная цель
all:

# создание дерева каталогов
dirs:
	mkdir -p $(DIRS) $(GZ)
# зачистка дерева каталогов
distclean:
	make dirs ; rm -rf $(TMP)/* $(SRC)/* $(BUILD)/* $(HOST)/* $(TARGET)/*

# установка пакетов нужных для сборки под Debian GNU/Linux
debianpackages:
	aptitude install make binutils gcc g++ m4 flex bison cvs

# закачка дистрибутивов пакетов в исходниках
gz:
	exit 1
	$(WGET) http://ftp.gnu.org/gnu/binutils/$(BINUTILS).tar.bz2
	$(WGET) ftp://ftp.gmplib.org/pub/gmp/$(GMP).tar.bz2
	$(WGET) http://www.mpfr.org/mpfr-current/$(MPFR).tar.bz2
	$(WGET) http://www.multiprecision.org/mpc/download/$(MPC).tar.gz
	$(WGET) http://gcc.skazkaforyou.com/releases/$(GCC)/$(GCC).tar.bz2
	$(WGET) ftp://sourceware.org/pub/newlib/$(NEWLIB).tar.gz
	$(WGET) http://downloads.sourceforge.net/project/mingw/MinGW/Base/w32api/w32api-$(W32API_VER)/$(W32API).tar.lzma
#	$(WGET) http://bugseng.com/products/ppl/download/ftp/releases/$(PPL_VER)/$(PPL).tar.bz2
#	$(WGET) ftp://gcc.gnu.org/pub/gcc/infrastructure/$(CLOOG).tar.gz
#	$(WGET) http://www.bastoul.net/cloog/pages/download/$(CLOOG).tar.gz
#	$(WGET) ftp://gcc.gnu.org/pub/gcc/infrastructure/$(ISL).tar.bz2
#	$(WGET) ftp://gcc.gnu.org/pub/gcc/infrastructure/$(PPL).tar.gz

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

# сборка бинарников для $BUILD

# библиотеки поддержки для сборки gcc
.PHONY: gmp_b mpfr_b mpc_b cclibs_b
cclibs_b: gmp_b mpfr_b mpc_b
gmp_b: $(SRC)/$(GMP)/README
	rm -rf $(TMP)/$(GMP) && mkdir $(TMP)/$(GMP) && cd $(TMP)/$(GMP) &&\
	$(SRC)/$(GMP)/$(CFG_B) $(CFG_B_GMP) && $(MAKE) && $(INSTALL)
mpfr_b: $(SRC)/$(MPFR)/README
	rm -rf $(TMP)/$(MPFR) && mkdir $(TMP)/$(MPFR) && cd $(TMP)/$(MPFR) &&\
	$(SRC)/$(MPFR)/$(CFG_B) $(CFG_B_MPFR) && $(MAKE) && $(INSTALL)
mpc_b: $(SRC)/$(MPC)/README
	rm -rf $(TMP)/$(MPC) && mkdir $(TMP)/$(MPC) && cd $(TMP)/$(MPC) &&\
	$(SRC)/$(MPC)/$(CFG_B) $(CFG_B_MPC) && $(MAKE) && $(INSTALL)
#ppl_b: $(SRC)/$(PPL)/README
#	rm -rf $(TMP)/$(PPL) && mkdir $(TMP)/$(PPL) && cd $(TMP)/$(PPL) &&\
#	$(SRC)/$(PPL)/$(CFG_B) $(CFG_B_PPL) && $(MAKE) && $(INSTALL)
#cloog_b: $(SRC)/$(CLOOG)/README
#	rm -rf $(TMP)/$(CLOOG) && mkdir $(TMP)/$(CLOOG) && cd $(TMP)/$(CLOOG) &&\
#	$(SRC)/$(CLOOG)/$(CFG_B) $(CFG_B_CLOOG) 
#	&& $(MAKE) && $(INSTALL)
#isl_b: $(SRC)/$(ISL)/README
#	rm -rf $(TMP)/$(ISL) && mkdir $(TMP)/$(ISL) && cd $(TMP)/$(ISL) &&\
#	$(SRC)/$(ISL)/$(CFG_B) $(CFG_B_ISL) 
#	&& $(MAKE) && $(INSTALL)

# $(BUILD)-toolchain
.PHONY: binutils_b gcc_b
binutils_b: $(SRC)/$(BINUTILS)/README
	# >B
	rm -rf $(TMP)/$(BINUTILS) && mkdir $(TMP)/$(BINUTILS) && cd $(TMP)/$(BINUTILS) &&\
	$(SRC)/$(BINUTILS)/$(CFG_B) $(CFG_B_BINUTILS) && $(MAKE) && $(INSTALL)
	# >H
	rm -rf $(TMP)/$(BINUTILS) && mkdir $(TMP)/$(BINUTILS) && cd $(TMP)/$(BINUTILS) &&\
	$(SRC)/$(BINUTILS)/$(CFG_B) $(CFG_H_BINUTILS) && $(MAKE) && $(INSTALL)
	# >T
	rm -rf $(TMP)/$(BINUTILS) && mkdir $(TMP)/$(BINUTILS) && cd $(TMP)/$(BINUTILS) &&\
	$(SRC)/$(BINUTILS)/$(CFG_B) $(CFG_T_BINUTILS) && $(MAKE) && $(INSTALL)

gcc_b: $(SRC)/$(GCC)/README
	# >T
	rm -rf $(TMP)/$(GCC) && mkdir $(TMP)/$(GCC) && cd $(TMP)/$(GCC) &&\
	$(SRC)/$(GCC)/$(CFG_B) $(CFG_T_GCC) && $(MAKE) && $(INSTALL)
	exit 1
	# >B
	rm -rf $(TMP)/$(GCC) && mkdir $(TMP)/$(GCC) && cd $(TMP)/$(GCC) &&\
	$(SRC)/$(GCC)/$(CFG_B) $(CFG_B_GCC) && $(MAKE) && $(INSTALL)

w32api: $(SRC)/$(W32API)/README
	cp -r $(SRC)/$(W32API)/include $(H)/
