TITLE Program1 - Elementary Arithmetic     (template.asm)

; Author: Sarah Harber
; Course / Project ID  271/Program1         Date: January 18, 2017
; Description: Program that displays my name and program title on the output screen.
; The program will then display a set of instructions and ask the user to enter 2 numbers
; It will then calculate the sum, difference, product, quotient and remainder of the numbers.
; It will then display a terminating message.


INCLUDE Irvine32.inc

; (insert constant definitions here)

.data
	; (insert variable definitions here)
	nameandtitle BYTE "Program #1 - Elementary Arithmetic      by Sarah Harber", 0 ; Program Name & Author Name
	instructions BYTE "Enter two integer numbers, and I'll show you the sum, difference, product, quotient and remainder.", 0 ; User Instructions
	instruct_1 BYTE "First number: ", 0  ; Instruct the user to input first number
	num_1 DWORD ?  ; First Integer to be entered by user
	instruct_2 BYTE "Second number: ", 0 ; Instruct the user to input the second number.
	num_2 DWORD ?  ; Second Integer to be entered by user
	sum DWORD ?        ; Variable to store the Sum
	difference DWORD ? ; Variable to store the difference
	product DWORD ?    ; Variable to store the product
	quotient DWORD ?   ; Variable to store the quotient
	remainder DWORD ?  ; Variable to store the remainder
	display_sum BYTE "The Sum is: ", 0 ; Display Text For Sum
	display_difference BYTE "The difference is: ", 0 ; Display Text for Difference
	display_product BYTE "The product is: ", 0 ; Display text for product
	display_quotient BYTE "The quotient is ", 0 ; Display text for quotient
	display_remainder BYTE "The remainder is ", 0 ; Display text for remainder
	goodbye BYTE "Impressed? Good-Bye!", 0 ; Say Good-Bye to the User

.code
main PROC
; (insert executable instructions here)

; Display Title & Programmer Name
	mov edx, OFFSET nameandtitle
	call WriteString
	call CrLf
	call CrLf
	call CrLf

; Display instructions to the user.
	mov edx, OFFSET instructions
	call WriteString
	call CrLf

; Ask the user for the first number
	mov edx, OFFSET instruct_1
	call WriteString
	call ReadInt
	mov num_1, eax

; Ask the user for the second number
	mov edx, OFFSET instruct_2
	call WriteString
	call ReadInt
	mov num_2, eax
	call CrLf
	

; Calculate the sum of the numbers
	mov eax, num_1 
	add eax, num_2
	mov sum, eax
	
; Calculate the difference of the numbers
	mov ebx, num_1
	sub ebx, num_2
	mov difference, ebx
	
; Calculate the product of the numbers
	mov eax, num_1
	mov edx, num_2
	mul edx
	mov product, eax

; Calculate the quotient and the remainder
	mov eax, num_1
	cdq
	mov ebx, num_2
	div ebx 
	mov quotient, eax
	mov remainder, edx

; Display the result of the Sum to the user
	mov edx, OFFSET display_sum
	call WriteString
	mov eax, sum
	call WriteDec
	call Crlf

; Display the result of the difference to the user
	mov edx, OFFSET display_difference
	call WriteString
	mov eax, difference
	call WriteDec
	call Crlf

; Display the result of the product to the user
	mov edx, OFFSET display_product
	call WriteString
	mov eax, product
	call WriteDec
	call Crlf

; Display the result of the quotient to the user
	mov edx, OFFSET display_quotient
	call WriteString
	mov eax, quotient
	call WriteDec
	call Crlf

; Display the result of the remainder to the user
	mov edx, OFFSET display_remainder
	call WriteString
	mov eax, remainder
	call WriteDec
	call Crlf

; Display the Good-Bye Message
	mov edx, OFFSET goodbye
	call WriteString
	call Crlf
	exit	; exit to operating system

main ENDP

END main
