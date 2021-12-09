bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
; a,b,c,d-byte, e,f,g,h-word
; [[b*c-(e+f)]/(a+d)

segment data use32 class=data
    b db 100
    c db 10
    e dw 500
    f dw 400
    a db 40
    d db 10

; our code starts here
segment code use32 class=code
    start:
        mov al, [b]
        mul byte [c]
        
        mov bx, [e]
        add bx, [f]
        
        sub ax, bx ; ax = [[b*c-(e+f)]
        
        mov bl, [a]
        add bl, [d] 
        
        div bl ; [[b*c-(e+f)]/(a+d)
        
        ; al = 2
        
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
