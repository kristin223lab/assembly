; Reversing a String (RevStr.asm)
; This program reverses a string.
; Modified to allow user input (keep original push/pop logic)

.386
.model flat,stdcall
.stack 4096
INCLUDE Irvine32.inc
ExitProcess proto, dwExitCode:dword

.data
prompt1  BYTE "Input a string which containing between 1 and 50 characters",0
prompt2  BYTE "The reverse string is:",0
aName    BYTE 51 DUP(0)    ; 儲存使用者輸入字串
nameSize DWORD ?            ; 實際長度

.code
main PROC

    ; 顯示提示訊息
    mov  edx, OFFSET prompt1
    call WriteString
    call Crlf

    ; 讀入使用者字串
    mov  edx, OFFSET aName
    mov  ecx, 50
    call ReadString          ; 輸入到 aName
    mov  nameSize, eax       ; eax = 輸入字元數

    ; push 每個字元進 stack
    mov  ecx, nameSize
    mov  esi, OFFSET aName

L1:
    movzx eax, BYTE PTR [esi]
    push eax
    inc  esi
    loop L1

    ; 顯示結果標題
    call Crlf
    mov  edx, OFFSET prompt2
    call WriteString
    call Crlf

    ; pop 出並反向印出
    mov  ecx, nameSize
L2:
    pop eax
    mov  dl, al
    call WriteChar
    loop L2

    call Crlf
    exit

main ENDP
END main
