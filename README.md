# motorolla-881100

#+254715560734
#captainteknics@gmail.com

This project aims to develop and demonstrate a simplified text compression and decompression algorithm implementation in assembly language for the Motorola 88110 processor. The focus is on understanding the fundamental concepts of lossless compression techniques and gaining practical experience in assembly programming


User Manual
Purpose:
Provides instructions on how to use the assembly code routines for text compression and decompression.
System Requirements:
Motorola 88110 processor (or an emulator capable of running 88110 code)
Sufficient memory for input text, output buffers, and the program code.
Assumptions:
Users have a basic understanding of assembly language and memory addressing principles.
Usage:
Assemble the Code: Use an assembler for the Motorola 88110 architecture to translate the provided assembly code into machine-executable code.


Load the Code: Load the assembled code into the memory  system.


Set Memory Addresses:


Update the INPUT_TEXT and OUTPUT_BUF addresses in the data section to point to the desired locations in memory where your input text and compressed output will reside.
Do the same for COMPRESSED_TEXT and OUTPUT_TEXT for the decompression routine.
Execute Compression:


Initiate the compression routine (e.g., by calling its label in your program flow).
The compressed output will be placed in the memory area designated by the OUTPUT_BUF address.
Execute Decompression:


Initiate the decompression routine.
Ensure the COMPRESSED_TEXT address points to your compressed data.
The restored original text will be placed in the memory area designated by the OUTPUT_TEXT address.
Example:
Code snippet
; ... Other parts  program ...

; Compression:
    LEA r10, MY_INPUT_TEXT  ; Set input text address 
    LEA r11, MY_OUTPUT_BUF  ; Set output buffer address
    bsr COMPRESS            ; Call compression subroutine

; Decompression:
    LEA r10, MY_COMPRESSED_DATA ; Set compressed input address
    LEA r11, MY_OUTPUT_TEXT    ; Set output text address
    bsr DECOMPRESS              ; Call decompression subroutine

; ... Rest  program ...


Important Notes:
The code implements a simplified run-length encoding compression scheme. More complex text compression algorithms can be significantly more involved.


The code does not include error handling or input validation.


Test Plan
Objective:
Verify the compression and decompression routines correctly encode and decode text data.
Test Cases:
Basic Functionality:
Input Text: "AAABBBCCCD"
Expected Compressed Output: "3A3B3C1D"
Single Character Repetition:
Input Text: "ABBBC"
Expected Compressed Output: "1A3B1C"
Mixed Long and Short Runs:
Input Text: "AAABBBAACCC"
Expected Compressed Output: "3A3B2A3C"
No Repetitions:
Input Text: "ABCDEFG"
Expected Compressed Output: "ABCDEFG" (or similar, depending on metadata handling)
Empty Input:
Input Text: ""
Expected Compressed Output: Empty (or metadata-only)
Procedure:
Assemble and load the code into the target system or emulator.


For each test case:


Set up the input text in memory.
Execute the compression routine.
Compare the compressed output with the expected result.
Execute the decompression routine on the compressed output.
Compare the decompressed output with the original input text.
Evaluation Criteria:
The compression and decompression routines should produce correct results for all test cases.
Demonstration of the Project
Setup:


Choose an assembler and emulator (if needed) for the Motorola 88110 architecture.
Assemble the provided code.

Execution:


Load the assembled code into memory.
Set the input and output addresses.
Step through the execution of the compression and decompression routines in a debugger (if available), observing register changes and memory contents.
Verification:


Examine the compressed output and compare it to the expected result based on the test plan.
Examine the decompressed output and ensure it matches the original input.


