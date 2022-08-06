section .text
	global	ft_list_sort

%define BEGIN	r12
%define CMPF	r13
%define PREV	r14
%define LAST	r15
%define SWAP	rdx

ft_list_sort:
				mov		CMPF, rsi
				mov		BEGIN, rdi
				xor		PREV, PREV
				mov		LAST, [rdi]		; last = *begin

				test	LAST, LAST
				jne		.loop
				ret
.swap:
				mov		rax, [LAST+8]		; rax = last->next
				test	PREV, PREV
				je		.swap_being_last
.swap_prev_last:
				mov		SWAP, [PREV+8]		; swap = prev->next
				mov		[PREV+8], rax		; *prev->next = last->next
				mov		rax, [rax+8]		; rax = l->n->n
				mov		[SWAP+8], rax		; swap->n = l->n->n 
				mov		rax, [PREV+8]		; rax = prev->n
				mov		[rax+8], SWAP		; *(p->n)->n = swap
.update:
				mov		LAST, [BEGIN]		; last = *begin
				xor		PREV, PREV
				test 	LAST, LAST
				je		.end
.loop:
				mov		rax, [LAST+8]		; rsi = last->next;
				test	rax, rax
				je		.end
				mov		rsi, [rax]
				mov		rdi, [LAST]			; rdi = last->data
				call	CMPF
				test	eax, eax
				jg		.swap
				mov		PREV, LAST			; prev = last
				mov		LAST, [LAST+8]		; last = last->next
				test	LAST, LAST
				jne		.loop
.end:
				ret

.swap_being_last:
				mov		SWAP, [BEGIN]	; swap = *begin
				mov		[BEGIN], rax	; *begin = last->next
				mov		rax, [rax+8]	; rax = l->n->n
				mov		[SWAP+8], rax	; swap->next = last->next->next
				mov		rax, [BEGIN]	; rax = BEGIN
				mov		[rax+8], SWAP; *begin->next = last
				jmp		.update
