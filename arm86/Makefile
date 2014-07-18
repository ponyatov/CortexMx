CC = mingw32-gcc
CFLAGS =
QEMU = qemu-system-i386w
QEMU = qemu-system-armw -M lm3s811evb -kernel elf.elf

all: emu86.exe elf.elf
	$(QEMU) -gdb tcp:127.0.0.1:8086 -S

%.exe: %.c
	$(CC) $(CFLAGS) -o $@ $<
	
%.elf: %.c Makefile
	arm-none-eabi-gcc -O1 -g -mcpu=cortex-m3 -mthumb -c -o startup.o ../hello/startup.c &&\
	arm-none-eabi-gcc -O1 -g -mcpu=cortex-m3 -mthumb -c -o $<.o $< &&\
	arm-none-eabi-ld -T ../hello/LM3S811.ld -T ../hello/generic.ld -o $@ $<.o startup.o &&\
	arm-none-eabi-objdump -dx $@ > $@.objdump
