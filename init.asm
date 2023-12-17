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

.exit
end