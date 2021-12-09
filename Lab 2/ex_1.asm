bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; ((a+b-c)*2 + d-5)*d
segment data use32 class=data
    a db 20
    b db 75
    c db 45
    d dw 105
    

; our code starts here
segment code use32 class=code
    start:
        mov al, [a]
        add al, [b]
        sub al, [c] ; al = (a+b-c)
        mov bl, 2
        mul bl ; ax = (a+b-c) * 2
        add ax, [d] ; ax = (a+b-c) * 2 + d
        sub ax, 5 ; ax = (a+b-c) * 2 + d - 5
        mov bx, [d]
        mul bx ; dx:ax = ((a+b-c) * 2 + d - 5) * d
        
        push dx
        push ax
        pop eax ; eax = ((a+b-c) * 2 + d - 5) * d
        
        ; eax = 21000
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
