;TITLE Program Template     (template.asm)

; Author: Sarah Harber
; Course / Project ID  Program #4                Date: 
; Description:

INCLUDE Irvine32.inc

; (insert constant definitions here)
upperLimit = 400		; Variable to define constant upper limit.
lowerLimit = 1			; Variable to define constant lower limit.
two = 2					; Constant Divisibility Variable

.data

; (insert variable definitions here)
title1			BYTE		"Composite Numbers	Programmed by Sarah Harber",0				; Variable to hold the title string
instructions	BYTE		"Enter the number of composite numbers you would like to see.",0	; Variable to hold the program instructions
parameters		BYTE		"I'll accept orders for up to 400 composites.",0					; Variable to hold the parameters of the program
enterPrompt		BYTE		"Enter the number of composites to display  [1 .. 400]: ",0			; Variable to hold the prompt to the user to enter a number
error			BYTE		"Out of range.  Try again.",0										; Variable to hold the error message to the user
results			BYTE		"Results certified by Sarah Harber.  Goodbye.",0					; Variable to hold the goodbye message.
spaces			BYTE		"   ",0																; Variable to hold spaces

; Non-string variables
userInput		DWORD		?			; Variable to store user input.
current			DWORD		0			; Variable to hold the hold the current number
counter			DWORD		0			; Counter to start at 0.
odd				DWORD		?			; Odd Number Starting at 3

.code
main PROC

; (insert executable instructions here)
call introduction		; Call introduction Procedure
call getUserData		; Call getUserData Procedure	
call showComposites		; Call showComposites Procedure
call farewell			; Call farewell Procedure
	
	
	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

;**************************************************************************************
; Procedure to Introduce the Program and instructions to the user.
; Receives: title1, instructions, parameters
; Returns: None
; Preconditions: None
; Retisters changed: edx
;_______________________________________________________________________________________
introduction PROC
	mov		edx, OFFSET title1			; Move title1 string to edx register
	call	WriteString					; Write title1 to the console.
	call	Crlf						; Clear the line
	call	Crlf						; Clear the line

	mov		edx, OFFSET instructions	; Move instructions string to edx register
	call	WriteString					; Write instructions to the console.
	call	Crlf						; Clear the line

	mov		edx, OFFSET parameters		; Move parameters string to edx register
	call	WriteString					; Write parameters to the console.
	call	Crlf						; Clear the line
	call	Crlf						; Clear the line

ret					; return statement.
introduction ENDP
;_______________________________________________________________________________________



;**************************************************************************************
; Procedure to obtain a number of composite numbers the user would like to see.
; Receives: enterPrompt, userInput
; Returns: userInput
; Preconditions: None
; Retisters changed: edx, eax, ecx
;_______________________________________________________________________________________
getUserData PROC
	mov		edx, OFFSET enterPrompt		; Move enterPrompt string into edx reguster
	call	WriteString					; Write edx register to the console.
	call	ReadDec						; Call ReadDec to get a number from the user
	mov		userInput, eax				; Store the number into the userInput Variable
	call	Crlf						; Clear the line
	call	validate					; Call validate procedure to validate user input
	mov		ECX, userInput				; Move userInput into ECX (To use in Loop Later)

ret
getUserData ENDP
;_______________________________________________________________________________________



;**************************************************************************************
; Procedure to validate that the number entered by the user is within the proper range.
; Receives: userInput, upperLimit, lowerLimit, error
; Returns: userInput
; Preconditions: None
; Retisters changed: edx
;_______________________________________________________________________________________
validate PROC
	
	ValidatesNum:
		cmp		userInput, lowerLimit		; Compare the user's input with the lower limit.
		jl		ErrorMessage				; If less than lower limit, jump to error.
		cmp		userInput, upperLimit		; Compare the user's input with the upper limit.
		jg		ErrorMessage				; If greater than upper limit, jump to error
		ret									; Otherwise return.

	ErrorMessage:
		mov		edx, OFFSET error		; Display error message
		call	WriteString				; WriteString to the console
		call	Crlf					; Clear the Line
		call	getUserData				; Call the procedure getUserData

ret		
validate ENDP

;**************************************************************************************
; Procedure to show the number of composites requested
; Receives: counter, current
; Returns: Nothing (Just prints numbers to screen)
; Preconditions: userInput is between 1 and 400, Current = 0, Counter = 0.
; Retisters changed: eax, ecx, edx
;_______________________________________________________________________________________
showComposites PROC
	mov ecx, userInput					; Move userInput into ECX for counter.

	Composites:
		inc		current					; Increase current by 1
		call	isComposite				; Check to see if current number is composite.
		
	IfComposite:
		cmp		eax, 0					; Compare eax to 0 (If current is not composite)
		jnz		Loops					; If eax is not 0 jump to loops.
		jmp		Write					; If eax is 1 Jump to Write (If current is composite)

	Write:
		mov		eax, current			; (If current is composite, move to eax to write)
		call	WriteDec				; Call WriteDec
		mov		edx, OFFSET spaces		; Move spaces to edx
		call	WriteString				; Write Spaces to council
		inc		counter					; Increment the counter
		cmp		counter, 10				; Compare Counter to 10.
		je		NewLine					; If counter is 10 jump to Newline
		jmp		Loops					; Otherwise (counter is not 10) jump to loops
	NewLine:
		call	Crlf					; Clear Line
		mov		counter, 0				; Reset Counter

	Loops:
		Loop Composites				; Loop to Composites


ret
showComposites ENDP

;**************************************************************************************
; Procedure to determine if a number is composite or not.
; Receives: userInput, counter, current
; Returns: 1 or 0 in eax
; Preconditions: userInput is between 1 and 400. 
; Retisters changed: eax, ebx, edx, ecx
;_______________________________________________________________________________________
isComposite PROC
	
	CheckComposite:
		cmp current, 4				; See if number is less than 4
		jl  NotComposite			; If less, jump to Not Composite
	
	; If number is greater to, or equal to 4 then determine if it is composite.
	
	; Check to see if number is even (Which will be divisible by two)
	; Even numbers are composite if greater than 2.
	DivisibleByTwo:	
		mov		eax, current		; Move current to eax
		mov		ebx, two			; Move two to ebx
		SUB		edx, edx			; Clear edx
		div		ebx					; Current / 2
		cmp		edx, 0				; See if remainder is 0
		jz	Composite				; If zero - The number is Composite

	; Set the first Odd Number to 3
	SetOdd:
		mov		odd, 3				; Set Odd to 3.

	; Check to see if current is divisible by any odd numbers up to current number
	DivisibleByOdd:
		mov		eax, current		; Move current to eax
		mov		ebx, odd			; Move odd to ebx
		SUB		edx, edx			; Clear edx
		div		ebx					; Current / odd
		cmp		edx, 0				; See if remainder is 0
		jz	Composite				; If zero - The number is Composite
		add		odd, 2				; Add two to odd
		mov		eax, odd			; Move Odd to eax
		cmp		current, eax		; Compare current to eax(odd)
		jle		DivisibleByOdd		; If the new odd number is less than or equal to current jump to divisible by odd
		

		; If numbers are not divisible by any of the previous number then it is not composite
		jmp NotComposite

	; Directions for if a number is composite.
	Composite:
		mov eax, 0					; Move 0 to eax (Number is composite
		ret							; return to prior instruction

	NotComposite:	
		inc		ecx					; If a number is not composite increment counter (ecx)
		mov		eax, 1				; Move 1 to EAX (Number is not composite)
		ret
isComposite ENDP

;**************************************************************************************
; Procedure to say farewell to the user
; Receives: Results
; Returns: Nothing
; Preconditions: None
; Retisters changed: edx
;_______________________________________________________________________________________
farewell PROC
	mov		edx, OFFSET results		; Move results to edx to be written to console
	call	Crlf					; Clear the line
	call	WriteString				; Write results to Consol
	call	Crlf					; Clear the line
	call	Crlf					; Clear the line
	
	ret
farewell ENDP




END main
