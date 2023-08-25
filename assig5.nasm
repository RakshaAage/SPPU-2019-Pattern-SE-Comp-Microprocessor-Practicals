;To display array elements
global _start
_start:

;------------Text Section-------------
section .text
mov rsi,arr  ;rsi points to memory location of arr
back1: mov rax,[rsi] ;rax=element is stored
bt rax,63    
jc n1
inc byte[pcnt]
jmp next
n1: inc byte[ncnt]
next: add rsi,8
dec byte[cnt]
jnz back1
syscall


;syscall for write to display positive count
mov rax,1
mov rdi,1
mov rsi,msg1 
mov rdx,len1
syscall
mov rax,[pcnt]
call display

;syscall for write to display negative count
mov rax,1
mov rdi,1
mov rsi,msg2 
mov rdx,len2
syscall
mov rax,[ncnt]
call display

mov rax,60
mov rdi,0
syscall 



;Display Procedure
display:
mov rsi,disparr+15  ;to point 16th location of disparr1
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
 
;syscall for write to display 
mov rax,1
mov rdi,1
mov rsi,disparr
mov rdx,16
syscall
ret

;-------------DATA SECTION--------------
;data section
section .data
arr dq 1234567812345678h, 8754358975345679h, 9231234564567878h, 2111222233334444h, 3567234578901234h
cnt db 05h

msg1 db "Positive Count",0ah
len1 equ $-msg1
msg2 db "Negative Count",0ah
len2 equ $-msg2

;-------------BSS SECTION---------------
;bss section
section .bss

disparr resb 32 ;reserved byte
ncnt resb 10
pcnt resb 10


