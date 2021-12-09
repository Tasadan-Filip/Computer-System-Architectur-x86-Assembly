bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a,b,c,d-byte, e,f,g,h-word
; (a-c)*3+b*b
segment data use32 class=data
    a db 10
    c db 5
    b db 5

; our code starts here
segment code use32 class=code
    start:
        mov al, [a]
        sub al, [c]
        
        mov bl, 3
        mul bl ; ax = (a-c)*3
        
        mov bx, ax
        
        mov al, [b]
        mul byte [b]
        
        add bx, ax
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
