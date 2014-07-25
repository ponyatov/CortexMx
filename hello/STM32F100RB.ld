/* скрипт линкера для STM32F100RB (VLDISCOVERY) */
 
/* конфигурация памяти целевой системы, сильно зависит от микроконтроллера */

MEMORY
{
	FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 128K
	SRAM (rwx) : ORIGIN = 0x20000000, LENGTH =   8K
}
_stack_size = 1K; /* размер стека */

/* INCLUDE generic.ld */
