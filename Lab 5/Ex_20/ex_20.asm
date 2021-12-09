bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; Two byte strings A and B are given. Obtain the string R by concatenating the elements of B in reverse order and the even elements of A
segment data use32 class=data
    a db 2, 1, 3, 3, 4, 2, 6
    len_a equ $ - a
    b db 4, 5, 7, 6, 2, 1
    len_b equ $ - b
    r resb len_a + len_b
segment code use32 class=code
    start:
        mov edi, r
    
        mov esi, b + len_b - 1
        mov ecx, len_b
        jecxz fin
        
        parse_b_in_reverse:
            
            std
            lodsb
            
            cld
            stosb
            
            loop parse_b_in_reverse
        
        mov esi, a
        mov ecx, len_a
        
        cld
        jecxz fin
        
        parse_a:
            lodsb
            
            test al, 1
            jnz last_command_of_parse_a
            
            stosb
            
            last_command_of_parse_a:
                loop parse_a
        
        fin:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
