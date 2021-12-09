bits 32 


global start        


extern exit, scanf, append_to_sir_final, revert_sir            
import exit msvcrt.dll    
import scanf msvcrt.dll

segment data use32 class=data
nr dd 0
    reverted_sir_final resd 51
    sir_final resd 51
    sir_initial resd 51
    len_s equ $ - sir_initial
    format_number db "%d", 0
        
segment code use32 class=code
    start:
        
        mov ebx, 0 ; ebx will contain the value of the last free element from sir_final
        read_numbers_loop:
            push nr
            push format_number
            call [scanf]
            add esp, 4 * 2
            
            cmp dword [nr], 0
            je fin_of_read
            
            push dword [nr]
            push sir_final
            call append_to_sir_final
            add esp, 4 * 2
            
            jmp read_numbers_loop
        
        fin_of_read:
            dec ebx
            mov edi, 0
            
            while_ebx:
                cmp ebx, 0
                jl fin
                
                push sir_final
                push reverted_sir_final
                call revert_sir
                add esp, 4 * 2
                
                jmp while_ebx
                
        fin:
        push    dword 0      
        call    [exit]      
