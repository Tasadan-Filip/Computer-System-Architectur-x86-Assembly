bits 32 
extern list_of_numbers, current_number
global transfrom_to_decimal

segment data use32 class=data
     


segment code use32 class=code
    transfrom_to_decimal:
        mov esi, current_number
        
        mov ecx, 0 
        
        loop_in_number:
            cmp ecx, 4
            jz fin_of_loop
            
            mov al, [current_number + ecx]
            cmp al, '9'
            ja not_digit
            sub al, '0'
            jmp last_command_of_loop
            
            not_digit:
                sub al, 'A'
                add al, 10
            last_command_of_loop:
                mov [current_number + ecx], al
            inc ecx
            jmp loop_in_number
            
        fin_of_loop:
        mov ecx, 0
        mov edx, 0
        transf_from_hex_to_dec:
            push ecx
            cmp ecx, 4
            jz fin_of_proc
            mov al, [current_number + ecx]
            
            cmp ecx, 0
            jne next_1
            
            mov dl, al
            jmp fin_of_transf_funtion
            
            next_1:
            cmp ecx, 1
            jne next_2
            
            mov cl, 16
            mul cl
            
            add dl, al
            jmp fin_of_transf_funtion
            
            next_2:
            cmp ecx, 2
            jne next_3
            
            mov cl, 255
            mul cl
            
            add dx, ax
            add dl, al
            jmp fin_of_transf_funtion
            
            next_3:
            mov cl, al
            mov ax, 0
            mov al, cl
            
            mov cx, 4096
            mul cx
            
            add dx, ax
            
            fin_of_transf_funtion:
                pop ecx
                inc ecx
                jmp transf_from_hex_to_dec
            
        fin_of_proc:
        
        mov [list_of_numbers + ebx], edx
        mov dword [current_number], 0
        add ebx, 4
        
        ret
