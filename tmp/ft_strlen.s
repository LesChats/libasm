; Determine the lenght of Nul-Terminated c-string
; Input: rdi = adress of the beginning of the string buffer
; Output: rax = lenght of the string.
section .text
global ft_strlen

ft_strlen:
    mov     rax, rdi    ; rax = s
    jmp     loop
increment:
    inc     rax         ; ++rax
loop:
    mov     cl, byte [rax] ; slow part
    test    cl, cl
    jnz     increment

    sub     rax, rdi    ; rax - s
    ret