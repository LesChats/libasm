section .text
	global		ft_strdup
	extern		malloc

ft_strdup:
			push	rdi						; save src
len:
            xor		rax, rax				; rax = 0
            lea		rcx, [rax - 1]			; rcx = -1
            repne	scasb					; rcx = -len - 2
            not		rcx						; rcx = len + 1
;			dec		rcx						; rcx = len
			push	rcx

;			lea		rdi, [rcx + 1]
			mov		rdi, rcx
			call	malloc					; rax = malloc(len + 1)
copy:
			mov		rdi, rax				; rdi = malloc(len + 1)
			pop		rcx						; rcx = len(src)
			pop		rsi						; rsi <- src
			rep		movsb
			ret
