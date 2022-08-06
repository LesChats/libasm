section .text
	global	ft_list_push_front
	extern	malloc

ft_list_push_front:
					test	rdi, rdi			; test list begin
					je		.end				; list == null => end

					mov		rbx, rdi			; save rdi befor malloc
					mov		r14, rsi			; save data befor malloc
					mov		rdi, 16				; sizeof(t_list)
					call	malloc				; new = malloc(16);
					test	rax, rax			; test malloc result
					je		.end				; bad malloc return
					movq	xmm0, r14			; xmm0 = {data, _}
					movhps	xmm0, [rbx]			; xmm0 = { data, *list_begin}
					mov		qword [rbx], rax	; *list_begin = new 
					movups	[rax], xmm0 ; new = {data, *hold_begin}
.end:
					ret
