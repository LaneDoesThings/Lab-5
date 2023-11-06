.equ READERROR, 0 

.text
.balign 4

.global main

main:

@r4 = Number of boards cut so far
@r5 = Linear length cut so far
@r6 = Length of board 1
@r7 = length of board 2
@r8 = length of board 3

inventory:
ldr r0, =strCutSoFar
mov r1, r4
mov r2, r3
bl printf

prompt:
   ldr r0, =strInputPrompt @prompt the user
   bl  printf

exit:

   mov r6, #0x01 
   svc 0    

.data

.balign 4
strInputPrompt: .asciz "How much would you like to cut off of the board (6-144): \n"

.balign 4
strCutSoFar: .asciz "Cut-It-Up-Saw\nBoards cut so far: %d\nLinear length of boards cut so far: %d inches\n"