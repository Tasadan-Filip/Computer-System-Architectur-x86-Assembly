bits 32 


global start        


extern exit, add_digit_to_binary               
import exit msvcrt.dll    
segment data use32 class=data
    binary_number db 0
    sir_final times 10 db 0
    sir db '10100111b', '01100011b', '110b', '101011b'
    len_sir equ $ - sir
    current_binary_string resb 9
    current_char db 0
segment code use32 class=code
    start:
    
        mov ecx, 0
        mov ebx, 0
        parse_sir_loop:
            cmp ecx, len_sir
            je fin_of_parse
            
            movzx eax, byte [sir + ecx]
            
            push binary_number
            push eax
            call add_digit_to_binary
            add esp, 4 * 2
            
            cmp eax, -1
            jne final_command
                
                mov al, [binary_number]
                mov byte [sir_final + ebx], al
                mov byte [binary_number], 0
                inc ebx
            
            final_command:
                inc ecx
                jmp parse_sir_loop
                
        fin_of_parse:
        push    dword 0      
        call    [exit]       
