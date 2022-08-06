section .data
				hash: times 127 dd -1
section .text
	global ft_atoi_base

%define base		rsi
%define str_		rdx


ft_atoi_base:
				movsx		rax, byte [base]		; rax = *base
				mov			str_, rdi				; rdx = str
				;add			base, 1					; ++base
				xor			ecx, ecx				; value = 0
				mov			r8, 43984760094208 		; magic
				test		al, al					; if !*base
				jne			.bit_test
				jmp			.bad_end
.check_base:
				cmp			dword [hash+rax*4], -1		; is hash[(int)*b] == -1 ?
				jne			.bad_end
				mov			dword [hash+rax*4], ecx		; hash[(int)*base] = value
				add			ecx, 1
				movsx		rax, byte [base+rcx]		;
				test		al, al					; base[value - 1] == 0 ?
				je			.atoi					; base Success !
.bit_test:
				cmp			al, 45					; al > '-' ?
				ja			.check_base				; yes -> next check
				bt			r8, rax					; al in ['+, ' ', ..]
				jnc			.check_base				; not -> next check
.bad_end:
				xor			eax, eax			; res = 0
				ret

.atoi:
				cmp			 ecx, 1				; if len(base) <= 1
				jne			.pass_empty				;
				jmp			.bad_end				;
.inc_empty:
				add			str_, 1
.pass_empty:
				movsx		eax, byte [str_]		; edx = str[i] 
				cmp			al, 32					; ' '
				je			.inc_empty				;
				sub			eax, 9
				cmp			eax, 4
				jbe			.inc_empty				; (str[i] - 9) >= 4

				mov			rax, 1
				jmp			.set_sign
.minus:
				neg			rax
.plus:
				add			str_, 1					; ++str
.set_sign:
				movsx		rdi, byte [str_]		; rcx = str[i]
				cmp			dil, 43					; +
				je			.plus
				cmp			dil, 45					; -
				je			.minus

				movsx		rdi, dword [hash+rdi*4]	; edx = hash[str[i]]
				cmp			rdi, -1
				je			.bad_end
				movsx		rcx, ecx
				xor			esi, esi
compute:
				imul		rsi, rcx				; res = res * bsize
				add			str_, 1					; ++str
				add			rsi, rdi
				movsx		rdi, byte [str_]
				movsx		rdi, byte [hash+rdi*4]	; edx = hash[str[i]]
				cmp			rdi, -1
				jne			compute
				imul		eax, esi 
				ret
