bits 32 

global append_to_sir_final, revert_sir

segment code use32 class=code
    append_to_sir_final:
        mov eax, [esp + 8] ; the value of the number
        mov edx, [esp + 4] ; the address of sir_final
        
        shl eax, 1
        mov dword [edx + ebx], eax
        inc ebx
        
        ret
    
    revert_sir:
        mov eax, [esp + 8] ; the addres of sir_final
        mov edx, [esp + 4] ; the addres of reverted_sir_final
        
        mov ecx, [eax + ebx]
        mov [edx + edi], ecx
        
        dec ebx
        inc edi
        
        ret
        
        