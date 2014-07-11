#include <Windows.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
	char buf[1024];
	sprintf(buf,"arm-none-eabi-objdump %s %s > %s.dump\n",argv[1],argv[2],argv[2]);
	return system(buf);
}
