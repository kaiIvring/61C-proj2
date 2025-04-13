.globl argmax

.text
# =================================================================
# FUNCTION: Given a int array, return the index of the largest
#   element. If there are multiple, return the one
#   with the smallest index.
# Arguments:
#   a0 (int*) is the pointer to the start of the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   a0 (int)  is the first index of the largest element
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# =================================================================
argmax:
    # Prologue
    li t0, 1
    blt a1, t0, error_code36
    
    mv t1, a0    # t1 = current address
    li t2, 0     # t2 = current index
    li t3, 0     # t3 = max index
    lw t4, 0(t1) # t4 = max value 

    addi t2, t2, 1 # start from index 1
    addi t1, t1, 4 # move pointer to index 1

loop_start:
    beq t2, a1, loop_end # if current index == size, stop

    lw t5, 0(t1)         # load value at current index
    slt t6, t4, t5       # t6 = 1 if t4 < t5
    beq t6, x0, loop_continue # update max index only when t4 < t5
    mv t3, t2            # update max index
    mv t4, t5            # update max value

loop_continue:
    addi t2, t2, 1
    addi t1, t1, 4
    j loop_start
    

loop_end:
    # Epilogue
    mv a0, t3
    jr ra

error_code36:
    li a0, 36
    j exit
