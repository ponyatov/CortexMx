# Makefile для сборки своего тулчайна из исходников для Windows
# сборка выполняется под Linux по схеме "канадский крест"
# вменяемо реализовать _быструю_ сборку под win пока не удалось

# тройка канадского креста
BUILD = 
HOST = mingw32
TARGET = arm-none-eabi

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
DIRS = $(TMP) $(SRC) $(GZ) $(B) $(H) $(T)

.PHONY: debianpackages all dirs distclean

all:

dirs:
	mkdir -p $(DIRS)
distclean:
	rm -rf $(DIRS) ; make dirs

# цель установки пакетов нужных для сборки под Debian GNU/Linux
debianpackages:
	aptitute install make
