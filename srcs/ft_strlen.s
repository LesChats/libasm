; strlen(char const *str)
; return len of str
; use sse2
section	.text align=16
	global	ft_strlen

%define	res		rax					;
%define	lower	ecx					;

ft_strlen:
			mov			res, rdi 		; copy string, res = str
			mov			lower, edi		; save lower bits
			pxor		xmm0, xmm0		; set to zero
			and			lower, 0FH		; get only lower 4 bit in lower
			and			res, -10H		; align pointer by 16
			movdqa		xmm1, [res]		; 	read from nearest preceding boundary
			pcmpeqb		xmm1, xmm0		; compare 16bits to 0
			pmovmskb	edx, xmm1		; get one bit for each byte result
			shr			edx, cl			; shift out false bit
			shl			edx, cl			; shift back
			bsf			edx, edx		; find first 1-bit
			jnz			.end
.loop:
			add			res, 10H		; increment pointer by 16
			movdqa		xmm1, [res]		; read 16 byte aligned
			pcmpeqb		xmm1, xmm0		; compare 16 byte to 0
			pmovmskb	edx, xmm1		; get one bits for each 0 byte
			bsf			edx, edx		; find first 1 btypw
			jz			.loop			; if edx is zero -> not 0 found
.end:
			sub			res, rdi		; sub end - start
			add			res, rdx		; add byte index
			ret
