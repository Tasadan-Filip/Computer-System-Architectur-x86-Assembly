bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; A list of doublewords is given. Obtain the list made out of the low bytes of the high words of each doubleword from the given list with the property that these bytes are palindromes in base 10.
segment data use32 class=data
    s dd 12345678h, 1A2C3C4Dh, 98FCDD76h, 12783A2Bh
    len_s equ $ - s
    d dd -1
    aux_dword dd 0 
    
segment code use32 class=code
    start:
        mov esi, s
        mov edi, d
        add edi, 3
        
        mov ecx, len_s / 4
        
        parse_s_to_obtain_d:
            cld
            lodsd ; move the dword from DS:ESI into EAX
            
            mov [aux_dword], eax
            
            mov al, [aux_dword + 1]
            mov bl, al
            
            clc
            
            shr bl, 1
            jc not_even
                std
                stosb ; move the byte from AL into ES:EDI
                
            not_even:
                loop parse_s_to_obtain_d
                
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
