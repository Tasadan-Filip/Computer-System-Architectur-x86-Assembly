bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; Two character strings S1 and S2 are given. Obtain the string D by concatenating the elements found on odd positions in S2 and the elements found on even positions in S1.
segment data use32 class=data
    s1 db 'a', 'b', 'c', 'd', 'e', 'f'
    len_s1 equ $ - s1
    s1_terminator db 0, 0
    s2 db '1', '2', '3', '4', '5'
    len_s2 equ $ - s2
    s2_terminator db 0, 0
    d times (len_s1 + len_s2) / 2 + 1 db 0
    
segment code use32 class=code
    start:
        cld
        mov edi, d
        mov esi, s2
        parse_s2_on_odd_positions:
            lodsb 
            
            cmp al, 0
            je fin_of_parse_s2
            
            stosb
            inc esi
            jmp parse_s2_on_odd_positions
            
        fin_of_parse_s2:
        
        mov esi, s1 + 1
        parse_s1_on_odd_positions:
            lodsb 
            
            cmp al, 0
            je fin_of_parse_s1
            
            stosb
            inc esi
            jmp parse_s1_on_odd_positions
            
        fin_of_parse_s1:
        
        
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
