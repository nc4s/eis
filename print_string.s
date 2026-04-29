; a function to print a string and then a newline

section .data
    newline db 10

section .text
    global print_string

print_string:
    ; Input: rdi contains the pointer to the string (char*)
    
    ; Calculate the string length
    push rdi          ; Save the pointer to the string
    xor rdx, rdx      ; Clear rdx (we will use this as the length counter)
    mov rcx, rdi      ; Copy pointer to rcx for iteration

.length_loop:
    cmp byte [rcx], 0 ; Check if current byte is null
    je .write_syscall ; If null, jump to write
    inc rcx           ; Move to next char
    inc rdx           ; Increment length counter
    jmp .length_loop

.write_syscall:
    ; Call sys_write
    ; rax = 1 (sys_write)
    ; rdi = 1 (stdout)
    ; rsi = original pointer (restored from stack)
    ; rdx = length (calculated above)
    
    pop rsi           ; Restore the pointer to rsi (buffer)
    mov rax, 1        ; System call number for sys_write
    mov rdi, 1        ; File descriptor 1 (stdout)
    syscall           ; Invoke kernel

    ; Print the newline character
    mov rax, 1        ; sys_write
    mov rdi, 1        ; stdout
    lea rsi, [rel newline]  ; Pointer to the newline character into rsi
    mov rdx, 1        ; Length of 1 byte
    syscall
    
    ret

section .note.GNU-stack noalloc noexec nowrite progbits