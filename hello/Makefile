# ������ ��������� ��� ������� ������ ARM��������
# ������������ ������ ��{labmkmake}
# ������ # � ������ -- �����������

# ������ ������������� ����������

# ������� ������������ �������� ����������
# ��������� ����������
SOMEVAR =
# ����� ��������� ������
TMPFILES = *.o *.elf *.hex *.objdump

# ������� ��������� $TARGET, ����� �������� "������� ������� ���������"
TARGET = arm-none-eabi
# ������� ���������
CPU = STM32F100RB
# ��������������� ����������
CPU = LM3S811

# ������������ ���������� � ������������ �������� ������ ����������

# ����� �������� ���������� ��� gnu as � gnu cc
CPUOPT = -mcpu=cortex-m3 -mthumb -DCPU=$(CPU)

# ����������� ����������, �������� ������� ����������, ����������� � ������� 
AS = $(TARGET)-as
CC = $(TARGET)-gcc
LD = $(TARGET)-ld
OBJDUMP = $(TARGET)-objdump
OBJCOPY = $(TARGET)-objcopy
SIZE = $(TARGET)-size
GDB = $(TARGET)-gdb
MAKE = mingw32-make
EMU = qemu-system-arm -M lm3s811evb -S -s -kernel

# ������������� (?) ���������� - ����� �����������
OPTFLAGS = -O1
# ����� ��������� ���������� ����������, ��� ������� _��������� �����������_
DEBFLAGS = -g -O0
# ����������� ���������� - ����� ����������� ��
CFLAGS  = $(CPUOPT) $(OPTFLAGS) $(DEBFLAGS)
# ����� ����������
ASFLAGS = $(CPUOPT) $(DEBFLAGS)

# �������� ��� ���� all � clean �������� ���������� ������, � �� �������
.PHONY: all clean deb emu

# ������ ����, �������� � Makefile, �������� ����� �� ���������
# � �������������� ��� ������ $(MAKE) ��� ����������

# ����������� ����, ����������������� ������ ����� ������� 
all: elf.elf bin.bin hex.hex

elf.elf: $(CPU).ld generic.ld startup.o init.o main.o
	$(LD) -T ../hello/$(CPU).ld -T ../hello/generic.ld -o $@ *.o && \
	$(OBJDUMP) -xd $@ > $@.objdump && \
	$(SIZE) $@
	
hex.hex: elf.elf
	$(OBJCOPY) -O ihex $< $@	
bin.bin: elf.elf
	$(OBJCOPY) -O binary $< $@	
	 
# ����������� ����, �������� ���� ��������� � �������� �������� ������
clean:
	rm -f $(TMPFILES)

# �����-�������: ��� ������������� ������ ����� � ��������� ���
# ������ % � ������ �������� ����� ������������� ����� �������, ��. ���� all
# ��� $@ ���������� �� ���� �������, �.�. %.o
# ��� $< ���������� �� ������ ��������, �.�. %.�
%.o: %.c Makefile
	$(CC) $(CFLAGS) -c -o $@ $<
	$(OBJDUMP) -dx $@ > $@.objdump

# �����-�������: ��� ������������� ������������ �����
%.o: %.S Makefile
	$(AS) $(ASFLAGS) -o $@ $< && $(OBJDUMP) -dx $@ > $@.objdump

# ������ ����������
emu: elf.elf
	$(EMU) $<

# ������ ���������	
deb: elf.elf
	$(GDB) $<
