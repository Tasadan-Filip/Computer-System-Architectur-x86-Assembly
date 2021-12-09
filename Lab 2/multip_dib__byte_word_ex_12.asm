bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; a,b,c,d-byte, e,f,g,h-word
; (a*d+e)/[c+h/(c-b)]

segment data use32 class=data
    a db 5
    d db 20
    e dw 100
    c db 20
    b db 10
    h dw 50
    

; our code starts here
segment code use32 class=code
    start:
        mov al, [a]
        mul byte [d]
        
        add ax, [e] ; ax = (a*d+e) (ax = 200)
        
        mov bx, ax; bx = (a*d+e) (bx = 200)
        
        mov ax, [h]
        
        mov cl, [c]
        sub cl, [b]
        
        div cl ; al = h/(c-b) (al = 5)
        
        add al, [c] ; al = c+h/(c-b) (al = 25)
        
        mov cl, al
        mov ax, bx ;ax = (a*d+e) (ax = 200)
        div cl ; ax = (a*d+e)/[ c+h/(c-b) ]
        ; al = 8
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
