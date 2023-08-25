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

smsw eax
mov [crdata],eax
BT eax,00
JC protected   ;PE=1
dispmsg msg1,len1
JMP exit

protected: dispmsg msg2,len2
           dispmsg msg3,len3
           mov ax,[crdata+2]
           call display4
           mov ax,[crdata]
           call display4
  
	   dispmsg msg4,len4
	   str[trdata]
	   mov ax,[trdata]
	   call display4

	   dispmsg msg5,len5
	   sldt[ldtrdata]
	   mov ax,[ldtrdata]
	   call display4

	   dispmsg msg6,len6
	   sgdt[gdtrdata]
	   mov ax,[gdtrdata+4]
	   call display4
	   mov ax,[gdtrdata+2]
	   call display4
	   mov ax,[gdtrdata]
	   call display4
	 
	   dispmsg msg7,len7
	   sidt[idtrdata]
	   mov ax,[idtrdata+4]
	   call display4
	   mov ax,[idtrdata+2]
	   call display4
	   mov ax,[idtrdata]
	   call display4
	
exit: mov rax,60
      mov rdi,0
      syscall
 


display4:
mov rsi,disparr+3
mov rcx,4
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
mov rdx,4
syscall
ret

;-------------DATA SECTION--------------
;data section
section .data

msg1 db "In Real Mode ",0AH
len1 equ $-msg1

msg2 db "In Protected Mode ",0AH
len2 equ $-msg2

msg3 db "MSW is: ",0aH
len3 equ $-msg3

msg4 db "TR is: ",0AH
len4 equ $-msg4

msg5 db "LDTR is: ",0AH
len5 equ $-msg5

msg6 db "GDTR is: ",0AH
len6 equ $-msg6

msg7 db "GDTR is: ",0AH
len7 equ $-msg7


;-------------BSS SECTION---------------
;bss section
section .bss

disparr resb 40
ldtrdata resb 20
crdata resb 20
trdata resb 20
gdtrdata resb 20
idtrdata resb 20
num resb 40 ;reserved byte
res resb 40


