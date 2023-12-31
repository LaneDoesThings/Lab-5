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
    @r9 = amount to cut
    mov r9, #0

inventory:

    ldr r0, =strCutSoFar
    mov r1, r4 @Number of boards cut so far
    mov r2, r5 @How much was cut so far
    bl printf

    ldr r0, =strLengths
    mov r1, r6 @Length of Board 1
    mov r2, r7 @Length of Board 2
    mov r3, r8 @Length of Board 3

    bl printf

    @Add the lengths of the boards and if they are less than 18 then each one must be less than 6
    add r1, r6, r7 
    add r1, r1, r8
    cmp r1, #18
    blt endCut

prompt:
    ldr r0, =strInputPrompt @prompt the user
    bl  printf

getInput:

    ldr r0, =numInputPattern
    ldr r1, =intInput        
                            
    bl  scanf @get the users input    
    cmp r0, #READERROR      
    beq readerror            
    ldr r1, =intInput        
    ldr r1, [r1]             

    @determine if the input is out of bounds
    cmp r1, #144
    bgt outOfBounds
    cmp r1, #6
    blt outOfBounds

    mov r9, r1 @Store the amount to cut
    b cut1

cut1:
    cmp r6, #6 @Is Board 1 > 6"
    blt cut2 @If not check board 2
    cmp r9, r6 @Compare the length of Board 1 with the amount to cut
    bgt cut2 @If there isn't enough to cut check board 2

    sub r6, r6, r9 @Subtract the length to cut off from the board
    add r4, r4, #1 @Increase the number of boards cut by 1
    add r5, r5, r9 @Add the length of the cut board
    b inventory

cut2:
    cmp r7, #6 @Is Board 2 > 6"
    blt cut3 @If not check board 3
    cmp r9, r7 @Compare the length of Board 2 with the amount to cut
    bgt cut3 @If there isn't enough to cut check board 3

    sub r7, r7, r9 @Subtract the length to cut off from the board
    add r4, r4, #1 @Increase the number of boards cut by 1
    add r5, r5, r9 @Add the length of the cut board
    b inventory

cut3:
    cmp r8, #6 @Is Board 1 > 6"
    blt inventory @If not return back to the inventory
    cmp r9, r8 @Compare the length of Board 3 with the amount to cut
    bgt inventory @If there isn't enough to cut return back to the inventory

    sub r8, r8, r9 @Subtract the length to cut off from the board
    add r4, r4, #1 @Increase the number of boards cut by 1
    add r5, r5, r9 @Add the length of the cut board
    b inventory

endCut:
    ldr r0, =strLeftover @Shows the end message r1 already has the leftover from the less than 18 check
    bl printf

    b exit @uneeded because of the call stack but for readability that this is the end of the program

exit:
   mov r7, #0x01
   svc 0    

outOfBounds:
    ldr r0, =strOutOfBounds
    bl printf

    b prompt

readerror:

    ldr r0, =strInputPattern
    ldr r1, =strInputError  
    bl scanf               

    b prompt

.data

.balign 4
strInputPrompt: .asciz "How much would you like to cut off of the board (6-144): \n"

.balign 4
strCutSoFar: .asciz "Cut-It-Up-Saw\nBoards cut so far: %d\nLinear length of boards cut so far: %d inches\n"

.balign 4
strLengths: .asciz "Current Board Lengths:\nOne: %d\nTwo: %d\nThree: %d\n"

.balign 4
strOutOfBounds: .asciz "The number must be between 6 and 144\n"

.align 8
strLeftover: .asciz "Inventory levels have dropped below minimum levels and will now terminate.\nWaste is %d inches.\n"

.balign 4
numInputPattern: .asciz "%d"

.balign 4
intInput: .word 0

.balign 4
strInputError: .skip 100*4

.balign 4
strInputPattern: .asciz "%[^\n]"

.global printf

.global scanf
