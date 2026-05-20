TITLE Bubble Sort and Binary Search       BinarySearchTest.asm)

; Bubble sort an array of signed integers, and perform
; a binary search.
; Main module, calls Bsearch.asm, Bsort.asm, FillArry.asm

INCLUDE Irvine32.inc

;EXTERN語法
EXTERN BinarySearch@12:PROC             ;BinarySearch裡面有3個DWORD佔12byte
BinarySearch EQU BinarySearch@12        ;將BinarySearch@12命名為BinarySearch

EXTERN BubbleSort@8:PROC                 ;BubbleSort裡面有2個DWORD佔8byte
BubbleSort EQU BubbleSort@8              ;將BubbleSort@8命名為BubbleSort

EXTERN FillArray@16:PROC
FillArray EQU FillArray@16

EXTERN PrintArray@8:PROC
PrintArray EQU PrintArray@8


LOWVAL = -5000 ; minimum value
HIGHVAL = +5000 ; maximum value
ARRAY_SIZE = 50 ; size of the array

.data
array DWORD ARRAY_SIZE DUP(?)

.code
main PROC
call Randomize

; Fill an array with random signed integers
push HIGHVAL
push LOWVAL
push ARRAY_SIZE
push OFFSET array
call FillArray

; Display the array
push ARRAY_SIZE
push OFFSET array
call PrintArray

call WaitMsg

;以EXTERN實作bubble sort
push ARRAY_SIZE
push OFFSET array
call BubbleSort
call Crlf

;printArray
push ARRAY_SIZE
push OFFSET array
call PrintArray

; Demonstrate a binary search
call AskForSearchVal ; returned in EAX

;以EXTERN呈現BinarySearch
push eax
push ARRAY_SIZE
push OFFSET array
call BinarySearch
call ShowResults

exit
main ENDP

;--------------------------------------------------------
AskForSearchVal PROC
;
; Prompt the user for a signed integer.
; Receives: nothing
; Returns: EAX = value input by user
;--------------------------------------------------------
.data
prompt BYTE "Enter a signed decimal integer "
       BYTE "to find in the array: ",0
.code
call Crlf
mov edx,OFFSET prompt
call WriteString
call ReadInt
ret
AskForSearchVal ENDP

;--------------------------------------------------------
ShowResults PROC
;
; Display the resulting value from the binary search.
; Receives: EAX = position number to be displayed
; Returns: nothing
;--------------------------------------------------------
.data
msg1 BYTE "The value was not found.",0
msg2 BYTE "The value was found at position ",0
.code
.IF eax == -1
mov edx,OFFSET msg1
call WriteString
.ELSE
mov edx,OFFSET msg2
call WriteString
call WriteDec
.ENDIF
call Crlf
call Crlf
ret
ShowResults ENDP

END main