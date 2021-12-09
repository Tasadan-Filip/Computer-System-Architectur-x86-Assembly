bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; A list of doublewords is given. Obtain the list made out of the low bytes of the high words of each doubleword from the given list with the property that these bytes are palindromes in base 10.
segment data use32 class=data
    s dd 12CA5678h, 1A2C3C4Dh, 98FCDC76h
    len_s equ $ - s 
    separator db 0xFF
    d resb len_s / 4
    dword_aux_val dd 0
    aux_byte_value db 0
    
segment code use32 class=code
    start:
        mov esi, s
        mov edi, d
        
        cld
        mov ecx, len_s / 4
        
        parse_s_to_obtain_d:
           lodsd ; move the dword from DS:ESI into EAX 
           mov dword [dword_aux_val], eax
           
           mov al, [dword_aux_val + 2]
           
           mov byte [aux_byte_value], al
           
           ; check if the number is palindrome or not
           cmp al, 10
           
           jg bigger_than_10
           
           ; the number has one digit so it is palindrome
           stosb ; move the byte from AL into ES:EDI
           jmp fin_of_parsing
           
           bigger_than_10:
           cmp al, 100
           jg bigger_than_100
           movzx ax, al
           mov bl, 10
           
           div bl
           
           cmp al, ah
           jne fin_of_parsing
           
           mov al, [aux_byte_value]
           stosb ; move the byte from AL into ES:EDI
           jmp fin_of_parsing
           
           bigger_than_100:
                movzx ax, al
                
                mov bl, 10
                
                div bl
                
                mov dl, ah ; the last digit will be in dl (the remainder of the division)
                
                movzx ax, byte [aux_byte_value]
                
                mov bl, 100
                
                div bl
                
                cmp al, dl
                jne fin_of_parsing
                
                mov al, [aux_byte_value]
                stosb ; move the byte from AL into ES:ESI
                
                
            fin_of_parsing:
                loop parse_s_to_obtain_d
                
            
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
