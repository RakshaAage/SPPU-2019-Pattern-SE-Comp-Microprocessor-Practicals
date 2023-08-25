global _start
_start:
section .text
;display msg
mov rax,1
mov rdi,1
mov rsi,msg1
mov rdx,len1
syscall

;just syscall of read
mov rax,0
mov rdi,0
mov rsi,str1
mov rdx,length1
syscall

dec rax ;to get original len of string
mov [strlength],rax

;display msg as length of string
mov rax,1
mov rdi,1
mov rsi,msg2
mov rdx,len2
syscall

;parameter passing for call display
mov rax,[strlength]  
call display

;exit
mov rax,60
mov rdi,0
syscall

display:
mov rsi,disparr+15
mov rcx,16
l2:mov rdx,0
	mov rbx,10H
	div rbx
	cmp dl,09H
	jbe l1
	add dl,07H
l1: add dl,30H
	mov [rsi],dl
	dec rsi
	dec rcx
	jnz l2
mov rax,1
mov rsi,disparr
mov rdx,16
syscall
ret

------------------------
section .data
msg1 db "Enter string : ",0ah
len1 equ $-msg1
msg2 db "Length of the string : ",0ah
len2 equ $-msg2


-------------------------
section .bss
disparr resb 52
str1 resb 40
length1 resb 40
strlength resb 40

;OUTPUT
;Enter string : 
;raksha
;Length of the string : 
;0000000000000006