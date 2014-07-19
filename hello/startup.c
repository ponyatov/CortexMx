// Стартап-код для Cortex-M3 на Си (необходим функционал GNU cc)

// сопирайты
__attribute__ ((section(".copyright")))
char _C_startup[]="startup.c (c) Azbuka ARMaturschika";

#include "vectors.h"

// компилируем таблицу векторов как массив указателей в отдельный сегмент
__attribute__ ((section(".vectors")))
void (*_vectors[])(void)={
		&_stack_top,		// Initial SP  значение указателя стека после сброса
		Reset_Handler		// The reset handler обработчик сброса
/*
		NMI_Handler,        // The NMI handler
		HardFault_Handler,  // The hard fault handler
		MemManage_Handler,  // The MPU fault handler
		BusFault_Handler,   // The bus fault handler
		UsageFault_Handler, // The usage fault handler
		0,                  // Reserved
		0,                  // Reserved
		0,                  // Reserved
		0,                  // Reserved
		SVC_Handler,        // SVCall handler
		DebugMon_Handler,   // Debug monitor handler
		0,                  // Reserved
		PendSV_Handler,     // The PendSV handler
		SysTick_Handler,    // The SysTick handler
*/
};


__attribute__((weak)) void Reset_Handler(void) {for(;;);}	/* Reset Handler */
