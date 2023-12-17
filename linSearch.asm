.model TINY
.stack 100H

.data
    arr db 10 dup(?)
    arrSize db ?
    target db ?
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
    input_loop: 
        MOV AH, 01H
        INT 21H
        MOV [SI], AL
        INC SI
        LOOP input_loop

    MOV DX, OFFSET getTarget
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    ; SUB AL, 30H
    MOV target, AL

    MOV CL, arrSize
    MOV SI, OFFSET arr
    find_loop:
        MOV AL, target
        CMP [SI], AL
        JE found
        INC SI
        LOOP find_loop

    notFound:
        MOV DX, OFFSET notFoundMsg
        MOV AH, 09H
        INT 21H
        JMP finally

    found:
        MOV DX, OFFSET foundMsg
        MOV AH, 09H
        INT 21H

    finally:
.exit
end