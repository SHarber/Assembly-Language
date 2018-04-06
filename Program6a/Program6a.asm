; Author: Sarah Harber
; Course / Project ID 271- Program 6a               Date:  03/17/117
; Description:

INCLUDE Irvine32.inc

; (insert constant definitions here)
MAXSIZE = 15						; Variable to say maxsize of string input



;**************************************************************************************
; Macro to display a string
; Receives: Buffer
; Returns: N/A
; Precondition: A stirng must be passed
;_______________________________________________________________________________________
displayString	MACRO	buffer
	push	edx							; Push edx to the register
	mov		edx,			buffer		; Move buffer to edx
	call	WriteString					; Call Write String
	pop		edx							; Pop edx back to stack
ENDM	

;**************************************************************************************
; Macro to get a String entered by the useer's keyboard
; Receives: Prompt, Buffer, Buffer Size
; Returns: N/A
; Precondition: A stirng must be passed
;_______________________________________________________________________________________
getString	MACRO	prompt, buffer, bufferSize
	push	edx							; Push edx to the regsiter
	push	ecx							; Push ecx to the register
	push	eax							; Push eax to the register
	
	; Display prompt.
	mov		edx,			prompt				; Move prompt to edx
	displayString			edx					; Use Display string to display prompt.
	mov		edx,			buffer				; Move the buffer to edx
	mov		ecx,			bufferSize			; Move bufferSize to edx
	call	ReadString							; Call 
	mov		buffer,			edx

	
	; Reset registers
	pop		eax							; Pop eax back.
	pop		ecx							; Pop ecx back into place
	pop		edx							; Pop edx back into place

ENDM

.data

; (insert variable definitions here)
; String Variables
title1		BYTE	"PROGRAMMING ASSIGNMENT 6: Designing low-level I/O procedures.",0				; Title string variable
written		BYTE	"Written by: Sarah Harber",0													; Written string variable
instruct1	BYTE	"Please provide 10 unsigned decimal integers.",0								; Instruction line 1 string variable
instruct2	BYTE	"Each number needs to be small enough to fit inside a 32 bit register.",0		; Instruction line 2 string variable
instruct3	BYTE	"After you have finished inmputting the raw numbers I will display a list",0	; Instruction line 3 string variable
instruct4	BYTE	"of the integers, their sum, and their average value.",0						; Instuction lline 4 string variable
prompt		BYTE	"Please enter an unsigned number:",0											; Prompt string variable
error		BYTE	"ERROR: You did not enter an u nsigned number or your number was too big.",0	; Error string variable.
tryAgain	BYTE	"Please try again: ",0															; Try Again string variable
entered		BYTE	"You entered the following numbers: ",0											; Numbers entered string variable
sumStr		BYTE	"The sum of these numbers is: ",0												; Sum string variable
averageStr	BYTE	"The average is: ",0															; Average string variable 
thanks		BYTE	"Thanks for playing!",0															; Thank you string variable

; Non-String Variables
array		DWORD	10 DUP(?)			; Array of 10 elements to store unsigned integers.
inString	BYTE	MAXSIZE DUP(?)		; User's String to be entered
outNum		BYTE	MAXSIZE DUP(?)		; User's Number
counter		DWORD	10					; Count Array Elements
outbound	DWORD	10					; Limit for outbound digits

.code
main PROC

; (insert executable instructions here)
; Set up stack to call Intro
	push		OFFSET	instruct4						; Push instruct 4 to the stack
	push		OFFSET	instruct3						; Push instruct 3 to the stack
	push		OFFSET	instruct2						; Push instruct 2 to the stack
	push		OFFSET	instruct1						; Push instruct 1 to the stack
	push		OFFSET	written							; Push written to the stack
	push		OFFSET	title1							; Push title to the stack.
	Call		OFFSET	intro							; Call procedure Intro

; Set up stack to call readVal
	push		outbound								; Push outbound
	push		counter									; push counter onto the stack
	push		OFFSET		array						; Push Offset of the array to the stack
	push		LENGTHOF	array						; Push the length of the array on the stack
	push		OFFSET		prompt						; Push the prompt string onto the stack.
	push		OFFSET		error						; Push error onto the stock
	push		OFFSET		tryAgain					; Push tryagain onto the stack
	push		OFFSET		inString					; Push userNum onto the stack
	push		OFFSET		outNum						; Push outNum
	call		readVal									; Call readVal procedure

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

;**************************************************************************************
; Procedure to display the introduction & instructions of the program to the console
; Receives: title1, written, instruct1, instruct2, instruct3, insturct4
; Returns: N/A
; Precondition: That there are 6 srings on the system stack
; Retisters changed: EDX 
;_______________________________________________________________________________________

intro PROC
	; Set up stack
	push	ebp									; Push ebp to the stack
	mov		ebp,	esp							; Move esp to ebp

	; Display the title and written
	mov		edx,			[ebp+12]					; Move title to edx to be written to the console
	displayString			edx							; Call displayString
	call	Crlf										; Call Clear line
	
	mov		edx,			[ebp+16]					; Move written to edx to be written to the console
	displayString			edx							; Call displayString
	call	Crlf										; Call Clear line
	call	Crlf										; Call Clear Line
	; Display the instructions
	mov		edx,			[ebp+20]					; Move instruct1 to edx to be written to the console
	displayString			edx							; Call displayString
	call	Crlf										; Call Clear line

	mov		edx,			[ebp+24]					; Move instruct2 to edx to be written to the console
	displayString			edx							; Call displayString
	call	Crlf										; Call Clear line

	mov		edx,			[ebp+28]					; Move instruct3 to edx to be written to the console
	displayString			edx							; Call displayString
	call	Crlf										; Call Clear line

	mov		edx,			[ebp+32]					; Move instruct4 to edx to be written to the console
	displayString			edx							; Call displayString
	call	Crlf										; Call Clear line
	call	Crlf										; Call Clear line
	
	pop		ebp											; Pop old EBP back into EBP
	ret		24											; Return + 24
intro ENDP



;**************************************************************************************
;
; Receives: 
; Returns: 
; Precondition: 
; Retisters changed:
;_______________________________________________________________________________________
readVal	PROC
	Setup:
		; Set up Stack
		push	ebp											; Push EBP to the stack
		mov		ebp,		esp								; Move ESP to EBP

		; Set up Registers
		mov		ecx,		[ebp +34]						; Move counter to ecx
		mov		edi,		[ebp +32]						; Move array to EDI
	GetInput:
		; Get string From The User
		getString	[ebp+24],	[ebp +12],	MAXSIZE			; Call Get String.
		
	Convert:
		mov		edx,	[ebp+24]							; Address of buffer
		mov		eax, 0
		mov		ecx, 0
		mov		ebx,	outbound

		lodsb
		cmp eax, 0
		je restore


		cmp eax, 57
		ja ErrorMsg
		cmp eax, 48
		ja ErrorMsg



		jmp Restore
	ErrorMsg:
		mov		edx,		[ebp+20]					; Move Error message to edx to write to console
		displayString		edx							; Display the string


	

	Restore:

		;Restore Registers
		pop		ebp											; Pop OLD EBP into EBP
		ret +32
readVal EndP
END main