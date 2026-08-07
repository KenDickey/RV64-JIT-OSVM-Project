## gcc -g -march=rv64g -mabi=lp64d -lc immed12.s -o immed12
## gcc -g -march=rv64g -mabi=lp64d -lc immed12.s -c -o immed12.o
## objdump -D immed12.o > immed12.dasm
.section .rodata
expect: .asciz "Expect immediate: 0x2222203711111037 \n"
result_out: .asciz "Result = 0x%lx\n"

.section .text
.global main
main:
    addi    sp, sp, -32     # Allocate 32 bytes from the stack
    sd      ra, 0(sp)       # Since we are making calls, we need the original ra

#    la      a0, expect 
#    call    printf

    # The result needs to be
    # the second parameter to printf.

    la      a0, result_out
    li	    a1,0xFADECAFE
    call    printf

    la      a0, result_out
    li      s0,0xFFFFFFFF00000FFF #dedicated register
    lui	    a1,0xFADEC 
    ori     a1,a1,0x501 ## (0xFFF xor 0xAFE)
    xor     a1,a1,s0
    call    printf

    la      a0, result_out
    lui	    a1,0x0FADE  # avoid setting high bit 
    slli    a1,a1,4
    lui     a2,0x0CAFE # so no sign extend
    srli    a2,a2,12
    xor     a1,a1,a2
    call    printf

    la      a0, result_out
    lui	    a1,0x12341
    xori    a1,a1,0x234
    call    printf

    la      a0, result_out
    li	    a1,0xDEADBEEF
    call    printf

    la      a0, result_out
    li      s0,0xFFFFFFFF00000FFF #dedicated register
    lui	    a1,0xDEADB 
    ori     a1,a1,0x110 ## (0xFFF xor 0xEEF)
    xor     a1,a1,s0
    call    printf

    la      a0, result_out
    li	    a1,0x12341234
    call    printf

#Result = 0xfadecafe
#Result = 0xfadecafe
#Result = 0xfadecafe
#Result = 0x12341234
#Result = 0xdeadbeef
#Result = 0xdeadbeef
#Result = 0x12341234

    # Restore original RA and return
    ld      ra, 0(sp)
    addi    sp, sp, 32       # Always deallocate the stack!
    ret
	
