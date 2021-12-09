bits 32 

global is_prime
segment code use32 class=code
    is_prime:
        mov eax, [esp + 4]
        
        cmp eax, 1
        jbe not_prime
        
        cmp eax, 3
        jbe prime
        
        test eax, 1
        jz not_prime
        
        mov ecx, 3
        
        while_ecx_smaller_than_eax:
            cmp ecx, eax
            je prime
            
            push eax
            
            mov edx, 0
            div ecx
            
            cmp edx, 0
            je not_prime
            
            pop eax
            
            inc ecx
            jmp while_ecx_smaller_than_eax
            
        
        not_prime:
            mov eax, 0
            jmp fin
            
        prime:
            mov eax, 1
        fin:
            ret
        