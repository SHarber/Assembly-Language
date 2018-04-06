TITLE Program Template     (template.asm)

; Author: Sarah Harber
; Course / Project ID Program 3: Integer Accumulator                Date:02/10/17
; Description: Program that takes negative numbers from -1 to -100 from the user until they enter a non-negative number, it then shows the sum of the
; valid numbers and the rounded average.

INCLUDE Irvine32.inc

; (insert constant definitions here)
lowerLimit = -100 ; Constant Variable for the Lower Limit
upperLimit = -1 ; Constant Variable for Upper Limit

.data
; (insert variable definitions here)
title1 BYTE "Welcome to Integer Accumulator by Sarah Harber", 0 ; Title of the program and programmer's name
getUsersName BYTE "What is your name?", 0 ; Ask for the user's names
usersName BYTE 21 DUP(0) ; Input buffer
byteCount DWORD ? ; Holds counter
greeting BYTE "Hello, ", 0 ; Greeting the user.
instructions1 BYTE "Please enter numbers in [-100, -1].", 0 ; First line of instructions
instructions2 BYTE "Enter a non-negative number when you are finished to see the results.", 0 ; Second Line of Instructions
prompt4Num BYTE ".) Enter number: ", 0 ; Prompt to have user enter a number
numEntered DWORD 0 ; Number entered by user
counter DWORD 0 ; Counter for Num of Integers Entered
validNum1 BYTE "You entered ", 0 ; String for the valid numbers
validNum2 BYTE " valid numbers", 0 ; String for valid numbers
sum DWORD 0 ; Sum of the numbers entered
sumString BYTE "The sum of your valid numbers is ", 0 ; String for sum
average DWORD 0 ; Average of the numbers entered (rounded to the nearest integer)
averageString BYTE "The rounded average is ", 0 ; String for the average.
Goodbye BYTE "Thank you for playing Integer Accumulator! It's been a pleasure to meet you, ", 0 ; Goodbye Message
extraCredit BYTE "** EC: Number the lines during user input **", 0 ; Extra Credit
Counter1 DWORD 1 ; Set EC Counter





.code
main PROC
; (insert executable instructions here)

;Display title and Programmer's name.
Title:
	mov edx, OFFSET title1 
	call WriteString
	call Crlf
	call Crlf

;Ask for the user's name
UserNames:
	mov edx, OFFSET getUsersName
	call WriteString
	call Crlf
	mov edx, OFFSET usersName ; Point to the buffer
	mov ecx, SIZEOF usersName ; Specifymax characters
	call ReadString ; Input the string
	mov byteCount, eax ; Number of characters
	call Crlf ; Clear the Line

; Greet THe User
DisplayGreeting:

	mov edx, OFFSET greeting ; Move greeting to write the string
	call WriteString ; Write greeting to register
	mov edx, OFFSET usersName ; Move user's name to reg
	call WriteString ; Write user's name.
	call Crlf ; Clear the Line
	call Crlf ; Clear the Line

;Display the Instructions and EC
DisplayInstructions:
	mov edx, OFFSET instructions1 ; Move instructions 1 to write the string
	call WriteString ; Write instructions to register
	call Crlf ; Clear the line
	mov edx, OFFSET instructions2 ; MOve isturctions 2 to write the string
	call WriteString ; Write instructions to register
	call Crlf ; Clear the line
	mov edx, OFFSET extraCredit ; Move extra Credit to edx
	call WriteString ; Write extra credit to register
	call Crlf ; Clear the Line
	call Crlf ; Clear the Line



PromptNum:
	mov eax, counter1 ; Move counter1 (Line Counter) to eax
	call WriteDec ; Write the counter to the line
	mov edx, OFFSET prompt4Num ; Prompt user to enter a number
	call WriteString ; Write prompt4num to register
	call ReadInt ; Get Number Entered to by User
	mov numEntered, eax
	inc counter1 ; Increase counter 1
	
Validate:
	cmp  numEntered, lowerLimit ; Compare the number entered to the lower limit.
	jl PromptNum ; If num entered is below the lower Limit jump back and Prompt the user to enter another number
	cmp numEntered, upperLimit ; Compare the number entered to the upper limit.
	jg Display ; If num entered is above the upper limit

Calculate:
	inc counter ; increase counter by 1.
	mov eax, numEntered ; Move number entered to eax
	add Sum, eax ; Add the number entered to the sum
	mov eax, sum ; Move sum to edx to calculate 
	cdq
	mov ebx, counter ; Move counter to ebx
	idiv ebx ; Perform devision
	mov average, eax ; Move edx to average
	jmp PromptNum


Display:
	call Crlf ; Clear Line
	mov edx, OFFSET validNum1 ; move validNum string to edx
	call WriteString ; Write string to register
	mov eax, counter ; Move counter to eax
	call WriteDec ; Write integer to the register
	mov edx, OFFSET validNum2 ; move ValidNum 2 to edx
	call WriteString ; Write to register
	call Crlf ; Clear the line

	mov edx, OFFSET sumString ; move sumString string to edx
	call WriteString ; Write string to register
	mov eax, sum ; Move sum to eax
	call WriteInt ; Write integer to the register
	call Crlf ; Clear the line

	mov edx, OFFSET averageString ; move averageString string to edx
	call WriteString ; Write string to register
	mov eax, average ; Move average to eax
	call WriteInt ; Write integer to the register
	call Crlf ; Clear the line
	call Crlf ; Clear the line
	mov edx, OFFSET goodbye ; Move gooddbye to edx
	call WriteString ; Call Write String
	mov edx, OFFSET usersName ; Move user's name to edx
	call WriteString ; Call Write String
	call Crlf ; Clear the line.
	call Crlf ; Clear the line





	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main