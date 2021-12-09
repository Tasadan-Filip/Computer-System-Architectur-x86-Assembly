bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; Given an array A of words, build two arrays of bytes:  
; - array B1 contains as elements the higher part of the words from A
; - array B2 contains as elements the lower part of the words from A
segment data use32 class=data
    a dw 1234h, 3456h, 5678h, 7890h
    len_a equ $ - a
    b1 resb len_a / 2
    b2 resb len_a / 2
    
    
segment code use32 class=code
    start:
        mov esi, a
        
        mov ecx, len_a / 2
        mov ebx, 0
        
        cld
        
        parse_a_to_obtain_b1_and_b2:
            lodsw ; move the word from DS:ESI into AX
            
            mov byte [b1 + ebx], ah
            mov byte [b2 + ebx], al
            
            inc ebx
            
            loop parse_a_to_obtain_b1_and_b2
        
        
        
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
