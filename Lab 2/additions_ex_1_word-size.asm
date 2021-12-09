bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
; a,b,c,d - word 
; (c+b+a)-(d+d)
segment data use32 class=data
    a dw 10
    c dw 500
    b dw 490
    d dw 250

; our code starts here
segment code use32 class=code
    start:
        mov ax, [c]
        add ax, [b] ; ax = c + b
        add ax, [a] ; ax = c + b + a
        mov bx, [d] 
        shl bx, 1
        sub ax, bx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
