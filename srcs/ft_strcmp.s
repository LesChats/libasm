;**************************** strcmp ************************
; Author: abaudot
; Date create: 2022

; Description:
; strcmp(char const * s1, char const * s2);
; Test if two stings are equal. The strings must be zero-terminated.
; Only for "modern" cpu cause use of SSE4 instructions
; for UNIX only (for now)
;************************************************************


section .text align=16
	global ft_strcmp ; entry point

ft_strcmp:
		mov  		rax, -16							; offest start at 0
.loop:
		add  		rax, 16								; increment offset (rax)
		movdqu  	xmm1, [rdi+rax]				; read 16 bytes of string s1
		pcmpistri  xmm1, [rsi+rax], 00011000B;0x18 		; packet cmp implicit len str, return index (in rcx)
											; mask: 00: unsigned bytes, 10: equal each, 01: a=!b (invert)

		; CF reset if intRes2 == 0 set otherwise => CF set if xmm1 != xmm2
		; ZF set if any byte/word of xmm2 is null, reset otherwise

		jnbe  .loop								; Jump short if not below or equal (CF=0 and ZF=0)
		jnc   .end								; Jump short if not carry (CF=0)
	
		; strings are not equal
		add   rcx, rax							; offset to firest differing byte
		movzx eax, byte [rdi+rcx]				; s1[offset]
		movzx edx, byte [rsi+rcx]				; s2[offset]
		sub   rax, rdx
		ret
.end:
		xor eax, eax							; eax <= 0
		ret
