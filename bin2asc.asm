.model TINY
.stack 100H

.data
    getMsg db 10, 13, "Enter the binary data : $"

.code
.startup
    MOV AX, @data
    MOV DS, AX

    MOV AH, 09H
    MOV DX, OFFSET getMsg
    INT 21H

    MOV DL, 0
    MOV CL, 8
    loop_input:
        MOV AH, 01H
        INT 21H
        SUB AL, 30H
        ROL DL, 1
        ADD DL, AL
        loop loop_input
        
    MOV AH, 02H
    INT 21H
    
.exit
end
