.model huge

.stack 100h

.data          
    InpMsg db 'Enter: $' 
    STR db 100 dup(?)
    Flag db 0
    
                    
.code 
    MAIN proc   
        mov ax, @DATA
        mov ds, ax  
        
        lea si, STR
        call ReadStr 
        
        lea si, STR
        START:
        cmp [si], '$' 
        jz STOP
        
        mov dl, [si]  
        call IsUpper
        cmp Flag, 1
        jz CONVERT
        
        mov dl, [si]
        call IsLower
        cmp Flag, 1
        jz CONVERT
        inc si
        jmp START 
        
        CONVERT:  
        xor [si], 20h
        inc si  
        jmp START
        
        STOP:
        lea dx , STR
        mov ah, 09h
        int 21h
            
            
        call NewLine
        mov ah, 4ch
        int 21h
        
    MAIN endp
    
    ReadStr proc
        mov ah, 09  
        lea dx, InpMsg
        int 21h
          
        STARTInReadStr:
        mov ah, 01h
        int 21h 
        cmp al, 0dh
        jz STOPInReadStr
        mov [si], al
        inc si
        jmp STARTInReadStr
            
        STOPInReadStr:
        mov [si], '$'
        call NewLine
            
        ret
    ReadStr endp
    
    NewLine proc
        mov ah, 02h
        mov dl, 0dh
        int 21h
        mov dl, 0ah
        int 21h
        ret
    NewLine endp
    
    IsUpper proc
        mov Flag, 0
        cmp dl, 41h
        jl LASTInIsUpper
        cmp dl, 5ah
        jg LASTInIsUpper
        mov Flag,1   
        
        LASTInIsUpper: 
        ret
    IsUpper endp
   
    IsLower proc
        mov Flag, 0
        cmp dl, 61h
        jl LASTInIsLower
        cmp dl, 7ah
        jg LASTInIsLower
        mov Flag, 1   
        
        LASTInIsLower:
        ret
    IsLower endp
        
    
end MAIN
