bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    

; Two byte strings S1 and S2 are given, having the same length. Obtain the string D so that each element of D represents the maximum of the corresponding elements from S1 and S2.  
segment data use32 class=data
    s1 db 1, 3, 6, 2, 3, 7
    s2 db 6, 3, 8, 1, 2, 5
    len_s equ $ - s2
    d resb len_s
   
segment code use32 class=code
    start:
        mov edi, d
        
        mov ecx, len_s
        mov ebx, 0
        
        cld
        
        parse_s1_and_s2_to_obtain_d:
            
            mov al, [s1 + ebx]
            
            cmp al, [s2 + ebx]
            ja elem_from_s1_is_greater
            
            mov al, [s2 + ebx]
            
            elem_from_s1_is_greater:
                
            stosb
            
            inc ebx
            loop parse_s1_and_s2_to_obtain_d
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
