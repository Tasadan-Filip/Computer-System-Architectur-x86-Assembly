bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; A text file is given. Read the content of the file, count the number of vowels and display the result on the screen. The name of text file is defined in the data segment.
extern exit, fopen, fclose, printf, fread               

import exit msvcrt.dll    
import fopen msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
import fread msvcrt.dll
segment data use32 class=data
    file_name db "text_exercise1.txt", 0
    file_descriptor dd 0
    open_format db "r", 0
    format_print db "%c", 0
    len equ 100
    buffer resb len
    
    
segment code use32 class=code
    start:
        ; open the file
        push  dword open_format
        push dword file_name
        call [fopen]
        add esp, 4 * 2
        
        mov [file_descriptor], eax
        
        ;check if the file was opened correctly
        cmp eax, 0
        je fin
        
        loop_to_read_all_chars:
            push dword [file_descriptor]
            push len
            push 1
            push buffer
            call [fread]
            add esp, 4 * 4
            
            ;If all the characters were red
            cmp eax, 0
            je close_file
            
            mov ecx, eax ;in ecx I will have the number of characters read correctly
            mov esi, buffer
            
            loop_in_buffer_to_print_vowels:
                push ecx
                
                mov eax, 0
                lodsb ; move the byte from DS:ESI into AL
                
                cmp al, 'a'
                je is_vowel
                
                cmp al, 'e'
                je is_vowel
                
                cmp al, 'i'
                je is_vowel
                
                cmp al, 'o'
                je is_vowel
                
                cmp al, 'u'
                je is_vowel
                
                jmp last_command
                
                is_vowel:
                    push eax
                    push dword format_print
                    call [printf]
                    add esp, 4 * 2
                
                last_command:
                pop ecx
                loop loop_in_buffer_to_print_vowels
            
            jmp loop_to_read_all_chars
                
        close_file:
            push dword [file_descriptor]
            call [fclose]
            add esp, 4 * 1
        fin:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
