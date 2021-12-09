bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    


;A string of doublewords is given. Obtain the list made out of the high bytes of the high words of each doubleword from the given list with the property that these bytes are multiple of 3.
segment data use32 class=data
    s dd 12345678h, 1A2B3C4Dh, 0xFE98DC76
    len_s equ $ - s
    d resb len_s / 4
    separator db 0xFF
    aux_number dd 0
    
segment code use32 class=code
    start:
        mov esi, s
        mov edi, d
        
        mov ecx, len_s / 4
        
        cld
        
        parse_s_to_obtain_r:
            lodsd ; move the dword from DS:ESI into EAX
            
            mov dword [aux_number], eax
            
            mov ax, 0
            mov al, [aux_number + 3]
            
            mov dl, al ; save the value of the highest bit because we are going to divide ax with 3
            
            mov bl, 3 
            div bl ; divide ax with 3 ( the remanider will be in ah)
            
            cmp ah, 0
            jne not_multiple_of_3
            
            mov al, dl
            stosb ; move the byte from AL into ES:EDI
            
            not_multiple_of_3:
                loop parse_s_to_obtain_r
            
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
