
CC = gcc
CCFLAGS = -Wall -Werror -O2

.PHONY: all clean cleanall debug install uninstall

all: bf2nasm
clean:
	rm -f *.o
	rm -f awib.asm
	rm -f awib
cleanall: clean
	rm -f bf2nasm
debug: all
	./bf2nasm < awib.b > awib.asm
	nasm -o awib.o -f elf32 awib.asm
	gcc -o awib awib.o
	./awib < awib.b
install: all
	cp ./bf2nasm /usr/local/bin/bf2nasm
uninstall:
	rm -f /usr/local/bin/bf2nasm

