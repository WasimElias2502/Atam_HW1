.global _start

.section .text
_start:
#your code here
    movb (character) , %al

    #



    #switch case

    cmpb $0x7F , %al
    je NotInTable_HW1

    cmpb $0x7B , %al
    jge RightSideOfTable_HW1

    cmpb $0x61 , %al
    jge SmallLetter_HW1

    cmpb $0x60 , %al
    je TavUpperPsek_HW1

    cmpb $0x5F , %al
    je RightSideOfTable_HW1

    cmpb $0x5E , %al
    je RightSideOfTable_HW1

    cmpb $0x5D , %al
    je TavClosedSquareBracket_HW1

    cmpb $0x5C , %al
    je  TavBackSlash_HW1

    cmpb $0x5B , %al
    je  TavOpenSquareBracket_HW1


    cmpb $0x3E , %al
    jge  RightSideOfTable_HW1

    cmpb $0x3D , %al
    je  TavEqual_HW1

    cmpb $0x3C , %al
    je  RightSideOfTable_HW1

    cmpb $0x3B , %al
    je  TavNkodaPsek_HW1



    cmpb $0x3A , %al
    je  RightSideOfTable_HW1

    cmpb $0x39 , %al
    je  Nine_HW1

    cmpb $0x38 , %al
    je  Eight_HW1

    cmpb $0x37 , %al
    je  Seven_HW1

    cmpb $0x36 , %al
    je  Six_HW1

    cmpb $0x35 , %al
    je  Five_HW1

    cmpb $0x34 , %al
    je  Four_HW1

    cmpb $0x33 , %al
    je  Three_HW1

    cmpb $0x32 , %al
    je  Two_HW1

    cmpb $0x31 , %al
    je  One_HW1

    cmpb $0x30 , %al
    je  Zero_HW1

    ####

    cmpb $0x2F , %al
    je  TavFrontSlash_HW1

    cmpb $0x2E , %al
    je  TavDot_HW1

    cmpb $0x2D , %al
    je  TavDash_HW1

    cmpb $0x2C , %al
    je  TavComma_HW1

    cmpb $0x28 , %al
    jge  RightSideOfTable_HW1

    cmpb $0x27 , %al
    je  TavApostrophe_HW1

    cmpb $0x21 , %al
    jge  RightSideOfTable_HW1


    jmp NotInTable_HW1

    ##########
    Zero_HW1:
    movb $0x29 , %al
    jmp exit_HW1

    One_HW1:
    movb $0x21 , %al
    jmp exit_HW1

    Two_HW1:
    movb $0x40 , %al
    jmp exit_HW1

    Three_HW1:
    movb $0x23 , %al
    jmp exit_HW1

    Four_HW1:
    movb $0x24 , %al
    jmp exit_HW1

    Five_HW1:
    movb $0x25 , %al
    jmp exit_HW1

    Six_HW1:
    movb $0x5E , %al
    jmp exit_HW1

    Seven_HW1:
    movb $0x26 , %al
    jmp exit_HW1

    Eight_HW1:
    movb $0x2A , %al
    jmp exit_HW1

    Nine_HW1:
    movb $0x28 , %al
    jmp exit_HW1

    TavUpperPsek_HW1:
    movb $0x7E , %al
    jmp exit_HW1

    TavDash_HW1:
    movb $0x5F , %al
    jmp exit_HW1

    TavEqual_HW1:
    movb $0x2B , %al
    jmp exit_HW1

    TavOpenSquareBracket_HW1:
    movb $0x7B , %al
    jmp exit_HW1

    TavClosedSquareBracket_HW1:
    movb $0x7D , %al
    jmp exit_HW1

    TavNkodaPsek_HW1:
    movb $0x3A , %al
    jmp exit_HW1

    TavApostrophe_HW1:
    movb $0x22 , %al
    jmp exit_HW1

    TavBackSlash_HW1:
    movb $0x7C , %al
    jmp exit_HW1

    TavComma_HW1:
    movb $0x3C , %al
    jmp exit_HW1

    TavDot_HW1:
    movb $0x3E , %al
    jmp exit_HW1

    TavFrontSlash_HW1:
    movb $0x3F , %al
    jmp exit_HW1

    SmallLetter_HW1:
    subb $0x20 , %al
    jmp exit_HW1

    RightSideOfTable_HW1:
    jmp exit_HW1

    NotInTable_HW1:
    movb $0xFF , %al
    jmp exit_HW1

    exit_HW1:
    movb %al , (shifted)



