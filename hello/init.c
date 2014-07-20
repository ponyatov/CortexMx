
// пример как преобразовать макроопределение в строку
#define QUOTEQUOTE(Y) #Y
#define QUOTE(Y) QUOTEQUOTE(Y)

// сопи направо
__attribute__ ((section(".copyright")))
char _C_init[]=QUOTE(CPU) " init (c) Azbuka ARMaturschika";

// пример условной компил€ции по значению макроса, заданного
// в командной строке запуска компил€тора -DCPU=$(CPU)
#if CPU==LM3S811
	#include "LM3S811.h"
#else
	// пример как аварийно остановить компил€цию
	#pragma message QUOTE(CPU)
	#error CPU not supported
#endif

// пример переопределени€ weak функции:
// замена обработчика из startup.c собственным обработчиком исключений
//void Reset_Handler(void) { init(); for (;;) main(); }

// точка входа
init () {}
