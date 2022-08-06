
section .text
global ft_strcpy

len:

            mov     rdi, rsi
            xor     rax, rax              ; rax = 0
            lea     rcx, [rax - 1]        ; rcx = -1
            repne   scasb                 ; rcx = -len - 2
            not     rcx                   ; rcx = len + 1
            dec     rcx                   ; rcx = len
            ret
ft_strcpy:
            mov rbx, rdi    ; save 
            call len        ; get len rsi into rcx
            mov rdi, rbx    ; get value back
            rep movsb       ; n copy
            ret
