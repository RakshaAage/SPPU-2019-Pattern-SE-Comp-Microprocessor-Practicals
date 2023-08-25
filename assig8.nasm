global _start
_start:

;------------Text Section-------------
section .text


mov rsi,sarr
mov rdi,darr

back1:mov al,[rsi]
mov [rdi],al
inc rsi
inc rdi
dec byte[cnt1]
jnz back1

mov rax,1
mov rdi,1
mov rsi,msg1
mov rdx,len1
syscall

mov rsi,darr
back2:mov al,[rsi]
push rsi
call display
pop rsi
inc rsi
dec byte[cnt2]
jnz back2
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
sarr db 01h, 02h, 03h, 04h, 05h
darr db 00h, 00h, 00h, 00h, 00h
cnt1 db 05h
cnt2 db 05h
msg1 db "Destination Array ",0AH
len1 equ $-msg1


;-------------BSS SECTION---------------
;bss section
section .bss

disparr1 resb 32 ;reserved byte



