
// пример как преобразовать макроопределение в строку
#define QUOTEQUOTE(Y) #Y
#define QUOTE(Y) QUOTEQUOTE(Y)

// сопи направо
__attribute__ ((section(".copyright")))
char _C_init[]=QUOTE(CPU) " init (c) Azbuka ARMaturschika";

// пример условной компиляции по значению макроса, заданного
// в командной строке запуска компилятора -DCPU=$(CPU)
#if CPU==LM3S81122
	#include "LM3S811.h"
#else
	// пример как аварийно остановить компиляцию
	#pragma message QUOTE(CPU)
	#error CPU not supported
#endif

//#pragma message QUOTE(CPU)
//#error not supported

// точка входа
init () {}
