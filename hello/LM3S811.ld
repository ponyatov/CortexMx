/* ������ ������� ��� Luminary Micro lm3s811 (�������� � qemu-arm) */
 
/* ������������ ������ ������� �������, ������ ������� �� ���������������� */

MEMORY
{
	FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 64K /* 0x00010000 */
	SRAM (rwx) : ORIGIN = 0x20000000, LENGTH =  8K /* 0x00002000 */
}
_stack_size = 1K; /* ������ ����� */

/* INCLUDE generic.ld */
