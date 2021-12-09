bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fread, fclose, printf              
import exit msvcrt.dll    
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll

; A text file is given. Read the content of the file, count the number of even digits and display the result on the screen. The name of text file is defined in the data segment.
segment data use32 class=data
     open_format db "r", 0
     file_name db "text_exercise3.txt"
     file_descriptor resd 1
     len equ 100
     buffer resb len
     terminator db 0
     number_of_even_digits dd 0
     print_format db "The number of even digits in the text file is: %u", 0
     
    
segment code use32 class=code
    start:
        ; Step 1: open the file
        push dword open_format
        push dword file_name
        call [fopen]
        add esp, 4 * 2
        
        mov [file_descriptor], eax
        
        cmp eax, 0 ; check if the file was opened correclty (eax != 0)
        je fin
        
        ; Step 2: read all characters from the file
        loop_to_read_all:
            push dword [file_descriptor]
            push dword len
            push 1
            push buffer
            call [fread]
            add esp, 4 * 4
            
            cmp eax, 0
            je close_file
            
            mov ecx, eax
            mov esi, buffer
            
            parse_the_buffer_to_search_for_even_numbers:
                push ecx
                
                lodsb ; move the byte from DS:ESI into AL (and increments esi with 1)
                
                cmp al, 0
                je fin_of_parsing_buffer
                
                cmp al, '0'
                jb last_command_of_this_loop
                
                cmp al, '9' 
                ja last_command_of_this_loop
                
                
                sub al, '0'
                movzx ax, al
                
                mov bl, 2
                
                div bl ; the remainder will be in ah 
                
                cmp ah, 0
                je is_even
                
                jmp last_command_of_this_loop
                is_even:
                    add dword [number_of_even_digits], 1
                    
                last_command_of_this_loop:
                    pop ecx
                    loop parse_the_buffer_to_search_for_even_numbers
            

            fin_of_parsing_buffer:
                jmp loop_to_read_all
        
        
        
        
        ; Step 3: close the file
        close_file:
            push dword [number_of_even_digits]
            push dword print_format
            call [printf]
            add esp, 4 * 2
            
            push dword [file_descriptor]
            call [fclose]
            add esp, 4 * 1
        
        fin:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
