.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
#   a0 (int*) is the pointer to the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   None
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# ==============================================================================
relu:
    # Prologue
    li t0, 1
    blt a1, t0, error_code36
    
    mv t1, a0 # t1 = base address
    mv t2, a1 # t2 = counter
    
loop_start:
    beq t2, x0, loop_end
    
    lw t3, 0(t1)
    bge t3, x0, loop_continue
    sw x0, 0(t1)

loop_continue:
    addi t1, t1, 4
    addi t2, t2, -1
    j loop_start

loop_end:

    # Epilogue

    jr ra

error_code36:
    li a0, 36
    j exit