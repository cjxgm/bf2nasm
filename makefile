
CC = gcc
CCFLAGS = -Wall -Werror -O2

.PHONY: all clean cleanall debug install uninstall

all: bf2nasm
clean:
	rm -f *.o
	rm -f test.asm
	rm -f test
cleanall: clean
	rm -f bf2nasm
debug: all
	./bf2nasm < test.b > test.asm
	nasm -o test.o -f elf32 test.asm
	gcc -o test test.o
	./test
install: all
	cp bf2nasm /usr/bin/bf2nasm
uninstall:
