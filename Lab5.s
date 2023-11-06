.equ READERROR, 0 

.text
.balign 4

.global main

main:

@r4 = Number of boards cut so far
mov r4, #0
@r5 = Linear length cut so far
mov r5, #0
@r6 = Length of board 1
mov r6, #144
@r7 = length of board 2
mov r7, #144
@r8 = length of board 3
mov r8, #144

inventory:
ldr r0, =strCutSoFar
mov r1, r4 @Number of boards cut so far
mov r2, r5 @How much was cut so far
bl printf

ldr r0, =strLengths
mov r1, r6 @Length of Board 1
mov r2, r7 @Length of Board 2
mov r3, r8 @Length of Board 3

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

.balign 4
strLengths: .asciz "Current Board Lengths:\nOne: %d\nTwo: %d\nThree: %d\n"
