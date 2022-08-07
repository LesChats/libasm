section .text
	global	ft_list_push_front
	extern	malloc

%define	begin r13
%define data r14
ft_list_push_front:
					test	rdi, rdi			; test list begin
					je		.end				; list == null => end

					mov		begin, rdi			; save rdi befor malloc
					mov		data, rsi			; save data befor malloc
					mov		edi, 16				; sizeof(t_list)
					call	malloc				; new = malloc(16);
					test	rax, rax			; test malloc result
					je		.end				; bad malloc return
					movq	xmm0, data			; xmm0 = {data, _}
					movhps	xmm0, [begin]			; xmm0 = { data, *list_begin}
					mov		[begin], rax	; *list_begin = new 
					movups	[rax], xmm0 ; new = {data, *old_begin}
.end:
					ret
