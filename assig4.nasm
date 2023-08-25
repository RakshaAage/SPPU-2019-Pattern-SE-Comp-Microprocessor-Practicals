global _start
_start:

;------------Text Section-------------
section .text

%macro dispmsg 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro accept 2
mov rax,0
mov rdi,0
mov rsi,%1
mov rdx,%2
syscall
%endmacro


back1:dispmsg msg1,len1
dispmsg msg2,len2
accept num,2
mov al,[num]
cmp al,31H
je ch1
cmp al,32H
je ch2
cmp al,33H
je ch3
cmp al,34H
je ch4
cmp al,35H
je ch5
JMP exit

ch1: call add1
     jmp back1

ch2: call sub1
     jmp back1
     
ch3: call mul1
     jmp back1
    
ch4: call div1
     jmp back1

ch5: jmp exit

;function add
add1:
	dispmsg msg3,len3
	accept num,3
	call convert
	mov [no1],al
	
	dispmsg msg4,len4
	accept num,3
	call convert
	mov [no2],al
	
	mov rax,[no1]
	mov rbx,[no2]
	add rax,rbx
	call display
	dispmsg msg5,len5
	ret
	
sub1:
	dispmsg msg3,len3
	accept num,3
	call convert
	mov [no1],al
	
	dispmsg msg4,len4
	accept num,3
	call convert
	mov [no2],al
	
	mov rax,[no1]
	mov rbx,[no2]
	sub rax,rbx
	call display
	dispmsg msg5,len5
	ret
	
mul1:
	dispmsg msg3,len3
	accept num,3
	call convert
	mov [no1],al
	
	dispmsg msg4,len4
	accept num,3
	call convert
	mov [no2],al
	
	mov rax,[no1]
	mov rbx,[no2]
	mul rbx
	call display
	dispmsg msg5,len5
	ret
	
div1:
	dispmsg msg3,len3
	accept num,3
	call convert
	mov [no1],al
	
	dispmsg msg4,len4
	accept num,3
	call convert
	mov [no2],al
	
	mov rax,[no1]
	mov rbx,[no2]
	mov rdx,0
	div bx
	
	call display
	dispmsg msg5,len5
	ret
	
exit:   mov rax,60
	mov rdi,0
	syscall

convert:
mov rsi,num
mov al,[rsi]
cmp al,39h
jbe l4
sub al,07h
l4:sub al,30h
rol al,04
mov bl,al
inc rsi
mov al,[rsi]
cmp al,39h
jbe l5
sub al,07h
l5:sub al,30h
add al,bl
ret

display:
mov rsi,disparr+15
mov rcx,16
l2: mov rdx,0
mov rbx,10h
div rbx
cmp dl,09h
jbe l1
add dl,07h
l1: add dl,30h
mov [rsi],dl
dec rsi
dec rcx
jnz l2
mov rax,1
mov rdi,1
mov rsi,disparr
mov rdx,16
syscall
ret

;-------------DATA SECTION--------------
;data section
section .data

msg1 db "1.Addition 2.Subtraction 3. Multiplication 4.Division 5.Exit ",0AH
len1 equ $-msg1

msg2 db "Enter Your Choice: ",0AH
len2 equ $-msg2

msg3 db "Enter No1.: ",0AH
len3 equ $-msg3

msg4 db "Enter No2.: ",0AH
len4 equ $-msg4

msg5 db " ",0AH
len5 equ $-msg5

;msg6 db "Result is: ",0AH
;len6 equ $-msg6



;-------------BSS SECTION---------------
;bss section
section .bss

disparr resb 40
num resb 40 ;reserved byte
no1 resb 40
no2 resb 40
res resb 40


