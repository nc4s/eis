section .data
    newline db 10

section .text
    global print_string
    global error_string

; Helper: Writes a string to a specific FD
; Expects: RDI = File Descriptor, RSI = String Pointer
_write_string_helper:
    cld             ; Ensure DF flag is 0 (scan forward)
    push rdi        ; Save FD
    push rsi        ; Save String Pointer

    ; 1. Calculate length using 'scasb'
    mov rdi, rsi    ; RDI must point to the string for scasb
    xor al, al      ; Search for 0
    mov rcx, -1     ; Set RCX to max
    repne scasb     ; Scan until null terminator
    
    not rcx
    dec rcx         ; RCX now holds the length
    mov rdx, rcx    ; Move length to RDX
    
    ; 2. Call sys_write (the string)
    pop rsi         ; Restore string pointer
    pop rdi         ; Restore FD
    mov rax, 1      ; sys_write
    syscall

    ; 3. Print the newline
    mov rdx, 1
    lea rsi, [rel newline]
    mov rax, 1      ; sys_write
    syscall
    
    ret

; Public Functions (The Wrappers)
print_string:
    mov rsi, rdi    ; Move the pointer (from RDI) into RSI
    mov rdi, 1      ; Set FD to stdout
    jmp _write_string_helper

error_string:
    mov rsi, rdi    ; Move the pointer (from RDI) into RSI
    mov rdi, 2      ; Set FD to stderr
    jmp _write_string_helper

section .note.GNU-stack noalloc noexec nowrite progbits