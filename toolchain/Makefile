# Makefile для сборки своего тулчайна из исходников под Windows (MinGW+MSYS)

# целевая архитектура для Cortex-M
TARGET = arm-none-eabi
# настройки для целевого процессора Cortex-M
CFG_CPU = --disable-interwork --disable-multilib --with-cpu=cortex-m3
# название тулчейна
TCNAME = cortex
# путь установки в формате MSYS
TC = /c/ARM/$(TCNAME)
# пусть установке в формате Windows
TCPATH = C:\ARM\$(TCNAME)

# версии пакетов: при желании обновиться корректировать здесь
BINUTILS_VER = 2.24
GMP_VER = 5.1.3
MPFR_VER = 3.1.2
MPC_VER = 1.0.2
GCC_VER = 4.8.3

# имена пакетов (с версиями)
BINUTILS = binutils-$(BINUTILS_VER)
GMP = gmp-$(GMP_VER)
MPFR = mpfr-$(MPFR_VER)
MPC = mpc-$(MPC_VER)
GCC = gcc-$(GCC_VER)

# команды
WGET = wget -N -P gz
MAKE = mingw32-make -j$(NUMBER_OF_PROCESSORS)
INSTALL = mingw32-make install-strip 

# временные каталоги
GZ = $(PWD)/gz
SRC = $(PWD)/src
TMP = $(PWD)/tmp
DIRS = $(SRC) $(TMP) $(TC)

# параметры конфигурации, здесь нужно аккуратно следить за опциями сборки
# очень вероятно что вам потребуется тут что-то поменять
CFG = configure --disable-nls --program-prefix=$(TCNAME)- \
	--prefix=$(TC) --target=$(TARGET) --datarootdir=$(TMP)

CFG_BINUTILS = --with-sysroot=$(TCPATH) $(CFG_CPU)
# --with-native-system-header-dir=/include

# фиктивные цели
.PHONY: all clean distclean dirs gz binutils gcc gdb

# это правило сработает при запуске make без параметров, полная пересборка
all: distclean gz
# создать структуру каталогов
dirs:
	mkdir -p $(GZ) $(DIRS)
# зачистка каталогов, остаются архивы исходников
distclean:
	rm -rf $(DIRS)
	make dirs

# закачка архивов исходников
gz:
	$(WGET) http://ftp.gnu.org/gnu/binutils/$(BINUTILS).tar.bz2
	$(WGET) ftp://ftp.gmplib.org/pub/gmp/$(GMP).tar.bz2
	$(WGET) http://www.mpfr.org/mpfr-current/$(MPFR).tar.bz2
	$(WGET) http://www.multiprecision.org/mpc/download/$(MPC).tar.gz
	$(WGET) http://gcc.skazkaforyou.com/releases/$(GCC)/$(GCC).tar.bz2

# правила распаковки архивов исходников	
$(SRC)/%/README: $(GZ)/%.tar.gz
	cd $(SRC) &&  zcat $< | tar x && touch $@
$(SRC)/%/README: $(GZ)/%.tar.bz2
	cd $(SRC) && bzcat $< | tar x && touch $@
$(SRC)/%/README: $(GZ)/%.tar.xz
	cd $(SRC) && xzcat $< | tar x && touch $@	

# сборка BINUTILS (ассемблер, линкер и т.п.)
# (asm-извращенцы и авторы собственных компиляторов могут на этом остановиться)
autoconf_version=$(shell autoconf --version|tr ' ' '\n'|grep 2.6)
binutils: $(SRC)/$(BINUTILS)/README
	# патчим в исходниках конфиг подменяя версию autoconf 2.64
	cd $(SRC)/$(BINUTILS) && sed -i '/dnl Ensure exactly this Autoconf version is used/d' ./config/override.m4
	cd $(SRC)/$(BINUTILS) && sed -i "s/2.64/$(autoconf_version)/g" ./config/override.m4
	# конфигурируем и собираем
	rm -rf $(TMP)/$(BINUTILS) && mkdir $(TMP)/$(BINUTILS) && cd $(TMP)/$(BINUTILS) &&\
	$(SRC)/$(BINUTILS)/$(CFG) $(CFG_BINUTILS) && $(MAKE) && $(INSTALL)

.PHONY: z
z:
	echo $(MAKE)
	