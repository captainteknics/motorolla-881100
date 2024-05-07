; Assembly code for compression routine

; Define constants and variables

section .data
    INPUT_TEXT:     .long 0x12345678    ; Address of input text
    OUTPUT_BUF:     .long 0x87654321    ; Address of compressed output buffer
    STACK_SIZE:     equ 60000           ; Size of stack

section .text
    global _start

; Main program entry point
_start:
    ; Initialize stack pointer
    LEA r30, STACK_SIZE

    ; Pointer to input text
    LEA r10, INPUT_TEXT

    ; Pointer to compressed output buffer
    LEA r11, OUTPUT_BUF

    ; Store input text pointer for later
    PUSH r10

    ; Initialization of variables
    mov r12, 0          ; Initialize current character
    mov r13, 0          ; Initialize repetition count

    ; Compression loop
COMPRESS_LOOP:
    ld.b r12, r10, 0    ; Load current character

    ; Check if the previous character is the same, update count
    cmp r12, r11
    beq SAME_CHARACTER
    ; Different character, store count and character to OUTPUT_BUF
    st.b r11, r13, 0
    st.b r11, r12, 1
    ; Reset repetition count
    mov r13, 1
    ; Update current character
    mov r12, r11
    ; Move to next character in input text
    add r10, r10, 1
    ; Compare with end of input text
    cmp r10, END_INPUT_TEXT
    bne COMPRESS_LOOP
    ; Store any remaining characters or metadata
    st.b r11, r13, 0
    ; End compression routine
    POP r10
    stop

SAME_CHARACTER:
    ; Increment repetition count
    add r13, r13, 1
    ; Move to next character in input text
    add r10, r10, 1
    ; Compare with end of input text
    cmp r10, END_INPUT_TEXT
    bne COMPRESS_LOOP
    ; Store any remaining characters or metadata
    st.b r11, r13, 0
    ; End compression routine
    POP r10
    stop

; Define end of input text
END_INPUT_TEXT:
    .long 0x0
