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
accept num,3
call convert
mov [no1],al

dispmsg msg2,len2
accept num,3
call convert
mov [no2],al

;shift and add
mov ax,[no1]
mov bx,[no2]
mov cx,0000h
mov [res],cx

a1: SHR bx,01
    jnc a2
    add [res],ax
a2: SHL ax,01
    cmp ax,00
    jz a3
    cmp bx,00
    jnz a1
a3: dispmsg msg3,len3
    mov rax,[res]
    call display 

mov rax,60
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

msg1 db "Enter No.1: ",0AH
len1 equ $-msg1

msg2 db "Enter No.2: ",0AH
len2 equ $-msg2

msg3 db "Multiplication is: ",0ah
len3 equ $-msg3


;-------------BSS SECTION---------------
;bss section
section .bss

disparr resb 40
num resb 40 ;reserved byte
no1 resb 40
no2 resb 40
res resb 40


