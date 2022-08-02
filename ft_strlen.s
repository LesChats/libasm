; Determine the lenght of Nul-Terminated c-string
; Input: rdi = adress of the beginning of the string buffer
; Output: rax = lenght of the string.
section .text
global ft_strlen

ft_strlen:
    xor     rax, rax              ; rax = 0
    lea     rcx, [rax - 1]        ; rcx = -1
    repne   scasb                 ; rcx = -len - 2
    not     rcx                   ; rcx = len + 1
    lea     rax, [rcx - 1]        ; rax = len
    ret