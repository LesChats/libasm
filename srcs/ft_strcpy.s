
;**************************** strcpy ************************
; Author: abaudot
; Date create: 2022

; Description:
; strcy(char *dst, char const *src);
;
;************************************************************
section .text
    global ft_strcpy

ft_strcpy:
            mov rbx, rdi    ; save 
len:

            mov     rdi, rsi
            xor     rax, rax              ; rax = 0
            lea     rcx, [rax - 1]        ; rcx = -1
            repne   scasb                 ; rcx = -len - 2
            not     rcx                   ; rcx = len + 1
copy:
            mov rdi, rbx    ; get value back
            rep movsb       ; n copy
            ret
