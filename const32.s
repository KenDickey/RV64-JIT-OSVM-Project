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

# 32-bit constant w high bit set -- sign extends
 
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

# Get -1 in a register w 1 instruction

    la      a0,result_out
    addi    a1,x0,0x7FF  ##Change 0x7 to 0xF
    call    printf

# Result = 0xffffffffffffffff

    # Restore original RA and return
    ld      ra, 0(sp)
    addi    sp, sp, 32       # Always deallocate the stack!
    ret
	
