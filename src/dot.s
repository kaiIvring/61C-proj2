.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int arrays
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the number of elements to use
#   a3 (int)  is the stride of arr0
#   a4 (int)  is the stride of arr1
# Returns:
#   a0 (int)  is the dot product of arr0 and arr1
# Exceptions:
#   - If the number of elements to use is less than 1,
#     this function terminates the program with error code 36
#   - If the stride of either array is less than 1,
#     this function terminates the program with error code 37
# =======================================================
dot:
    li t0, 1
    blt a2, t0, error_code36
    blt a3, t0, error_code37
    blt a4, t0, error_code37
    # Prologue
    mv t5, a0       # arr0 pointer 
    mv t6, a1       # arr1 pointer
    li t0, 0        # to = sum

    slli t3, a3, 2  # stride0 (bytes)
    slli t4, a4, 2  # stride1 (bytes)

loop_start:
    beq a2, x0, loop_end
    lw t1, 0(t5)    # t1 = arr0[i]
    lw t2, 0(t6)    # t2 = arr1[i]
    mul t1, t1, t2
    add t0, t0, t1

    add t5, t5, t3  # arr0++
    add t6, t6, t4  # arr1++
    addi a2, a2, -1
    j loop_start

loop_end:
    mv a0, t0
    jr ra

error_code36:
    li a0, 36
    j exit

error_code37:
    li a0, 37
    j exit