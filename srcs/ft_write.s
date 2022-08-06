section .text

global	ft_write
extern	__errno_location

ft_write:
			mov			rax, 1			; write
			syscall						; write(rdi, rsi, rdx)
			test		rax, rax		; or rax, rax
			jl			errno			; rax < 0 => error
			ret
errno:
			neg			rax
			mov			rdi, rax
			call		__errno_location
			mov			[rax], rdi
			mov			rax, -1
			ret
