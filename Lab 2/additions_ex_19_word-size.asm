bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a,b,c,d - word
; b+a-(4-d+2)+c+(a-b)

segment data use32 class=data
    a dw 250
    c dw 500
    b dw 250
    d dw 3


; our code starts here
segment code use32 class=code
    start:
        mov ax, [b]
        add ax, [a]
        
        mov bx, 4
        sub bx, [d]
        add bx, 2
        
        sub ax, bx
        add ax, [c]
        
        mov bx, [a]
        sub bx, [b]
        
        add ax, bx
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
