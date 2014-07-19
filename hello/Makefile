# пример мейкфайла для проекта Азбука ARMатурщика
# лабораторная работа ЛР{labmkmake}
# символ # в начале -- комментарий

# пример использования переменных

# простое присваивание значения переменной
# обнуление переменной
SOMEVAR =
# маски временных файлов
TMPFILES = *.o *.elf *.hex *.objdump

# целевая платформа $TARGET, часто называют "префикс целевой платформы"
TARGET = arm-none-eabi
# целевой процессор
CPU = STM32F100RB
# переопределение переменной
CPU = LM3S811

# присваивание переменной с подстановкой значений другой переменной

# опции целевого процессора для gnu as и gnu cc
CPUOPT = -mcpu=cortex-m3 -mthumb -DCPU=$(CPU)

# стандартные переменные, задающие команды ассемблера, компилятора и линкера 
AS = $(TARGET)-as
CC = $(TARGET)-gcc
LD = $(TARGET)-ld
OBJDUMP = $(TARGET)-objdump
OBJCOPY = $(TARGET)-objcopy
SIZE = $(TARGET)-size
GDB = $(TARGET)-gdb
MAKE = mingw32-make
EMU = qemu-system-arm -M lm3s811evb -S -s -kernel

# нестандартная (?) переменная - опции оптимизации
OPTFLAGS = -O1
# опции генерации отладочной информации, для отладки _выключить оптимизацию_
DEBFLAGS = -g -O0
# стандартная переменная - флаги компилятора Си
CFLAGS  = $(CPUOPT) $(OPTFLAGS) $(DEBFLAGS)
# флаги ассемблера
ASFLAGS = $(CPUOPT) $(DEBFLAGS)

# указание что цели all и clean являются фиктивными целями, а не файлами
.PHONY: all clean deb emu

# первая цель, заданная в Makefile, является целью по умолчанию
# и обрабатывается при вызове $(MAKE) без параметров

# стандартная цель, предусматривающая сборку всего проекта 
all: elf.elf bin.bin hex.hex

elf.elf: $(CPU).ld generic.ld startup.o init.o main.o
	$(LD) -T ../hello/$(CPU).ld -T ../hello/generic.ld -o $@ *.o && \
	$(OBJDUMP) -xd $@ > $@.objdump && \
	$(SIZE) $@
	
hex.hex: elf.elf
	$(OBJCOPY) -O ihex $< $@	
bin.bin: elf.elf
	$(OBJCOPY) -O binary $< $@	
	 
# стандартная цель, удаление всех временных и конечных бинарных файлов
clean:
	rm -f $(TMPFILES)

# макро-правило: как компилировать сишные файлы в объектный код
# вместо % в других правилах могут подставляться любые символы, см. цель all
# тэг $@ заменяется на цель правила, т.е. %.o
# тэг $< заменяется на первый источник, т.е. %.с
%.o: %.c Makefile
	$(CC) $(CFLAGS) -c -o $@ $<
	$(OBJDUMP) -dx $@ > $@.objdump

# макро-правило: как компилировать ассемблерные файлы
%.o: %.S Makefile
	$(AS) $(ASFLAGS) -o $@ $< && $(OBJDUMP) -dx $@ > $@.objdump

# запуск симулятора
emu: elf.elf
	$(EMU) $<

# запуск отладчика	
deb: elf.elf
	$(GDB) $<
