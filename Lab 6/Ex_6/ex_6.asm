bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

;A word string s is given. Build the byte string d such that each element d[i] contains:
;- the count of zeros in the word s[i], if s[i] is a negative number
;- the count of ones in the word s[i], if s[i] is a positive number
segment data use32 class=data
    s dw -22, 145, -48, 127
    len_s equ $ - s
    separator db 0xFF
    d resb len_s / 2
    
segment code use32 class=code
    start:
        mov esi, s
        mov edi, d
        
        cld
        mov ecx, len_s / 2
        
        parse_s_to_obtain_d:
            lodsw ; move the word from DS:ESI into AX
            mov bl, 0
            cmp ax, 0
            jl negative_number
            
            
            while_ax_bigger_than_0_positive:
                cmp ax, 0
                je fin_of_parsing
                clc
                shr ax, 1
                jnc last_bit_not_1
                    inc bl
                last_bit_not_1:
                    jmp while_ax_bigger_than_0_positive
               
            
            negative_number:
                while_ax_bigger_than_0_negative:
                    cmp ax, 0
                    je fin_of_parsing
                    clc
                    shr ax, 1
                    jc last_bit_not_0
                    inc bl
                    last_bit_not_0:
                        jmp while_ax_bigger_than_0_negative
            
            fin_of_parsing:
            mov al, bl
            stosb ; mov the byte from AL into ES:EDI
            loop parse_s_to_obtain_d
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
