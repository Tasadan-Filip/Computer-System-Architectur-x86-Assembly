bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fread, fclose, fprintf

import exit msvcrt.dll    
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import fread msvcrt.dll

; Write a program that reads a text file that contains sentences (sentences are separated by character '/') and writes in a different file only the sentences of idex of the form 2k + 1 (i.e. write sentences 1, 3, 5, ...). The name of the 2 files are given in the data segment
segment data use32 class=data
    last_char db 0
    source_file_name db "source_file.txt", 0
    result_file_name db "result_file.txt", 0
    read_open_format db "r", 0 
    write_open_format db "w", 0
    source_file_descriptor resd 1
    result_file_descriptor resd 1
    len equ 100
    buffer resb len
    format_char db "%c", 0
    
segment code use32 class=code
    start:
        ; Step 1: open first file 
        
        push dword read_open_format
        push dword source_file_name
        call [fopen]
        add esp, 4 * 2
        
        mov dword [source_file_descriptor], eax
        
        cmp eax, 0
        je fin
        
        ; Step 2: open second file 
        
        push dword write_open_format
        push dword result_file_name
        call [fopen]
        add esp, 4 * 2
        
        mov dword [result_file_descriptor], eax
        
        cmp eax, 0
        je fin
        
        ; Step 3 read all chars from file
        
        mov ebx, 1 ; ebx will be the counter of current sentence
        
        loop_to_read_all_chars:
            push dword [source_file_descriptor]
            push dword len
            push 1
            push buffer
            call [fread]
            add esp, 4 * 4
            
            cmp eax, 0
            je close_files
            
            mov esi, buffer
            mov ecx, eax
            
            parse_buffer:
                push ecx
                mov eax, 0
                lodsb ; move the byte from DS:ESI into AL
                
                cmp al, 0
                je fin_of_parse_buffer
                
                cmp al, '/'
                je new_sentence
                
                test ebx, 1
                jnz print_sentence_to_destination_file
                jmp last_command_of_parse_buffer
                
                print_sentence_to_destination_file:
                    mov [last_char], al
                    push eax
                    push format_char
                    push dword [result_file_descriptor]
                    call [fprintf]
                    add esp, 4 * 3
                    jmp last_command_of_parse_buffer
                
                new_sentence:
                    inc ebx
                    
                last_command_of_parse_buffer:
                pop ecx
                loop parse_buffer
                
            fin_of_parse_buffer:
                jmp loop_to_read_all_chars
            
        close_files:
            push dword [source_file_descriptor]
            call [fclose]
            add esp, 4 * 1
            
            push dword [result_file_descriptor]
            call [fclose]
            add esp, 4 * 1
        fin:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
