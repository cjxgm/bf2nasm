
CC = gcc
CCFLAGS = -Wall -Werror -O2

all: bf2nasm
clean:
	rm -f *.o
	rm -f test.asm
	rm -f test.o
	rm -f test
cleanall: clean
	rm -f bf2nasm
debug: all
	./bf2nasm < test.b > test.asm
	nasm -o test.o -f elf32 test.asm
	ld -o test test.o -lc
	./test

