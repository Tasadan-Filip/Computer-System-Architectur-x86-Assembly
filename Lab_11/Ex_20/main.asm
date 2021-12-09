bits 32 


global start        


extern exit, scanf, printf, is_prime              
import exit msvcrt.dll    
import scanf msvcrt.dll   
import printf msvcrt.dll   

segment data use32 class=data
   sir resd 101
   sir_final resd 101
   format_int db "%u", 0
   
   
segment code use32 class=code
    start:
        mov esi, sir
        
        read_numbers:
            push esi
            push format_int
            call [scanf]
            add esp, 4 * 2
            
            cmp dword [esi], 0
            je fin_of_read
            
            add esi, 4
            
            jmp read_numbers
            
        fin_of_read:
        
        mov esi, sir
        cld
        
        parse_sir_to_find_primes:
            lodsd ; move the dword from DS:ESI into EAX and add to ESI the value 16
            
            cmp eax, 0
            je fin
            
            mov ebx, eax
        
            push eax
            call is_prime
            add esp, 4
            
            cmp eax, 1
            jne not_prime
            
            push ebx
            push format_int
            call [printf]
            add esp, 4 * 2
            
            not_prime:
                jmp parse_sir_to_find_primes
                
        fin:
        push    dword 0      
        call    [exit]       
