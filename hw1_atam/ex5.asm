.global _start

.section .text
_start:



movq $command , %rbx


FindfirstSpace_HW1:
cmpb $0x20 , (%rbx)
je FindLastSpace_HW1
incq %rbx
jmp FindfirstSpace_HW1


FindLastSpace_HW1:
cmpb $0x20 , (%rbx)
incq %rbx
je FindLastSpace_HW1


######rbx has the first char of the parameter

cmpb  $0x24 ,(%rbx)
jne NotLegal_HW1



incq %rbx ###### first character after $

cmpb $0x30 ,(%rbx)
jne CheckDecimal_HW1

cmpb $0x2C ,1(%rbx)
je CheckDecimal_HW1

### second charachter in parameter
incq %rbx


cmpb $0x78 ,(%rbx)
je CheckHexaDecimal_HW1

cmpb $0x62 ,(%rbx)
je CheckBinary_HW1

jmp CheckOctal_HW1



CheckBinary_HW1:
inc %rbx
movq %rbx, %rcx
LoopGetLsb_HW1:
incq %rcx
cmpb $0x2C, (%rcx)
jne LoopGetLsb_HW1
## rcx now has comma
dec %rcx
### rcx = LSB

movb (%rcx) , %dl
cmpb $0x30 , %dl
jl NotLegal_HW1
cmpb $0x31 , %dl
jg NotLegal_HW1
movb (%rcx) , %r9b
and $0xFF , %r9
subq $0x30, %r9
movq %r9, %rax

dec %rcx
cmp %rbx , %rcx
jl LegalEnd_HW1
### rcx = second bit
movb (%rcx) , %dl
cmpb $0x30 , %dl
jl NotLegal_HW1
cmpb $0x31 , %dl
jg NotLegal_HW1
movb (%rcx) , %r9b
and $0xFF , %r9
subq $0x30, %r9
shl %r9
add %r9, %rax

dec %rcx
cmp %rbx , %rcx
jl LegalEnd_HW1
### rcx = MSB
movb (%rcx) , %dl
cmpb $0x30 , %dl
jl NotLegal_HW1
cmpb $0x31 , %dl
jg NotLegal_HW1
movb (%rcx) , %r9b
and $0xFF , %r9
subq $0x30, %r9
shl $0x2, %r9
add %r9, %rax
jmp LegalEnd_HW1




CheckOctal_HW1:
movq %rbx, %rcx
LoopGetLsbOfOctal_HW1:
incq %rcx
cmpb $0x2C, (%rcx)
jne LoopGetLsbOfOctal_HW1
## rcx now has comma
dec %rcx
### rcx = LSB
movb (%rcx) , %dl
cmpb $0x30 , %dl
jl NotLegal_HW1
cmpb $0x37 , %dl
jg NotLegal_HW1
movb (%rcx) , %r9b
and $0xFF , %r9
subq $0x30, %r9
movq %r9, %rax

dec %rcx
cmp %rbx , %rcx
jl LegalEnd_HW1
### rcx = second bit
movb (%rcx) , %dl
cmpb $0x30 , %dl
jl NotLegal_HW1
cmpb $0x37 , %dl
jg NotLegal_HW1
movb (%rcx) , %r9b
and $0xFF , %r9
subq $0x30, %r9
shl $3, %r9
add %r9, %rax

dec %rcx
cmp %rbx , %rcx
jl LegalEnd_HW1
### rcx = MSB
movb (%rcx) , %dl
cmpb $0x30 , %dl
jl NotLegal_HW1
cmpb $0x37 , %dl
jg NotLegal_HW1
movb (%rcx) , %r9b
and $0xFF , %r9
subq $0x30, %r9
shl $6, %r9
add %r9, %rax
jmp LegalEnd_HW1



CheckDecimal_HW1:
movq %rbx, %rcx
LoopGetLsbOfDecimal_HW1:
incq %rcx
cmpb $0x2C, (%rcx)
jne LoopGetLsbOfDecimal_HW1
## rcx now has comma
dec %rcx
### rcx = LSB
movb (%rcx) , %dl
cmpb $0x30 , %dl
jl NotLegal_HW1
cmpb $0x39 , %dl
jg NotLegal_HW1
movb (%rcx) , %r9b
and $0xFF , %r9
subq $0x30, %r9
movq %r9, %rax

dec %rcx
cmp %rbx , %rcx
jl LegalEnd_HW1
### rcx = second bit
movb (%rcx) , %dl
cmpb $0x30 , %dl
jl NotLegal_HW1
cmpb $0x39 , %dl
jg NotLegal_HW1
movb (%rcx) , %r9b
and $0xFF , %r9
subq $0x30, %r9
imul $10, %r9
add %r9, %rax

dec %rcx
cmp %rbx , %rcx
jl LegalEnd_HW1
### rcx = MSB
movb (%rcx) , %dl
cmpb $0x30 , %dl
jl NotLegal_HW1
cmpb $0x39 , %dl
jg NotLegal_HW1
movb (%rcx) , %r9b
and $0xFF , %r9
subq $0x30, %r9
imul $100, %r9
add %r9, %rax
jmp LegalEnd_HW1


CheckHexaDecimal_HW1:
inc %rbx
movq %rbx, %rcx
LoopGetLsbOfHexaDecimal_HW1:
incq %rcx
cmpb $0x2C, (%rcx)
jne LoopGetLsbOfHexaDecimal_HW1
## rcx now has comma
dec %rcx
### rcx = LSB
movb (%rcx) , %dl
cmpb $0x30 , %dl
jl NotLegal_HW1
cmpb $0x46 , %dl
jg NotLegal_HW1
cmpb $0x41 , %dl
jge A_to_F_HW1
cmpb $0x39 , %dl
jg NotLegal_HW1

movb (%rcx) , %r9b
and $0xFF , %r9
subq $0x30, %r9
movq %r9, %rax
jmp Second_Digit_HW1

A_to_F_HW1:
movb (%rcx) , %r9b
and $0xFF , %r9
subq $0x37, %r9
movq %r9, %rax

Second_Digit_HW1:
dec %rcx
cmp %rbx , %rcx
jl LegalEnd_HW1

### rcx = second digit
movb (%rcx) , %dl
cmpb $0x30 , %dl
jl NotLegal_HW1
cmpb $0x46 , %dl
jg NotLegal_HW1
cmpb $0x41 , %dl
jge A_to_F__HW1
cmpb $0x39 , %dl
jg NotLegal_HW1

movb (%rcx) , %r9b
and $0xFF , %r9
subq $0x30, %r9
shl $4 , %r9
add %r9, %rax
jmp Third_Digit_HW1

A_to_F__HW1:
movb (%rcx) , %r9b
and $0xFF , %r9
subq $0x37, %r9
shl $4 , %r9
add %r9, %rax

Third_Digit_HW1:
dec %rcx
cmp %rbx , %rcx
jl LegalEnd_HW1

### rcx = MSB
movb (%rcx) , %dl
cmpb $0x30 , %dl
jl NotLegal_HW1
cmpb $0x46 , %dl
jg NotLegal_HW1
cmpb $0x41 , %dl
jge A_to_F___HW1
cmpb $0x39 , %dl
jg NotLegal_HW1

movb (%rcx) , %r9b
and $0xFF , %r9
subq $0x30, %r9
shl $8 , %r9
add %r9, %rax
jmp LegalEnd_HW1

A_to_F___HW1:
movb (%rcx) , %r9b
and $0xFF , %r9
subq $0x37, %r9
shl $8 , %r9
add %r9, %rax
jmp LegalEnd_HW1


NotLegal1_HW1:
movb $13 , (legal)
jmp End_HW1



NotLegal_HW1:
movb $0 , (legal)
jmp End_HW1

LegalEnd_HW1:
movb $1 , (legal)
movl %eax , (integer)

End_HW1:



