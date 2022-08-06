section .text
	global ft_list_size

ft_list_size:
				xor rax, rax	; count = 0
.while:
				test	rdi, rdi
				je		.end
				mov		rdi, [rdi + 8]
				inc		rax
				jmp		.while
.end
				ret
