.model TINY
.stack 100H

.data
    arr1 db 10 dup(?)
    arr2 db 10 dup(?)
    arrSize db ?

    getSize db "Enter the size of the array : $"
    getArr1 db 10, 13, "Enter the elements of array 1. $"
    getArr2 db 10, 13, "Enter the elements of array 2. $"
    showRes db 10, 13, "The result after addition is : $"

.code
.startup

    MOV AX, @data
    MOV DS, AX

    MOV DX, OFFSET getSize
    MOV AH, 09H
    INT 21H
;SIZE INPUT
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV arrSize, AL

    MOV DX, OFFSET getArr1
    MOV AH, 09H
    INT 21H

;ARRAY 1 INPUT
    MOV CL, arrSize
    MOV SI, OFFSET arr1
    arr1_input:
        MOV AH, 01H
        INT 21H
        SUB AL, 30H
        MOV [SI], AL
        INC SI
        LOOP arr1_input

    MOV DX, OFFSET getArr2
    MOV AH, 09H
    INT 21H
    
;ARRAY 2 INPUT
    MOV CL, arrSize
    MOV SI, OFFSET arr2
    arr2_input:
        MOV AH, 01H
        INT 21H
        SUB AL, 30H
        MOV [SI], AL
        INC SI
        LOOP arr2_input

;SUBTRACTION
    MOV SI, OFFSET arr1
    MOV BX, OFFSET arr2
    MOV CL, arrSize
    add_loop:
        MOV AL, [BX]
        SUB [SI], AL
        INC SI
        INC BX
        LOOP add_loop

    MOV DX, OFFSET showRes
    MOV AH, 09H
    INT 21H
;RESULT
    MOV CL, arrSize
    MOV SI, OFFSET arr1
    print_arr:
        MOV DL, [SI]
        ADD DL, 30H
        MOV AH, 02H
        INT 21H
        INC SI
        LOOP print_arr

.exit
end