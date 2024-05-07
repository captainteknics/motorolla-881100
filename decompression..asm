; Assembly code for decompression routine

; Define constants and variables

section .data
    COMPRESSED_TEXT:    .long 0xAABBCCDD     ; Address of compressed text
    OUTPUT_TEXT:        .long 0xDDCCBBAA     ; Address of decompressed output text
    STACK_SIZE:         equ 60000           ; Size of stack

section .text
    global _start

; Main program entry point
_start:
    ; Initialize stack pointer
    LEA r30, STACK_SIZE

    ; Pointer to compressed text
    LEA r10, COMPRESSED_TEXT

    ; Pointer to decompressed output text
    LEA r11, OUTPUT_TEXT

    ; Initialization of variables for reading compressed text
    mov r12, 0          ; Initialize current character
    mov r13, 0          ; Initialize repetition count
    mov r14, 0          ; Initialize flag for regular character

    ; Decompression loop
DECOMPRESS_LOOP:
    ld.b r12, r10, 0    ; Load current character from compressed text

    ; Check if character is numeric (repetition count)
    cmp r12, '0'
    blt REGULAR_CHARACTER
    cmp r12, '9'
    bgt REGULAR_CHARACTER

    ; Convert character to number
    sub r12, r12, '0'
    ; Update repetition count
    mul r13, r13, 10
    add r13, r13, r12

    ; Move to next character in compressed text
    add r10, r10, 1
    ; Compare against end of compressed text
    cmp r10, END_COMPRESSED_TEXT
    bne DECOMPRESS_LOOP

    ; Repeat the character in OUTPUT_TEXT
    REPEAT_CHARACTER:
        ; Store regular character
        st.b r14, r11, r0
        ; Decrease repetition count
        sub r13, r13, 1
        ; Move to next location in output text
        add r11, r11, 1
        ; Check if repetition count is zero
        cmp r13, 0
        bne REPEAT_CHARACTER

    ; End decompression routine
    stop

REGULAR_CHARACTER:
    ; Store regular character
    st.b r12, r11, 0
    ; Move to next character in compressed text
    add r10, r10, 1
    ; Move to next location in output text
    add r11, r11, 1
    ; Compare against end of compressed text
    cmp r10, END_COMPRESSED_TEXT
    bne DECOMPRESS_LOOP

    ; End decompression routine
    stop

; Define end of compressed text
END_COMPRESSED_TEXT:
    .long 0x0
