;To display array elements
global _start
_start:

;------------Text Section-------------
section .text
mov rax,1   ;syscall to write msg1
mov rdi,1
mov rsi,msg1
mov rdx,len1
syscall

mov rax,1   ;syscall to write msg2
mov rdi,1
mov rsi,msg2
mov rdx,len2
syscall

mov rsi,arr1
l1:push rsi
mov rax,[rsi]
call display2

mov rax,1   ;syscall for write(newline)
mov rdi,1
mov rsi,msg2
mov rdx,len2
syscall

pop rsi
add rsi,8
dec byte[cnt]
jnz l1           ;jump to l1 till cnt is not equal to zero

mov rax,60     ;syscall for exit
mov rdi,0
syscall

;Display Procedure
display2:
mov rsi,disparr1+15  ;to point 16th location of disparr1
mov rcx,16
cntl1:mov rdx,0
mov rbx,10h
div rbx  ;rbx=divisor
cmp dl,09h  ; dl=remainder | compare dl with 09h 
jbe add301  ;jump to add301 if dl is below or equal to 9
add dl,07h
add301: add dl,30h
mov [rsi],dl
dec rsi     ;decrement rsi to point to next location
dec rcx 
jnz cntl1   ;jump to cntl1 if rcx is not zero
 
;syscall for write to display disarr1
mov rax,1
mov rdi,1
mov rsi, disparr1 
mov rdx,16
syscall
ret

;-------------DATA SECTION--------------
;data section
section .data
arr1 dq 2345123456789065h, 6754358975345679h, 1231234564567878h, 1111222233334444h, 4567234578901234h
cnt db 5
cnt2 db 5
msg1 db "THE ARRAY ELEMENTS ARE: "
len1 equ $-msg1
msg2 db "",10
len2 equ $-msg2

;-------------BSS SECTION---------------
;bss section
section .bss

disparr1 resb 16  ;reserved byte