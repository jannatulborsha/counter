.model huge

.stack 100h

.data 
    InOutNum dw 0h
    tmp dw 0h
    num dw 0h
    str db 255(?)

.code 
    MAIN proc
    mov ax, @DATA
    mov ds, ax

    
    call Read
    call NewLine
    mov ax, InOutNum
    mov num, ax
    
    mov tmp, 1
    mov cx, num
    TOP:
    mov ax, tmp
    mul cx
    mov tmp, ax
    LOOP TOP;
          
    mov ax, tmp
    mov InOutNum, ax        
    call PRINT 
    
    call NewLine
    mov ah, 4ch
    int 21h
    MAIN endp
    
    Read proc 
        mov InOutNum, 0
        mov ah, 1
        STARTInRead:
        int 21h
        cmp al, 0dh
        jz STOPInRead
        sub al, 48
        mov bl, al 
        mov bh, 0
        mov ax, InOutNum
        mov cx, 10
        mul cx
        add ax, bx
        mov InOutNum, ax
        mov ah, 1
        jmp STARTInRead 
        STOPInRead:
        ret
    Read endp
    
    PRINT proc  
        mov cx, 10
        lea si, str 
        mov [si], '$'
        inc si
        STARTR:    
        mov ax, InOutNum  
        mov dx, 0
        div cx
        mov bx, dx 
        mov InOutNum, ax
        add dx, 48
        mov [si], dx
        inc si
        cmp InOutNum, 0
        jnz STARTR
        dec si
        STARTP:
        mov dl, [si]
        mov ah, 02h
        int 21h  
        dec si
        cmp [si], '$'
        jnz STARTP
        ret  
    PRINT endp

    
    NewLine proc
        mov ah, 2
        mov dl, 0dh       
        int 21h
        mov dl, 0ah 
        int 21h 
        ret
    NewLine endp
   

end MAIN
