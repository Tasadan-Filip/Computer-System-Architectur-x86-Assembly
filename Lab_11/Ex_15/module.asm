bits 32

global add_digit_to_binary

segment code use32 class=code
   add_digit_to_binary:
        
        mov eax, [esp + 4] ; the current char 
        mov edx, [esp + 8] ; the address of the binary number
        
        cmp al, 'b'
        je reinitialize_number
            sub al, '0'
            shl byte [edx], 1
            add byte [edx], al
        
        jmp fin
        reinitialize_number:
            mov eax, -1 
        
        fin:
            ret