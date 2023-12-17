.model small
.stack 100h

.data
    array db 10 dup(?)
    sizeArray db ?
    number db ?
    mid db ?
    msg db "Enter Size of Array: $"
    msg0 db 10,13,"Enter Number to Search: $"
    msg1 db 10,13,"Number Found$"
    msg2 db 10,13,"Number NOT Found$"
    msg3 db 10,13,"Enter Elements: $"

.code
.startup
    mov dx, offset msg ;size of array from user
    mov ah, 09h
    int 21h
    mov ah, 01h
    int 21h

    mov sizeArray, al
    sub sizeArray, 30h

    lea si, array
    mov cl, sizeArray
    mov ch, 0h
    mov bh, 0

    input:
        mov dx, offset msg3
        mov ah, 09h
        int 21h
        mov ah, 01h
        int 21h
        sub al, 30h
        mov [si], ax
        inc si
        loop input

    mov dx, offset msg0
    mov ah, 09h
    int 21h
    mov ah, 01h
    int 21h
    mov bl, al
    sub bl, 30h
    mov number, bl

    lea si, array
    mov bl, 0
    mov cl, sizeArray

    ;bl low
    ;cl high
    Search:
        cmp bl, cl
        jg notFound
        mov al, 0
        add al, bl
        add al, cl
        shr al, 1
        mov mid, al

    ; midCompare:
        mov dl, [si+mid]
        cmp dl, number
        je Found
        jg midGreater
        jmp midSmaller

    midGreater:
        mov cl, mid
        ; dec cl
        sub cl, 1
        jmp Search

    midSmaller:
        mov bl, mid
        inc bl
        jmp Search

    Found:
        mov dx, offset msg1
        mov ah, 09h
        int 21h
        jmp goAway
        
    notFound:
        mov dx, offset msg2
        mov ah, 09h
        int 21h
        jmp goAway

goAway:
mov ah, 4ch
int 21h
end
