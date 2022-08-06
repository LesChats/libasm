section .text
global ft_strcmp

ft_strcmp:  
loop:   lodsb
        test    al, al
        je     _zero
        sub     al, byte [rdi]
        jnz     _end
        inc     rdi
        jmp     loop

_zero:
    movzx rax, byte [rdi]
    ret
_inf:
    mov rax, 1
    ret
_end:
    jl  _inf
    mov rax, -1
    ret
