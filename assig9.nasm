global _start
_start:

;------------Text Section-------------
section .text


mov rsi,arr
mov rdi,arr
add rsi,9
add rdi,13

STD ;Set DF| Dec rsi and rdi
mov rcx,0ah
rep movsb ;move string byte | repeate till rcx!=0

mov rax,1
mov rdi,1
mov rsi,msg1
mov rdx,len1
syscall

mov rsi,arr
back1:mov al,[rsi]
push rsi
call display
pop rsi
inc rsi
dec byte[cnt1]
jnz back1
mov rax,60
mov rdi,0
syscall

;Display Procedure
display:
mov rsi,disparr1+15  ;to point 16th location of disparr1
mov rcx,16
cntl1:mov rdx,0
mov rbx,10h
div rbx  ;rbx=divisor
cmp dl,09h  ; dl=remainder | compare dl with 09h 
jbe add301  ;jump to add301 if dl is below or equal to 9
add dl,07h
add301:add dl,30h
mov [rsi],dl
dec rsi     ;decrement rsi to point to next location
dec rcx 
jnz cntl1   ;jump to cntl1 if rcx is not zero

;syscall for write to display 
mov rax,1
mov rdi,1
mov rsi,disparr1
mov rdx,16
syscall
ret

;-------------DATA SECTION--------------
;data section
section .data
arr db 01h, 02h, 03h, 04h, 05h, 06h, 07h, 08h, 09h, 0ah, 0bh, 0ch, 0dh, 0eh, 0fh

cnt1 db 15h

msg1 db "--------Array is--------",0AH
len1 equ $-msg1


;-------------BSS SECTION---------------
;bss section
section .bss

disparr1 resb 32 ;reserved byte



