.model TINY
.stack 100H

.data 
    getNum db 10, 13, "Enter the ascii. $"
    showNum db 10, 13, "The binary is : $"

.code
.startup

    MOV AX, @data
    MOV DS, AX

    MOV DX, OFFSET getNum
    MOV AH, 09H
    INT 21H

    MOV AH, 1
    INT 21H
    MOV BL, AL

    MOV CL, 8
    loop_rotate:
        ROL BL, 1
        MOV DL, BL
        AND DL, 1
        ADD DL, 30H
        MOV AH, 02H
        int 21H
        loop loop_rotate

.exit
end