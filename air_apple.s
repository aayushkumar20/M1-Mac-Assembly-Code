.global _start

.section .data
app_name:   .asciz "\n=== Air Apple ===\n"
menu:       .asciz "1. Allocate Seat\n2. Cancel Ticket\n3. Exit\n"
prompt:     .asciz "Select an option: "
seat_alloc: .asciz "Seat allocated successfully!\n"
cancel_tkt: .asciz "Ticket cancelled successfully!\n"
full:       .asciz "No seats available!\n"
notfound:   .asciz "Ticket not found!\n"

.section .bss
    .lcomm seats, 10       // Array for 10 seats (0: available, 1: allocated)

.section .text
_start:
    // Display application name
    ldr x0, =app_name
    bl print_string

main_loop:
    // Print menu
    ldr x0, =menu
    bl print_string

    // Print prompt
    ldr x0, =prompt
    bl print_string

    // Get user input
    bl get_user_input

    // Check input and branch to appropriate subroutine
    cmp w0, #1
    beq allocate_seat
    cmp w0, #2
    beq cancel_ticket
    cmp w0, #3
    beq exit_program
    b main_loop

allocate_seat:
    // Allocate a seat
    bl allocate_seat_sub
    b main_loop

cancel_ticket:
    // Cancel a ticket
    bl cancel_ticket_sub
    b main_loop

exit_program:
    // Exit the program (system call to exit)
    mov x0, #0  // Exit code 0
    mov x8, #93 // syscall number for exit
    svc #0

// Subroutines
allocate_seat_sub:
    // Find first available seat
    ldr x1, =seats
    mov w2, #0

alloc_loop:
    ldrb w3, [x1, w2, uxtw]
    cmp w3, #0
    beq alloc_seat_found
    add w2, w2, #1
    cmp w2, #10
    bne alloc_loop

    // No seats available
    ldr x0, =full
    bl print_string
    ret

alloc_seat_found:
    // Allocate the seat
    mov w3, #1
    strb w3, [x1, w2, uxtw]
    ldr x0, =seat_alloc
    bl print_string
    ret

cancel_ticket_sub:
    // Find an allocated seat to cancel
    ldr x1, =seats
    mov w2, #0

cancel_loop:
    ldrb w3, [x1, w2, uxtw]
    cmp w3, #1
    beq cancel_ticket_found
    add w2, w2, #1
    cmp w2, #10
    bne cancel_loop

    // Ticket not found
    ldr x0, =notfound
    bl print_string
    ret

cancel_ticket_found:
    // Cancel the ticket
    mov w3, #0
    strb w3, [x1, w2, uxtw]
    ldr x0, =cancel_tkt
    bl print_string
    ret

// Utility Functions
print_string:
    mov x1, x0          // String address
    mov x2, #100        // Length (adjust as needed)
    mov x0, #1          // File descriptor (stdout)
    mov x8, #64         // syscall number for write
    svc #0
    ret

get_user_input:
    mov x1, sp          // Buffer for input
    mov x2, #10         // Length (adjust as needed)
    mov x0, #0          // File descriptor (stdin)
    mov x8, #63         // syscall number for read
    svc #0
    ldrb w0, [sp]       // Read first byte of input
    sub w
