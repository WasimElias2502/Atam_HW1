.global _start

.section .text
_start:

movq head(%rip) , %rdi ## get head to rdi

testq %rdi ,%rdi
je Done3_HW1

Loop3_HW1:
movq 0x8(%rdi) , %rsi ### next element to rsi
testq %rsi , %rsi
je Done3_HW1
movq (%rsi) , %rax
cmpq (%rdi) , %rax
jle Loop2_HW1
movq %rsi , %rdi
jmp Loop3_HW1


Loop2_HW1:
movq 0x8(%rdi) , %rsi ### next element to rsi
testq %rsi , %rsi
je Done2_HW1
movq (%rsi) , %rax
cmpq (%rdi) , %rax
jl Not2or3_HW1
movq %rsi , %rdi
jmp Loop2_HW1


Not2or3_HW1:

movq head(%rip) , %rdi ## get head to rdi
movq $0x0 , %rcx ### rcx counts number of delete elements
movq $0x0 , %rbx ### rbx max element


Loop1_HW1:

movq 0x8(%rdi) , %rsi ### next element to rsi
testq %rsi , %rsi
je Done1_HW1
movq (%rsi) , %rax
cmpq (%rdi) , %rax
jl RemoveElement_HW1
movq (%rdi) , %rbx
movq %rsi , %rdi
jmp Loop1_HW1




RemoveElement_HW1:
testq %rcx , %rcx
jne Done0_HW1
movq 0x8(%rsi) , %rdx
testq %rdx , %rdx
je Done1_HW1
movq (%rdx) , %rdx
cmp (%rdi) , %rdx
jge RemoveRsi_HW1
cmp  %rbx , (%rsi)
jl Done0_HW1
movq %rsi , %rdi
incq %rcx
jmp Loop1_HW1


RemoveRsi_HW1:
movq (%rdi), %rbx
movq 0x8(%rsi) , %rdi
incq %rcx
jmp Loop1_HW1


Done3_HW1:
movq $0x3 , (result)  ## CHECKKKK
jmp Exit_HW1

Done2_HW1:
movq $0x2 , (result)  ## CHECKKKK
jmp Exit_HW1

Done1_HW1:
movq $0x1 , (result)  ## CHECKKKK
jmp Exit_HW1

Done0_HW1:
movq $0x0 , (result)  ## CHECKKKK
jmp Exit_HW1



Exit_HW1:
#your code here
