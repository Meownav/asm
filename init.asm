.model TINY
.stack 100H

.data
    msg db "Hello, world! $";

.code
.startup

    MOV AX, @data
    MOV DS, AX

    MOV DX, OFFSET msg
    MOV AH, 09H
    INT 21H

    MOV AL, 7
    ADD AL, 30H
    MOV DL, AL
    MOV AH, 02H
    INT 21H
.exit
end