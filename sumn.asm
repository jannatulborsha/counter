.model huge

.stack 100h

.data 
    number db 0h
    tmp db 0h
    num db 0h

.code 
    MAIN proc
    mov ax, @DATA
    mov ds, ax

    mov ah, 1
    READ:
        int 21h
        cmp al, 0dh
        jz NEXT
        sub al, 48
        mov bl, al
        mov al, number
        mov cl, 10
        mul cl
        add al, bl
        mov number, al
        mov ah, 1
        jmp READ
    NEXT:
        mov ah, 2
        mov dl, 0dh       
        int 21h
        mov dl, 0ah 
        int 21h
        mov dl, number
        add dl, 48
        mov ah, 2
        int 21h
    mov bl, number
    mov num, bl
    ;call PRINT
    mov bl, number
    mov num, bl
    call REVERSE
    mov bl, num
    mov num, bl
    ;call REVERSE
    ;call PRINT
    mov dl, num
    add dl, 48
    mov ah, 2
    int 21h

    mov ah, 4ch
    int 21h
    MAIN endp

    REVERSE proc
        mov cl, 10
        mov tmp, 0
        START:
            mov al, num
            mov bl, num
            div cl
            mov num, ah
            mov al, bl
            div cl
            mov bl, al
            mov dl, bl
            add dl, 48
            mov ah, 2
            int 21h
            mov al, tmp
            mul cl
            add al, bl
            mov tmp, al
            cmp num, 0
            jnz START
            mov dl, tmp
            mov num, dl
            ret
    REVERSE endp

    PRINT proc
        mov cl, 10
        START1:
            mov al, num
            div cl
            mov tmp, al
            mov al, num
            div cl
            mov num, ah
            mov dl, tmp
            add dl, 48
            mov ah, 02
            int 21h
            cmp num, 0
            jnz START1
            mov ah, 2
            mov dl, 0dh       
            int 21h
            mov dl, 0ah 
            int 21h
            ret
    PRINT endp

end MAIN