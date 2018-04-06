TITLE Program Template     (template.asm)

; Author: Sarah Harber
; Course / Project ID  Assignment 2               Date:
; Description:

INCLUDE Irvine32.inc

; (insert constant definitions here)
upperLimit equ 46 ;Upperlimit 46

.data

; (insert variable definitions here)

title1 BYTE "Fibonacci Numbers", 0 ;Title 
title2 BYTE "Programmed by Sarah Harber", 0 ;Programmer Name
get_users_names BYTE "What is your name?", 0 ;Ask for the user's names
username BYTE 21 DUP(0) ;Input buffer
byteCount DWORD ? ;Holds counter
greeting BYTE "Hello, ", 0 ; Greeting the user.
enterNums BYTE "Enter the number of Fibonacci terms to be displayed", 0 ;Enter the number
rangeStr BYTE "Give the number as an integer in the range [1 .. 46]", 0 ;Range Constraint
howMany BYTE "How many Fibonacci terms do you want?", 0 ;Terms wanted
outOfRange BYTE "Out of Range. Enter a number in [1 .. 46]", 0 ;Out of range 
nums DWORD ? ;Number entered by user.
spaces BYTE "    ", 0 ;Spaces
counter DWORD 6 ;
results BYTE "Results certified by Sarah Harber.", 0 ;Resuts string
goodbye BYTE "Goodbye, ", 0 ;Goodbye
.code
main PROC

; (insert executable instructions here)

;Display title 
Title:
	mov edx, OFFSET title1 
	call WriteString
	call Crlf

;Display Programmer Name
ProgrammerName:
	mov edx, OFFSET title2
	call WriteString
	call Crlf

;Ask for the user's name
UserNames:
	mov edx, OFFSET get_users_names
	call WriteString
	call Crlf
	mov edx, OFFSET username ; Point to the buffer
	mov ecx, SIZEOF username ; Specifymax characters
	call ReadString ; Input the string
	mov byteCount, eax ; Number of characters
	call Crlf ; Clear the Line

; Greet THe User
DisplayGreeting:
	mov edx, OFFSET greeting ; Move greeting to write the string
	call WriteString ; Write greeting to register
	mov edx, OFFSET username ; Move user's name to reg
	call WriteString ; Write user's name.
	call Crlf ; Clear the Line

; Ask user to enter a number
EnterNum:
	mov edx, OFFSET enterNums ; Move enterNums to be written.
	call WriteString ; Write enternums to screen
	call Crlf ; Clear the line
	mov edx, OFFSET rangeStr ; Move rangeStr to the reg.
	call WriteString ; Write rangeStr to the screen.
	call Crlf ; Clear the Line
	mov edx, OFFSET howMany ; Move the question to edx.
	call WriteString ;Write howMany to screen.
	call ReadInt ;Read the integer the user enters.
	mov nums, eax ; Move the value the user enters into nums
	call Crlf ; Clear line

;Validate user input
Validate:
	CMP nums, 1 ; Compare the nums entered by the user to 1.
	JL EnterNewNum ; Jump to Enter New Num
	CMP nums, upperLimit ; Compare the nums entered by the user is less than 46.
	JG EnterNewNum 
	mov ecx, nums ; Move nums to ECX to prepare for loop.
	Jmp Fibonacci ; If Valid, jump to Fibonacci.

EnterNewNum:
	mov edx, OFFSET outOfRange ; Display Out Of Range and get a new number.
	call WriteString ; Write outOFRange to screen
	call Crlf ; Clear Line
	mov edx, OFFSET howMany ; Move the question to edx.
	call WriteString ; Write howMany to screen.
	call ReadInt ; Read the integer the user enters.
	mov nums, eax ; Move the value the user enters into nums
	call Crlf ; Clear line
	jmp Validate ; Jump to Validate

Fibonacci:
	mov eax, 1 ; Move 1 to eax to start.
	call WriteDec ; Write to the Screen.
	dec counter
	mov edx, OFFSET spaces ;Move spaces to edx
	call WriteString ; Write to string
	mov ebx, 0
	dec counter ;Decrease the counter
	Loop TwoNums; Jump to more than one if ECX is more than 1.

TwoNums:
   mov edx, eax ;Move the new number to edx=1 eax =1
   add eax, ebx ; Add EBX and EAX - Store in EAX 
   call WriteDec ; Write to the screen
   dec counter 
   mov ebx, edx ; Move value in edx to ebx.
   mov edx, OFFSET spaces ; Move Spaces to be Written
   call WriteString  ; Write the String.
   push ECX ; Push ECX to Register
   mov ecx, counter ; Move Counter to ECX to be Compared
   cmp ecx, 0 ; Compare counter to 0
   jz newLine ; If Counter is 0 then jump to Newline
   pop ECX ; Otherwise pop ECX back
   Loop TwoNums ; Loop 
   jmp Fairwell ; Once loop is done, jump to the farewell

 newLine:
	call Crlf ; Clear the line
	mov counter, 5 ; Reset the Counter
	pop ecx ; Pop ECX back out
	sub ecx, 1 ; Susbtract 1 from ECX (Loop did not execute that step.
	jmp TwoNums

Fairwell:
	call Crlf
	mov edx, OFFSET results ; Move results to be written to screen
	call WriteString ; Write string to console
	call Crlf ; Clear Line
	mov edx, OFFSET goodbye ; Move goodbye to be written to screen
	call WriteSTring ; Write string to console
	mov edx, OFFSET username ; Move buffer to OFFSET
	call WRITESTRING ; Write string to console
	call Crlf ; Clear LIne
	

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
