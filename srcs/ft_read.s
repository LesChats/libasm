; ssize_t read(int fd, void *buf, size_t count);

section .text
	global ft_read
	extern __errno_location

ft_read:
		xor			rax, rax	; 0: read
		syscall					;read(rdi, rsi, rdx);
		test		rax, rax
		jl			errno		; if rax < 0 => error
		ret
errno:
		neg			rax
		mov			rdi, rax
		call		__errno_location
		mov			[rax], rdi
		mov			rax, -1
		ret
