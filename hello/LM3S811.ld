/* скрипт линкера для Luminary Micro lm3s811 (эмулятор в qemu-arm) */
 
/* конфигурация памяти целевой системы, сильно зависит от микроконтроллера */

MEMORY
{
	FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 64K /* 0x00010000 */
	SRAM (rwx) : ORIGIN = 0x20000000, LENGTH =  8K /* 0x00002000 */
}
_stack_size = 1K; /* размер стека */

INCLUDE generic.ld
