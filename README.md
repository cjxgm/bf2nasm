# brainfuck to nasm compiler

## usage

```bash
	gcc -o bf2nasm bf2nasm.c
	./bf2nasm < input.b > output.asm
	nasm -f elf32 -o output.o output.asm
	ld -o output output.o -lc
```

