.global _start

.section .text
_start:


movq $source_array , %rbx ## BASE POINTER TO SOURCE ARRAY
xorq %rcx , %rcx
movl (size) , %ecx ## %ecx has size
movq $up_array , %r9
movq $down_array , %r10
movl $2147483647 , %r11d ## dec
movl $-2147483648 , %r12d ## inc


cmpl $0x0 , %ecx
je Empty_HW1

cmpl $0x1 , %ecx
je OneElement_HW1

leaq (%rbx , %rcx , 4) , %rcx
subq $0x4 , %rcx

Loop_HW1:
cmp %rbx , %rcx
je EndLoop_HW1

cmpl %r11d , (%rbx)
jge PutInUp_HW1    #check if greater than inc
cmpl %r12d , (%rbx)
jle PutInDown_HW1

TwoOptions_HW1:
movl 0x4(%rbx) , %r13d ## tmp
cmpl (%rbx) , %r13d
jg PutInUp_HW1
jmp PutInDown_HW1


PutInUp_HW1:
cmpl %r12d , (%rbx)
jle NoSolution_HW1
movl (%rbx) , %r13d
movl %r13d , (%r9)
add $0x4 , %rbx
add $0x4 , %r9
movl %r13d , %r12d
jmp Loop_HW1

PutInDown_HW1:
cmpl %r11d , (%rbx)
jge NoSolution_HW1
movl (%rbx) , %r13d ## r13d is tmp
movl %r13d , (%r10)
add $0x4 , %rbx
add $0x4 , %r10
movl %r13d , %r11d
jmp Loop_HW1


EndLoop_HW1:
cmpl %r12d , (%rbx)
jg PutLastElementInUp_HW1
cmpl %r11d , (%rbx)
jl PutLastElementInDown_HW1
jmp NoSolution_HW1

PutLastElementInUp_HW1:
movl (%rbx) , %r13d
movl %r13d , (%r9)
movb $0x1 , %al
jmp End_HW1


PutLastElementInDown_HW1:
movl (%rbx) , %r13d ## r13d is tmp
movl %r13d , (%r10)
movb $0x1 , %al
jmp End_HW1


NoSolution_HW1:
movb $0x0 , %al
jmp End_HW1



Empty_HW1:
movb $0x1 , %al
jmp End_HW1

OneElement_HW1:
movl (%rbx) , %edx
movl %edx , (%r9)
movb $0x1 , %al
jmp End_HW1



End_HW1:
movb %al , (bool)






