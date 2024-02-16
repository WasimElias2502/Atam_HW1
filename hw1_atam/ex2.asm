.global _start

.section .text
_start:

    movq $0 , %r8 #first vertices in degree
    movq $0 , %r9 #second vertices in degree
    movq $0 , %r10 #third vertices in degree
    movq $0 , %r11 #fourth vertices in degree
    movq $0 , %r12 #fifth vertices in degree

    movq $vertices , %rbx #base pointer to vertices

    movq $0x0 , %r14



LoopInDegrees_HW1:

    movq $vertices , %rbx #base pointer to vertices
    leaq (%rbx , %r14 , 8) , %rdx
    movq (%rdx) , %rdx  #### %rdx = current checking vertice
    testq %rdx , %rdx
    je FinishedDegrees_HW1

    ##movq $0x0 , %r8

LoopForRbx_HW1:
    movq (%rbx) , %rax
    testq %rax , %rax
    je EndOfLoopRbx_HW1 #### should inc r14

    movq %rbx, %rcx
    movq (%rcx) , %rcx # rcx has pointer to the first vertice

LoopForRcx_HW1:
    cmpq $0x0 , (%rcx)
    je  EndLoopForRcx_HW1
    cmpq (%rcx) , %rdx
    je IncInDegrees_HW1
DoneIncreasingDegree_HW1:
    add $0x8 , %rcx
    jmp LoopForRcx_HW1


EndLoopForRcx_HW1:
    add $0x8 , %rbx
    jmp LoopForRbx_HW1


EndOfLoopRbx_HW1:
    inc %r14
    jmp LoopInDegrees_HW1



IncInDegrees_HW1:
    cmpq $0x0 , %r14  # if equal it means that we are calc the in deg of first verticle
    jne CheckSecondVertice_HW1
    inc %r8
    jmp DoneIncreasingDegree_HW1


CheckSecondVertice_HW1:
    cmpq $0x1 , %r14  # if equal it means that we are calc the in deg of second verticle
    jne CheckThirdVertice_HW1
    inc %r9
    jmp DoneIncreasingDegree_HW1

CheckThirdVertice_HW1:
    cmpq $0x2 , %r14 # if equal it means that we are calc the in deg of third verticle
    jne CheckFourthVertice_HW1
    inc %r10
    jmp DoneIncreasingDegree_HW1


CheckFourthVertice_HW1:
    cmpq $0x3 , %r14 # if equal it means that we are calc the in deg of fourth verticle
    jne CheckFifthVertice_HW1
    inc %r11
    jmp DoneIncreasingDegree_HW1


CheckFifthVertice_HW1:
    inc %r12
    jmp DoneIncreasingDegree_HW1


####### Start the algorithm #########


FinishedDegrees_HW1:
    movq $vertices , %rbx
    cmpq $0 , (%rbx)
    je EmptyGraph_HW1

    cmpq $0 , 8(%rbx)
    je OneVertice_HW1

    cmpq $0 , 16(%rbx)
    je TwoVertices_HW1

    cmpq $0 , 24(%rbx)
    je ThreeVertices_HW1

    cmpq $0 , 32(%rbx)
    je FourVertices_HW1

    cmpq $0 , 40(%rbx)
    je FiveVertices_HW1


EmptyGraph_HW1:
    movq $-1 , %r8

OneVertice_HW1:
    movq $-1 , %r9

TwoVertices_HW1:
    movq $-1 , %r10


ThreeVertices_HW1:
    movq $-1 , %r11

FourVertices_HW1:
    movq $-1 , %r12

FiveVertices_HW1:


FindSource_HW1:

    movq $vertices , %rax
    movq %rax , %rcx

    cmp $0x0 , %r8
    movq (%rcx) , %rax
    je DeleteVertice_HW1

    cmp $0x0 , %r9
    movq 8(%rcx) , %rax
    je DeleteVertice_HW1

    cmp $0x0 , %r10
    movq 16(%rcx) , %rax
    je DeleteVertice_HW1

    cmp $0x0 , %r11
    movq 24(%rcx) , %rax
    je DeleteVertice_HW1

    cmp $0x0 , %r12
    movq 32(%rcx) , %rax
    je DeleteVertice_HW1



    cmp $0x0 , %r8
    jg HaveCircles_HW1

    cmp $0x0 , %r9
    jg HaveCircles_HW1

    cmp $0x0 , %r10
    jg HaveCircles_HW1

    cmp $0x0 , %r11
    jg HaveCircles_HW1

    cmp $0x0 , %r12
    jg HaveCircles_HW1


    jmp NoCircles_HW1


DeleteVertice_HW1:

    #### %rax has the pointer to delete the vertice
    movq $vertices , %rbx

    ###Delete the in degree of the vertice

    cmpq %rax , (%rbx)
    jne Case2
    movq $-1 , %r8
Case2:
    cmpq %rax , 8(%rbx)
    jne Case3
    movq $-1 , %r9
Case3:
    cmpq %rax , 16(%rbx)
    jne Case4
    movq $-1 , %r10
Case4:
    cmpq %rax , 24(%rbx)
    jne Case5
    movq $-1 , %r11
Case5:
    cmpq %rax , 32(%rbx)
    jne LoopRemoveEdgeOfDeleted_HW1
    movq $-1 , %r12


LoopRemoveEdgeOfDeleted_HW1:

    ## check if i reached null in the edges array of deleted vertice
    cmpq $0 , (%rax)
    je FindSource_HW1


    movq (%rax) , %r15
    cmpq %r15 , (%rbx)
    jne DecSecondVerticeInDegree_HW1
    dec %r8
    jmp EndLoopRemoveEdgeOfDeleted_HW1

DecSecondVerticeInDegree_HW1:
    cmpq %r15 , 8(%rbx)
    jne DecThirdVerticeInDegree_HW1
    dec %r9
    jmp EndLoopRemoveEdgeOfDeleted_HW1

DecThirdVerticeInDegree_HW1:
    cmpq %r15 , 16(%rbx)
    jne DecFourthVerticeInDegree_HW1
    dec %r10
    jmp EndLoopRemoveEdgeOfDeleted_HW1

DecFourthVerticeInDegree_HW1:
    cmpq %r15 , 24(%rbx)
    jne DecFiveVerticeInDegree_HW1
    dec %r11
    jmp EndLoopRemoveEdgeOfDeleted_HW1

DecFiveVerticeInDegree_HW1:
    cmpq %r15 , 32(%rbx)
    jne DecFiveVerticeInDegree_HW1
    dec %r12
    jmp EndLoopRemoveEdgeOfDeleted_HW1


EndLoopRemoveEdgeOfDeleted_HW1:
    addq $8 , %rax
    jmp LoopRemoveEdgeOfDeleted_HW1



HaveCircles_HW1:
    movb $0x1 , (circle)
    jmp End_HW1

NoCircles_HW1:
    movb $-1 , (circle)

End_HW1:



#your code here
