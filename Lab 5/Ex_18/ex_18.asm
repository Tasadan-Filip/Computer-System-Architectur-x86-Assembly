bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; Two byte strings A and B are given. Obtain the string R that contains only the odd positive elements of the two strings
segment data use32 class=data
   a db 2, 1, 3, -3
   len_a equ $ - a
   b db 4, 5, -5, 7
   len_b equ $ - b
   r resb len_a + len_b
   
   
segment code use32 class=code
    start:
        mov esi, a
        mov edi, r
        
        cld
        mov ecx, len_a
        
        parse_a:
            lodsb 
            
            cmp al, 0
            jle last_command_of_parse_a
            
            test al, 1
            jz last_command_of_parse_a
            
            stosb
            
            last_command_of_parse_a:
                loop parse_a
        
        
        mov esi, b
        mov ecx, len_b
        
        parse_b:
            lodsb 
            
            cmp al, 0
            jle last_command_of_parse_b
            
            test al, 1
            jz last_command_of_parse_b
            
            stosb
            
            last_command_of_parse_b:
                loop parse_b
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
