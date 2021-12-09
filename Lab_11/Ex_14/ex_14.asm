bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, gets, scanf, printf
import exit msvcrt.dll    
import gets msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
; Read an integer (positive number) n from keyboard. Then read n sentences containing at least n words (no validation needed).
; Print the string containing the concatenation of the word i of the sentence i, for i=1,n (separated by a space).
segment data use32 class=data
    number_of_string db 0
    format_read_decimal db "%d", 0
    to_be_printed db "n=", 0
    last_red_string resb 101
    result_sentence resb 303
    format_print_string db "%s", 0

segment code use32 class=code
    start:
        push to_be_printed
        call [printf]
        add esp, 4 * 1
    
        push number_of_string
        push format_read_decimal
        call [scanf]
        add esp, 4 * 2
        
        
        
        push last_red_string
        call [gets]
        add esp, 4 * 1
        
        mov ecx, 0
        mov cl, [number_of_string]
        
        
        mov ebx, 0
        mov edi, result_sentence
        
        read_strings_loop:
            push ecx
            
            push last_red_string
            call [gets]
            add esp, 4 * 1
            
            mov edx, 0 ; edx will keep count of number of spaces
            mov esi, last_red_string
            cld
            
            cmp edx, ebx
            je save_word_in_memory
            
            loop_in_last_sentence:
                lodsb ; move the byte from DS:ESI into AL
                cmp al, ' '
                je increse_edx
                jmp final_command_in_loop_last_sentence
                
                increse_edx:
                    inc edx
                    cmp edx, ebx
                    je save_word_in_memory
                    
                final_command_in_loop_last_sentence:
                    jmp loop_in_last_sentence
            
            
            save_word_in_memory:
                   lodsb ; move the byte from DS:ESI into AL
                   cmp al, ' ' 
                   je end_of_loop
                   stosb ; move the byte from AL into ES:EDI
                   jmp save_word_in_memory
                
            end_of_loop:
                mov al, ' ' 
                stosb
                
                inc ebx
                pop ecx
                loop read_strings_loop
            
            push result_sentence
            push format_print_string
            call [printf]
            add esp, 4 * 2
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
