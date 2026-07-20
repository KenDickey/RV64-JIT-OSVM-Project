## gcc -g -march=rv64g -mabi=lp64d -lc immedLong.s -o immedLong
.section .rodata
expect: .asciz "Expect immediate: 0x2222203711111037 \n"
result_out: .asciz "Result = 0x%lx\n"

.section .text
.global main
main:
    addi    sp, sp, -32     # Allocate 32 bytes from the stack
    sd      ra, 0(sp)       # Since we are making calls, we need the original ra

    la      a0, expect 
    call    printf

    # The result needs to be
    # the second parameter to printf.
    la      a0, result_out
	auipc   a2,0		# capture pc-addr
	ld	a1,12(a2)	# load immediate (pc-addr + 3-instructions)
	jalr	x0,a2,16	# jump ahead 2 instructions
	lui	x0,0x11111	# immediate word (low)
	lui	x0,0x22222	# immediate word (high)
    call    printf
##	Result = 2222203711111037

    # Restore original RA and return
    ld      ra, 0(sp)
    addi    sp, sp, 32       # Always deallocate the stack!
    ret
	
