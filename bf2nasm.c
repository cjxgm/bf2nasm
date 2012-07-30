
/* bf2nasm - brainfuck to nasm compiler */

#include <stdio.h>

int main(void)
{
	int ch;
	int loop = 0;
	int loops[0x10000] = {0};
	char lp = 0;

	puts(
			"; generated by bf2nasm, "
			"by eXerigumo Clanjor (哆啦比猫/兰威举).\n"
			"[extern putchar]\n"
			"[extern getchar]\n"
			"[global _start]\n"
			"\n"
			"[section .bss]\n"
			"mem:	resb 300000\n"
			"\n"
			"[section .text]\n"
			"global main"
			"main:\n"
			"\tmov		edi, mem\n"		 // the mem pointer
		);

	while ((ch = getchar()) != EOF) {
		switch (ch) {
			case '+':
				puts("\tinc		byte [edi]");		// ++*edi;
				break;

			case '-':
				puts("\tdec		byte [edi]");		// --*edi;
				break;

			case '>':
				puts("\tinc		edi");		// edi++;
				break;

			case '<':
				puts("\tdec		edi");		// edi--;
				break;

			case ',':
				puts(	// *edi = getchar();
						"\tcall	getchar\n"
						"\tmov		[edi], al"
					);
				break;

			case '.':
				puts(	// putchar(*edi);
						"\tpush	dword [edi]\n"
						"\tcall	putchar\n"
						"\tadd		esp, 4"
					);
				break;

			case '[':
				loops[lp] = loop++;
				printf("label_%d_start:\n", loops[lp]);		// while (*edi)
				puts("\tcmp		byte [edi], 0");			// {
				printf("\tje		label_%d_end\n", loops[lp]);
				lp++;
				break;

			case ']':
				lp--;
				printf("\tjmp		label_%d_start\n", loops[lp]);
				printf("label_%d_end:\n", loops[lp]);		// }
				break;

			default:	// ignore comments
				break;
		}
	}

	puts(	// return 0
			"\n\txor		eax, eax\n"
			"ret\n"
		);

	return 0;
}

