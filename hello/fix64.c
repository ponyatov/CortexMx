#include <Windows.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
	char buf[1024];
	sprintf(buf,"make %s>make.log",argv[1]);
	return system(buf);
}
