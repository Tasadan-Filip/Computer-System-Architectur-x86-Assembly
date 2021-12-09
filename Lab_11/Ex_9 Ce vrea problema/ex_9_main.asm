bits 32 

global start, list_of_numbers, current_number       


extern exit, scanf, printf, transfrom_to_decimal        
import exit msvcrt.dll   
import printf msvcrt.dll 
import scanf msvcrt.dll 

segment data use32 class=data
    len_of_string dd 0
    format_string db"%s", 0
    format_decimal db "%d", 0
    format_print_decimal db "%d", 10, 0
    format_unsigned db "%u", 10, 0
    current_number resd 1
    list_of_numbers times 25 db 0
    


segment code use32 class=code
    start:
       push len_of_string
       push format_decimal
       call [scanf]
       add esp, 4 * 2
       
       mov ecx, [len_of_string]
       mov ebx, 0 
       
        while_len_of_string_bigger_than_0:
            push ecx
            
            push current_number
            push format_string
            call [scanf]
            add esp, 4 * 2
            
            
            call transfrom_to_decimal

            
            pop ecx
            loop while_len_of_string_bigger_than_0
        
        mov ebx, 0
        loop_to_print_numbers:
             
            cmp dword [list_of_numbers + ebx], 0
            jz fin
            
            push dword [list_of_numbers + ebx]
            push format_unsigned
            call [printf]
            add esp, 4 * 2
            
            push dword [list_of_numbers + ebx]
            push format_print_decimal
            call [printf]
            add esp, 4 * 2
            
            add ebx, 4
            jmp loop_to_print_numbers
            
        fin:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
