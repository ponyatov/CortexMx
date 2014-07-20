
// ������ ��� ������������� ���������������� � ������
#define QUOTEQUOTE(Y) #Y
#define QUOTE(Y) QUOTEQUOTE(Y)

// ���� �������
__attribute__ ((section(".copyright")))
char _C_init[]=QUOTE(CPU) " init (c) Azbuka ARMaturschika";

// ������ �������� ���������� �� �������� �������, ���������
// � ��������� ������ ������� ����������� -DCPU=$(CPU)
#if CPU==LM3S811
	#include "LM3S811.h"
#else
	// ������ ��� �������� ���������� ����������
	#pragma message QUOTE(CPU)
	#error CPU not supported
#endif

// ������ ��������������� weak �������:
// ������ ����������� �� startup.c ����������� ������������ ����������
//void Reset_Handler(void) { init(); for (;;) main(); }

// ����� �����
init () {}
