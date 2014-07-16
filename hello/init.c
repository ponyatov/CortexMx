
// пример как преобразовать макроопределение в строку
#define QUOTE1(Y) #Y
#define QUOTE(Y) QUOTE1(Y)

// сопи направо
__attribute__ ((section(".copyright")))
char _C_init[]=QUOTE(CPU) " init (c) Azbuka ARMaturschika";

#if CPU==LM3S811
#include "LM3S811.h"
#endif

// точка входа
init () {}
