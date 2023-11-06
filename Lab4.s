.equ READERROR, 0 

.text
.balign 4

.global main

main:

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
   cmp r1, #100
   bgt outOfBounds
   cmp r1, #1
   blt outOfBounds

   mov r6, r1 @save the input into r6
   b evenStart

@set the registers for the even loop
evenStart:
   mov r5, #2
   mov r4, #0
   mov r8, #0
   ldr r0, =strEvenOutput
   mov r1, r6
   bl printf

   b evenNumbers

@loop through the even numbers until the input number is reached
evenNumbers:
   ldr r0, =numOutputPattern
   mov r1, r5
   bl printf

   add r4, r4, r5

   add r5, r5, #2
   cmp r5, r6
   blt evenNumbers

   b showSum

@set the registers for the odd loop
oddStart:
   mov r5, #1
   mov r4, #0
   mov r8, #1
   ldr r0, =strOddOutput
   mov r1, r6
   bl printf
   
   b oddNumbers

@loop through the odd numbers until the input number is reached
oddNumbers:
   ldr r0, =numOutputPattern
   mov r1, r5
   bl printf

   add r4, r4, r5

   add r5, r5, #2
   cmp r5, r6
   blt oddNumbers

   b showSum

@determine whether to show even or odd sum
showSum:
   cmp r8, #0
   beq evenSum
   b oddSum

@show the even sum
evenSum:
   ldr r0, =strEvenSumOutput
   mov r1, r4
   bl printf

   b oddStart

@show the odd sum
oddSum:
   ldr r0, =strOddSumOutput
   mov r1, r4
   bl printf

   b myexit

myexit:

   mov r6, #0x01 
   svc 0         

outOfBounds:
    ldr r0, =strOutOfBounds
    bl printf

    b getInput

readerror:

   ldr r0, =strInputPattern
   ldr r1, =strInputError  
   bl scanf               

   b prompt


.data

.balign 4
strInputPrompt: .asciz "Input a number (1-100): \n"

.balign 4
strOutputNum: .asciz "The number value is: %d \n"

.balign 4
numInputPattern: .asciz "%d"

.balign 4
numOutputPattern: .asciz "%d\n"

.balign 4
strInputPattern: .asciz "%[^\n]"

.balign 4
strInputError: .skip 100*4

.balign 4
intInput: .word 0

.balign 4
strOutOfBounds: .asciz "The number must be between 1 and 100\n"

.balign 4
strEvenOutput: .asciz "The even numbers from 1 to %d are:\n"

.balign 4
strOddOutput: .asciz "The odd numbers from 1 to %d are:\n"

.balign 4
strEvenSumOutput: .asciz "The even sum is: %d\n"

.balign 4
strOddSumOutput: .asciz "The odd sum is: %d\n"

.global printf

.global scanf
