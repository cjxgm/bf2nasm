
putchar:
	mov		eax, 4			; sys_write
	mov		ebx, 1			; fd_stdout
	lea		ecx, [esp+4]	; string address
	mov		edx, 1			; length = 1
	int 	80h				; syscall
	ret


getchar:
	sub		esp, 4			; allocate space for temporary variable

	mov		eax, 3			; sys_read
	mov		ebx, 0			; fd_stdin
	mov		ecx, esp		; temporary variable
	mov		edx, 1			; length = 1
	int 	80h				; syscall

	; xor	eax, eax		; in bf2nasm, there is no need for this.
	mov		al, [esp]		; return the temporary variable

	add		esp, 4			; free space for temporary variable
	ret


return0:
	mov		eax, 1			; sys_exit
	xor		ebx, ebx		; return 0
	int		80h				; syscall
	jmp		$				; should never arrive here

