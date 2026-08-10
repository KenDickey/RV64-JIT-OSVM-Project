## Use a constant register allows to load a 32-bit constant
## upper bit set => 3 instructions to mask out sign extend.
## else just 2 instructions.
## if lower-12 bits have high bit set, add 1 to upper-20.
#
## gcc -g -march=rv64g -mabi=lp64d -lc const32.s -o const32
## gcc -g -march=rv64g -mabi=lp64d -lc const32.s -c -o const32.o
## objdump -D const32.o > const32.dasm
.section .rodata
result_out: .asciz "Result = 0x%lx\n"

.section .text
.global main
main:
    addi    sp, sp, -32     # Allocate 32 bytes from the stack
    sd      ra, 0(sp)       # Since we are making calls, we need the original ra

    # The result needs to be
    # the second parameter to printf.

    li      s0,0xFFFFFFFF00000000 #dedicated register
 
    la      a0,result_out
    lui     a1,0xFADED   # Notas Bene: Sign extended
##  addi    a1,a1,0xAFE  # gcc/clang claim illegal opcode
    addi    a1,a1,0x2FE  ##Change 0x2 to 0xA via HexEdit
    xor     a1,a1,s0     # mask out sign extend of upper20
    call    printf

##As above:
# Result = 0xfaded2fe
##Change 0x2 to 0xA in the executable via HexEdit
## to get full 12 bit immediate.
# Result = 0xfadecafe

    # Restore original RA and return
    ld      ra, 0(sp)
    addi    sp, sp, 32       # Always deallocate the stack!
    ret
	
