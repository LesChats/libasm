section .text
	global ft_list_remove_if
	extern free

%define LIST r15
%define DATA r12
%define CMPF r13
%define FREE r14
%define PREV rbx

ft_list_remove_if:
					sub		rsp, 16			; setting somme space on stack
					mov		[rsp+8], rdi	; saving list_begin
					mov		LIST, [rdi]		; list = *list_begin
					test	LIST, LIST		; if not list
					je		.end			; return

					mov		DATA, rsi
					mov		FREE, rcx
					mov		CMPF, rdx
					xor		ebx, ebx
					jmp		.loop
.match:
					mov		r9, [LIST+8]	; r9 = l->next
					test	PREV, PREV		; if prev == 0
					je		.list_begin
					mov		[PREV+8], r9		;prev->next = l->next
.next:
					mov		rdi, [LIST]		; free_fct(l->data)
					call	FREE
					mov		rdi, LIST		; free(l)
					call	free
					mov		LIST, r9		;l = l->next
					test	LIST, LIST
					je		.end
.loop:
					mov		rdi, [LIST]
					mov		rsi, DATA
					call	CMPF
					test	rax, rax
					je		.match
					mov		PREV, LIST		; prev = l
					mov		LIST, [LIST+8]	; l = l->next
					test	LIST, LIST
					jne		.loop
.end:
					add rsp, 16				; reset stack
					ret
.list_begin	:		
					mov		rax, [rsp+8]	; get list_begin from stack
					mov		[rax], r9	; *list_begin = l->next 
					jmp		.next
