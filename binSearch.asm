.model TINY
.stack 100H

.data
    arr db 10 dup(?)
    arrSize db ?
    target db ?
    hi db ?
    lo db ?
    getSize db 10, 13,"Enter the array size: $ "
    getTarget db 10, 13, "Enter the target element : $"
    getArray db 10, 13, "Enter the array elements: $"
    foundMsg db 10, 13,"Element found ! $"
    notFoundMsg db 10, 13,"Element not found! $"

.code
.startup

    MOV AX, @data
    MOV DS, AX

    MOV DX, OFFSET getSize
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV arrSize, AL

    MOV DX, OFFSET getArray
    MOV AH, 09H
    INT 21H

    MOV CL, arrSize
    MOV SI, OFFSET arr
    input_loop :
        MOV AH, 01H
        INT 21H
        SUB AL, 30H
        MOV [SI], AL
        INC SI
        LOOP input_loop

    MOV DX, OFFSET getTarget
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV target, AL

    MOV lo, 0
    MOV AL, arrSize
    MOV hi, AL
    MOV SI, OFFSET arr
    MOV BX, 0 ; MID

    search_loop : 
        MOV AL, hi
        CMP lo, AL
        JG notFound; Not found if lo > hi.

        MOV BL, lo
        MOV AL, hi
        ADD BL, AL
        SHR BL, 1

        MOV AL, target
        CMP [SI + BX], AL
        JE found
        JG left
        JL right

    left:
        MOV AL, BL
        SUB BL, 1 
        MOV hi, BL
        JMP search_loop

    right:
        ADD BL, 1
        MOV lo, BL
        JMP search_loop

    found:
        MOV DX, OFFSET foundMsg
        MOV AH, 09H
        INT 21H
        JMP finally

    notFound:
        MOV DX, OFFSET notFoundMsg
        MOV AH, 09H
        INT 21H

finally:
.exit 
end

