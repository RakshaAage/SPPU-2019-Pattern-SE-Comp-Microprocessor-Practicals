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

dispmsg msg1,len1 
mov rsi,array1
back6: push rsi      ;rsi will point to 2710H
       accept num,01
       call convert2
       pop rsi
       mov bx,[rsi]  ;bx=2710H
       MUL bx
       add [result], ax 
       inc rsi
       inc rsi
       dec byte[cnt2]
       jnz back6
       
dispmsg msg2,len2
mov ax,[result]
call display

mov rax,60
mov rdi,0
syscall

convert2:
mov al,[num]
sub al,30h
ret

display:
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

array1 dw 2710H, 03E8H, 0064H, 000AH, 0001H
cnt2 db 5

msg1 db "Enter 5 digit BCD No.: ",0AH
len1 equ $-msg1

msg2 db "Hex No. is: ",0AH
len2 equ $-msg2


;-------------BSS SECTION---------------
;bss section
section .bss

disparr resb 20
num resb 20 ;reserved byte
result resb 40
 

