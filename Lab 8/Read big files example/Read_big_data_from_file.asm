bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf, fread, printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    
import fopen msvcrt.dll 
import fclose msvcrt.dll 
import fprintf msvcrt.dll 
import fread msvcrt.dll
import printf msvcrt.dll
; A text file is given. Read the content of the file, count the number of vowels and display the result on the screen. The name of text file is defined in the data segment.
segment data use32 class=data
    
    file_name db "read_big.txt", 0
    access_mode db "r", 0
    len equ 100
    file_descriptor dd -1
    buffer resb len
    terminator db 0
    nr_car_citite dd 0
segment code use32 class=code
    start:
        ;fopen(file_name, access_mode)
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp, 4 * 2
        
        mov [file_descriptor], eax ; store the file descriptor returend by fopen
        
        ; check if fopen() has successfuly created the file (EAX != 0)
        
        cmp eax, 0
        je final
        
        loop_to_read_all:
          ; citim o parte (100 caractere) din textul in fisierul deschis folosind functia fread
          ; eax = fread(buffer, 1, len, descriptor_fis)
            push dword [file_descriptor]
            push len
            push 1
            push dword buffer
            call [fread]
            add esp, 4 * 4
            
            
            ;eax = numar de caractere/ bytes citite
            cmp eax, 0
            je close_file
            
            mov dword [nr_car_citite], eax
            
            push dword buffer
            call [printf]
            add esp, 4 * 1
            
            
            jmp loop_to_read_all
        close_file:
            ;fclose(file_descriptor)
            push dword [file_descriptor]
            call [fclose]
            add esp, 4 * 1
        
        
        final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
