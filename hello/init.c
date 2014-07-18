
// ������ ��� ������������� ���������������� � ������
#define QUOTEQUOTE(Y) #Y
#define QUOTE(Y) QUOTEQUOTE(Y)

// ���� �������
__attribute__ ((section(".copyright")))
char _C_init[]=QUOTE(CPU) " init (c) Azbuka ARMaturschika";

// ������ �������� ���������� �� �������� �������, ���������
// � ��������� ������ ������� ����������� -DCPU=$(CPU)
#if CPU==LM3S81122
	#include "LM3S811.h"
#else
	// ������ ��� �������� ���������� ����������
	#pragma message QUOTE(CPU)
	#error CPU not supported
#endif

//#pragma message QUOTE(CPU)
//#error not supported

// ����� �����
init () {}
