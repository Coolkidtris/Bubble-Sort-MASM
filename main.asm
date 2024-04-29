.686                                                                                ; Architecture
.model flat, stdcall                                                                ; Calling convention
option casemap: none                                                                ; No case sensitivity

.nolist                                          
include \masm32\include\kernel32.inc                                                ; Include MASM32 .INC Files
include \masm32\include\masm32.inc

includelib \masm32\lib\kernel32.lib                                                 ; Include MASM32 libraries
includelib \masm32\lib\masm32.lib

.list                                                                               ; Where the Listing file starts

.data                                                                               ; Initialised Data
ARRAY               WORD 42h, 44h, 41h, 43h, 47h, 46h, 45h,0                        ; Our array in Hex, representing the string 'ABCDEFG'
ARRAY_SIZE  =       lengthof ARRAY-1                                                ; The length of our array for our loop counter  

.data?
TEMP                WORD ?

.code
end MAIN                                                                            ; Set our entry point to MAIN

BUBBLE_SORT PROC                                                                    ; Start of our bubble sort algorithm
    mov cx, ARRAY_SIZE                                                              ; Move the size of our array into our Outer Loop Counter
    L1:
        mov esi, OFFSET ARRAY                                                       ; Move a reference to ARRAY into ESI
        mov bx, ARRAY_SIZE-1                                                        ; Move the size of our array into our Inner Loop Counter
        L2:
            mov ax, [esi]                                                           ; Move the current item into AX
            cmp ax, [esi+2]                                                         ; Compare it to the next index
            jl CONTINUE_L2                                                          ; If AX is smaller, then no swap is needed, so jump to incrementing the loop

            mov dx, [esi+2]                                                         ; Use DX as a temporary register to store the next index
            mov [esi+2], ax                                                         ; Move AX (which holds the current index) into the next index
            mov [esi], dx                                                           ; Move DX (which holds the next index) into the current index

        CONTINUE_L2:
            add esi, 2                                                              ; Add 2 to ESI to move to the next index
            dec bx                                                                  ; Decrement the Inner Loop Counter
            jnz L2                                                                  ; If its not, then loop back to the Inner loop

        dec cx                                                                      ; Once the Inner Loop is finished, decrement the outer loop
        jnz L1                                                                      ; Loop the Outer Loop until it reachers 0 (its finished)
    ret                                                                             ; Return back to where the function was called
BUBBLE_SORT ENDP

LOOP_ARRAY PROC                                                                     ; Start of our algorithm to loop and print the contents of ARRAY
    mov cx, ARRAY_SIZE                                                              ; Move the size of the array into the loop counter, CX  
    mov esi, OFFSET ARRAY                                                           ; Move a reference to our now sorted array
    L1:
        mov ax, [esi]                                                               ; Move the current index to AX
        mov TEMP, ax                                                                ; Move that into a temporary variable

        push ecx                                                                    ; Preserve ECX as StdOut modifies it
        invoke StdOut, addr TEMP                                                    ; Output the current index
        pop ecx                                                                     ; Restore ECX

        add esi, 2                                                                  ; Go to the next index
        loop L1                                                                     ; Loop throughout the array

    ret
LOOP_ARRAY ENDP

MAIN PROC                                                                           ; Start of our MAIN function
    call BUBBLE_SORT                                                                ; Sort our array

    call LOOP_ARRAY                                                                 ; Output our array

invoke ExitProcess, 0                                                               ; Exit the program
MAIN ENDP
